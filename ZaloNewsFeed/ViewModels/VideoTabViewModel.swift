import Foundation

final class VideoTabViewModel: ObservableObject {
    @Published var videos: [VideoItem]

    private let dataManager: FeedDataManager

    init(dataManager: FeedDataManager = .shared) {
        self.dataManager = dataManager
        self.videos = dataManager.videoItems
    }

    private func loadVideos() {
        videos = dataManager.videoItems
    }
}
