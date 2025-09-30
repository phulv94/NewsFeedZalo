import SwiftUI

struct StorySectionView: View {
    let stories: [Story]
    var onStoryTap: (Story) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Stories")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(stories) { story in
                        StoryCell(story: story) {
                            onStoryTap(story)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct StoryCell: View {
    let story: Story
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: story.thumbnailURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Color.gray.opacity(0.3)
                    } else {
                        Color.gray.opacity(0.1)
                    }
                }
                .frame(width: 110, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                )

                VStack(alignment: .leading, spacing: 8) {
                    AsyncImage(url: story.avatarURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Color.gray.opacity(0.3)
                        } else {
                            Color.gray.opacity(0.1)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 3)
                    )

                    Text(story.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .shadow(radius: 6)
                }
                .padding(12)
            }
        }
        .buttonStyle(.plain)
    }
}

struct StorySectionView_Previews: PreviewProvider {
    static let demoStories: [Story] = [
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

    static var previews: some View {
        StorySectionView(stories: demoStories)
            .padding(.vertical)
            .previewLayout(.sizeThatFits)
            .background(Color(.systemBackground))
    }
}
