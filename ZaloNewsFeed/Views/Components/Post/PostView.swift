import SwiftUI

struct PostCellView: View {
    let activity: UserActivity

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ActiveHeaderView(userName: activity.userName, activeCount: activity.activeCount)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(activity.posts) { post in
                        PostCellBody(
                            userName: activity.userName,
                            userAvatarURL: activity.userAvatarURL,
                            post: post
                        )
                    }
                }
                .padding(.horizontal, 16)
                Spacer(minLength: 12)
            }
        }
        .background(.white)
    }
}

private struct ActiveHeaderView: View {
    let userName: String
    let activeCount: Int

    var body: some View {
        HStack {
            Text("\(Text(userName).font(.headline).bold()) recently has \(activeCount) actives.")
                .font(.subheadline)
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}

private struct RemoteMediaView: View {
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

private struct VideoThumbnailView: View {
    let imageURL: URL

    var body: some View {
        ZStack {
            RemoteMediaView(url: imageURL, height: 160, cornerRadius: 16)

            Circle()
                .fill(Color.black.opacity(0.6))
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: "play.fill")
                        .foregroundStyle(.white)
                        .font(.title2)
                )
        }
    }
}

private struct LinkPreviewView: View {
    let preview: LinkPreview

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageURL = preview.imageURL {
                RemoteMediaView(url: imageURL, height: 160, cornerRadius: 16)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(preview.title)
                    .font(.headline)
                    .foregroundStyle(Color.primary)

                Text(preview.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text(preview.url)
                    .font(.caption)
                    .foregroundStyle(Color.blue)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemGray6))
        )
    }
}

private struct PostCellBody: View {
    let userName: String
    let userAvatarURL: URL?
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            content
            footer
        }
        .padding(16)
        .frame(width: 300, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
        )
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            CachedAsyncImage(url: userAvatarURL, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .empty:
                    ProgressView()
                        .tint(.secondary)
                case .failure:
                    Image(systemName: "person.circle")
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

            VStack(alignment: .leading, spacing: 4) {
                Text(userName)
                    .font(.headline)

                Text(post.createdAt)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(.secondary)
                    .padding(6)
            }
            .buttonStyle(.plain)
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let text = post.contentText, !text.isEmpty {
                Text(text)
                    .font(.body)
                    .foregroundStyle(Color.primary)
            }

            if !post.hashtags.isEmpty {
                Text(post.hashtags.map { "#\($0)" }.joined(separator: " "))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
            }

            if !post.mentions.isEmpty {
                Text(post.mentions.map { "@\($0)" }.joined(separator: " "))
                    .font(.subheadline)
                    .foregroundStyle(Color.blue)
            }

            if let imageURL = post.imageURL {
                RemoteMediaView(url: imageURL, height: 220, cornerRadius: 16)
            }

            if let videoThumbnailURL = post.videoThumbnailURL {
                VideoThumbnailView(imageURL: videoThumbnailURL)
            }

            if let linkPreview = post.linkPreview {
                LinkPreviewView(preview: linkPreview)
            }
        }
    }

    private var footer: some View {
        HStack {
            Button(action: {}) {
                HStack(spacing: 6) {
                    Image(systemName: "hand.thumbsup")
                    Text("Like")
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: {}) {
                HStack(spacing: 6) {
                    Image(systemName: "bubble.right")
                    Text("Comment")
                }
            }
            .buttonStyle(.plain)
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
}
