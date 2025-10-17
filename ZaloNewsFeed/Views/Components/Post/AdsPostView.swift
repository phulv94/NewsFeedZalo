import SwiftUI

struct AdsPostView: View {
    let post: AdsPost
    var action: () -> Void = {}

    var body: some View {
        VStack(alignment: .trailing, spacing: 16.0) {
            header
            content
            footer
        }
        .padding()
        .background(.white)
        .frame(maxWidth: .infinity)
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            CachedAsyncImage(url: post.advertiserAvatarURL, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .empty:
                    ProgressView()
                        .tint(.secondary)
                case .failure:
                    Image(systemName: "briefcase.circle")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 48, height: 48)
            .background(Color(.systemGray5))
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 0) {
                Text(post.advertiserName)
                    .font(.headline)
                    .foregroundStyle(Color.primary)

                Text("Sponsored")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageURL = post.imageURL {
                RemoteAdMediaView(url: imageURL, height: 220, cornerRadius: 16)
            }
            Text(post.contentText)
                .font(.body)
                .foregroundStyle(Color.primary)
        }
    }

    private var footer: some View {
        Button(action: action) {
            Text(post.actionTitle)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.blue)
                )
        }
        .buttonStyle(.plain)
    }
}

private struct RemoteAdMediaView: View {
    let url: URL
    var height: CGFloat?
    var cornerRadius: CGFloat = 0

    var body: some View {
        CachedAsyncImage(url: url, transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty:
                placeholderView(symbolName: "photo")
            case .failure:
                placeholderView(symbolName: "exclamationmark.triangle")
            @unknown default:
                placeholderView(symbolName: "photo")
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .clipped()
    }

    @ViewBuilder
    private func placeholderView(symbolName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color(.systemGray6))

            Image(systemName: symbolName)
                .font(.title2)
                .foregroundStyle(.secondary)
        }
    }
}

struct AdsPostView_Previews: PreviewProvider {
    static var previews: some View {
        AdsPostView(
            post: AdsPost(
                advertiserName: "SwiftUI Courses",
                advertiserAvatarURL: URL(string: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200"),
                contentText: "Level up your SwiftUI skills with our hands-on courses and real-world projects.",
                imageURL: URL(string: "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200"),
                actionTitle: "Learn More"
            )
        )
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color(.systemGroupedBackground))
    }
}
