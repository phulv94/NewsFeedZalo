import SwiftUI

struct SuggestStorySectionView: View {
    let stories: [SuggestStory]
    var onStoryTap: (SuggestStory) -> Void = { _ in }
    var onHeaderAction: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(stories) { story in
                        SuggestStoryCell(story: story) {
                            onStoryTap(story)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        .background(.white)
    }

    private var header: some View {
        HStack(spacing: 12) {
            Image(systemName: "play.rectangle.fill")
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 36, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.blue.opacity(0.12))
                )

            Text("Suggest Story")
                .font(.headline)
                .foregroundStyle(Color.primary)

            Spacer(minLength: 0)

            Button(action: onHeaderAction) {
                HStack(spacing: 4) {
                    Text("See all")
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .font(.subheadline)
                .foregroundStyle(.blue)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        
    }
}

struct SuggestStoryCell: View {
    let story: SuggestStory
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.systemGray6))

                if let url = story.thumbnailURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(.circular)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "video.slash")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "video.slash")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 140, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

struct SuggestStoryView: View {
    let stories: [SuggestStory]
    var onStoryTap: (SuggestStory) -> Void = { _ in }
    var onHeaderAction: () -> Void = {}

    var body: some View {
        SuggestStorySectionView(
            stories: stories,
            onStoryTap: onStoryTap,
            onHeaderAction: onHeaderAction
        )
    }
}

struct SuggestStorySectionView_Previews: PreviewProvider {
    static let sampleStories: [SuggestStory] = [
        SuggestStory(thumbnail: "https://picsum.photos/id/1015/200/300"),
        SuggestStory(thumbnail: "https://picsum.photos/id/1016/200/300"),
        SuggestStory(thumbnail: "https://picsum.photos/id/1018/200/300"),
        SuggestStory(thumbnail: "https://picsum.photos/id/1020/200/300"),
        SuggestStory(thumbnail: "https://picsum.photos/id/1024/200/300")
    ]

    static var previews: some View {
        SuggestStorySectionView(stories: sampleStories)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
