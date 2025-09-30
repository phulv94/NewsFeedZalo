import Foundation

struct LinkPreview: Hashable {
    let title: String
    let description: String
    let url: String
    let imageURL: URL?
}

struct Post: Identifiable {
    let id = UUID()
    let createdAt: String
    let contentText: String?
    let imageURL: URL?
    let videoThumbnailURL: URL?
    let linkPreview: LinkPreview?
    let hashtags: [String]
    let mentions: [String]
}

struct UserActivity: Identifiable {
    let id = UUID()
    let userName: String
    let userAvatarURL: URL?
    let activeCount: Int
    let posts: [Post]
}

struct AdsPost: Identifiable {
    let id = UUID()
    let advertiserName: String
    let advertiserAvatarURL: URL?
    let contentText: String
    let imageURL: URL?
    let actionTitle: String
}

struct SuggestStory: Identifiable, Hashable {
    let id = UUID()
    let thumbnailURL: URL?

    init(thumbnail: String) {
        self.thumbnailURL = URL(string: thumbnail)
    }

    init(thumbnailURL: URL?) {
        self.thumbnailURL = thumbnailURL
    }
}

struct Story: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let avatarURL: URL
    let thumbnailURL: URL
}

struct VideoItem: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let avatarURL: URL
    let thumbnailURL: URL
}
