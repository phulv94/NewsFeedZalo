import SwiftUI

struct CreatePostView: View {
    var avatarURL: URL?
    var placeholder: String = "What do you think"
    var onImagesTap: () -> Void = {}
    var onVideoTap: () -> Void = {}
    var onAlbumTap: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                CachedAsyncImage(url: avatarURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(Color(.systemGray3))
                    @unknown default:
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(Color(.systemGray3))
                    }
                }
                .frame(width: 48, height: 48)
                .background(Color(.systemGray5))
                .clipShape(Circle())

                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
            }

            HStack(spacing: 8) {
                CreateStoryActionButton(
                    title: "Images",
                    systemImage: "photo.on.rectangle",
                    tint: .green,
                    action: onImagesTap
                )

                Spacer(minLength: 0)

                CreateStoryActionButton(
                    title: "Video",
                    systemImage: "video.fill",
                    tint: .pink,
                    action: onVideoTap
                )

                Spacer(minLength: 0)

                CreateStoryActionButton(
                    title: "Album",
                    systemImage: "square.stack",
                    tint: .blue,
                    action: onAlbumTap
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
}

private struct CreateStoryActionButton: View {
    let title: String
    let systemImage: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(tint)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.systemGray5))
            )
        }
        .buttonStyle(.plain)
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(avatarURL: URL(string: "https://picsum.photos/200"))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}
