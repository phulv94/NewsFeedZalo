import Foundation

final class FeedDataManager {
    static let shared = FeedDataManager()

    let currentUserAvatarURL: URL?
    let storyPlaceholder: String
    let featuredStories: [Story]
    let activities: [UserActivity]
    let adsPost: AdsPost
    let suggestedStories: [SuggestStory]
    let videoItems: [VideoItem]

    private init() {
        currentUserAvatarURL = URL(string: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=200")
        storyPlaceholder = "What do you think"
        featuredStories = [
            Story(
                name: "Zalo Official",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=120&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1545239351-1141bd82e8a6?auto=format&fit=crop&w=400&q=80")!
            ),
            Story(
                name: "SwiftUI Lover",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=120&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=400&q=80")!
            ),
            Story(
                name: "iOS Dev",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=120&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=400&q=80")!
            ),
            Story(
                name: "Design Team",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=120&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=400&q=80")!
            )
        ]

        activities = [
            UserActivity(
                userName: "Linh Tran",
                userAvatarURL: URL(string: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=200"),
                activeCount: 4,
                posts: [
                    Post(
                        createdAt: "1 hour ago",
                        contentText: "Exploring SwiftUI layout techniques for our next release.",
                        imageURL: URL(string: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200"),
                        videoThumbnailURL: nil,
                        linkPreview: nil,
                        hashtags: ["SwiftUI", "iOS"],
                        mentions: ["team.design"]
                    ),
                    Post(
                        createdAt: "Yesterday",
                        contentText: "New design tokens landed in our system today!",
                        imageURL: nil,
                        videoThumbnailURL: URL(string: "https://images.unsplash.com/photo-1489515217757-5fd1be406fef?w=1200"),
                        linkPreview: nil,
                        hashtags: ["Design"],
                        mentions: []
                    )
                ]
            ),
            UserActivity(
                userName: "Hoang Nguyen",
                userAvatarURL: URL(string: "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?w=200"),
                activeCount: 3,
                posts: [
                    Post(
                        createdAt: "2 days ago",
                        contentText: "Check out this insightful article about async/await in Swift.",
                        imageURL: nil,
                        videoThumbnailURL: nil,
                        linkPreview: LinkPreview(
                            title: "Mastering Async/Await",
                            description: "A deep dive into structured concurrency in Swift.",
                            url: "https://example.com/articles/async-await",
                            imageURL: URL(string: "https://images.unsplash.com/photo-1556157382-97eda2d62296?w=800")
                        ),
                        hashtags: ["Swift", "Concurrency"],
                        mentions: ["swiftlang"]
                    )
                ]
            )
        ]

        adsPost = AdsPost(
            advertiserName: "Swift Academy",
            advertiserAvatarURL: URL(string: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200"),
            contentText: "Join our intensive SwiftUI bootcamp and ship beautiful apps faster.",
            imageURL: URL(string: "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200"),
            actionTitle: "Learn More"
        )

        suggestedStories = [
            SuggestStory(thumbnail: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600"),
            SuggestStory(thumbnail: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=601"),
            SuggestStory(thumbnail: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=602"),
            SuggestStory(thumbnail: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=603")
        ]

        videoItems = [
            VideoItem(
                title: "Design Trends 2024",
                author: "Mai Nguyen",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "SwiftUI Animations",
                author: "Tran Le",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1556157382-97eda2d62296?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Combine in Practice",
                author: "Anh Pham",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Modern iOS Architecture",
                author: "Linh Tran",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1545239351-1141bd82e8a6?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Debugging Tips",
                author: "Khoa Vo",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1517430816045-df4b7de11d1d?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Design Systems",
                author: "My Dang",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Mastering AsyncImage",
                author: "Tu Nguyen",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "WidgetKit Essentials",
                author: "Dat Bui",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1545239351-1141bd82e8a6?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1545239350-55e4641c1fc5?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "Concurrency Deep Dive",
                author: "Quynh Ly",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1523475472560-d2df97ec485c?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "ARKit in Production",
                author: "Bao Ha",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80")!
            ),
            VideoItem(
                title: "CI/CD for Swift Projects",
                author: "Son Truong",
                avatarURL: URL(string: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80")!,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1517430816045-df4b7de11d1d?auto=format&fit=crop&w=800&q=80")!
            )
        ]
    }
}
