import SwiftUI

struct VideoTabView: View {
    @ObservedObject var viewModel: VideoTabViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .leading),
        GridItem(.flexible(), spacing: 16, alignment: .topLeading)
    ]

    init(viewModel: VideoTabViewModel = VideoTabViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                Text("Videos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                    ForEach(viewModel.videos) { video in
                        VideoCardView(video: video)
                    }
                }
                .padding()
            }
            .padding(.vertical)
        }
    }
}

private struct VideoCardView: View {
    let video: VideoItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VideoThumbnail(url: video.thumbnailURL)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            Text(video.title)
                .font(.headline)
                .foregroundStyle(Color.primary)
                .lineLimit(2)

            HStack(spacing: 12) {
                AsyncImage(url: video.avatarURL) { phase in
                    switch phase {
                    case .empty:
                        Circle()
                            .fill(Color(.systemGray5))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Circle()
                            .fill(Color(.systemGray5))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.secondary)
                            )
                    @unknown default:
                        Circle()
                            .fill(Color(.systemGray5))
                    }
                }
                .frame(width: 36, height: 36)
                .clipShape(Circle())

                Text(video.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct VideoThumbnail: View {
    let url: URL

    var body: some View {
        ZStack {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Color(.systemGray5)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Color(.systemGray5)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                        )
                @unknown default:
                    Color(.systemGray5)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .clipped()

            Circle()
                .fill(Color.black.opacity(0.45))
                .frame(width: 52, height: 52)
                .overlay(
                    Image(systemName: "play.fill")
                        .foregroundStyle(.white)
                        .font(.title2)
                )
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemGray5))
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
