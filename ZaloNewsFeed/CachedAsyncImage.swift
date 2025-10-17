import SwiftUI
import CryptoKit
import UIKit

struct CachedAsyncImage<Content: View>: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    @StateObject private var loader = CachedAsyncImageLoader()

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        content(loader.phase)
            .task(id: url) {
                await loader.load(url: url, scale: scale, transaction: transaction)
            }
    }
}

private final class CachedAsyncImageLoader: ObservableObject {
    @Published private(set) var phase: AsyncImagePhase = .empty

    func load(url: URL?, scale: CGFloat, transaction: Transaction) async {
        if Task.isCancelled { return }

        guard let url else {
            await updatePhase(.empty, transaction: transaction)
            return
        }

        if let image = ImageCache.shared.image(for: url, scale: scale) {
            await updatePhase(.success(Image(uiImage: image)), transaction: transaction)
            return
        }

        await updatePhase(.empty, transaction: transaction)

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if Task.isCancelled { return }

            guard let uiImage = UIImage(data: data, scale: scale) else {
                throw URLError(.cannotDecodeContentData)
            }

            ImageCache.shared.store(image: uiImage, data: data, for: url)
            await updatePhase(.success(Image(uiImage: uiImage)), transaction: transaction)
        } catch {
            if Task.isCancelled { return }
            await updatePhase(.failure(error), transaction: transaction)
        }
    }

    @MainActor
    private func updatePhase(_ newPhase: AsyncImagePhase, transaction: Transaction) {
        if let animation = transaction.animation {
            withAnimation(animation) {
                phase = newPhase
            }
        } else {
            phase = newPhase
        }
    }
}

private final class ImageCache {
    static let shared = ImageCache()

    private let memoryCache = NSCache<NSURL, UIImage>()
    private let ioQueue = DispatchQueue(label: "CachedAsyncImage.ImageCache")
    private let directoryURL: URL

    private init() {
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let directory = cachesDirectory?.appendingPathComponent("CachedAsyncImage", isDirectory: true)
        if let directory {
            directoryURL = directory
            try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } else {
            directoryURL = FileManager.default.temporaryDirectory
        }
    }

    func image(for url: URL, scale: CGFloat) -> UIImage? {
        if let cached = memoryCache.object(forKey: url as NSURL) {
            return cached
        }

        var diskImage: UIImage?
        ioQueue.sync {
            let fileURL = cacheFileURL(for: url)
            if let data = try? Data(contentsOf: fileURL) {
                diskImage = UIImage(data: data, scale: scale)
            }
        }

        if let diskImage {
            memoryCache.setObject(diskImage, forKey: url as NSURL)
        }

        return diskImage
    }

    func store(image: UIImage, data: Data, for url: URL) {
        memoryCache.setObject(image, forKey: url as NSURL)

        ioQueue.async {
            let fileURL = self.cacheFileURL(for: url)
            do {
                try data.write(to: fileURL, options: .atomic)
            } catch {
                #if DEBUG
                print("CachedAsyncImage failed to write image to disk: \(error)")
                #endif
            }
        }
    }

    private func cacheFileURL(for url: URL) -> URL {
        let fileName = cacheFileName(for: url)
        return directoryURL.appendingPathComponent(fileName)
    }

    private func cacheFileName(for url: URL) -> String {
        if let data = url.absoluteString.data(using: .utf8) {
            let digest = SHA256.hash(data: data)
            return digest.compactMap { String(format: "%02x", $0) }.joined()
        }
        return url.lastPathComponent
    }
}
