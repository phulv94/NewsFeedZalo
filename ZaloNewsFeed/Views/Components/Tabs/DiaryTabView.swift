import SwiftUI

struct DiaryTabView: View {
    @ObservedObject var viewModel: DiaryTabViewModel

    init(viewModel: DiaryTabViewModel = DiaryTabViewModel()) {
            self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                CreatePostView(
                    avatarURL: viewModel.currentUserAvatarURL,
                    placeholder: viewModel.storyPlaceholder
                )

                StorySectionView(stories: viewModel.featuredStories)

                ForEach(viewModel.activities) { activity in
                    PostCellView(activity: activity)
                        .padding(.horizontal)
                }

                AdsPostView(post: viewModel.adsPost) {}
                    .padding(.horizontal)

                SuggestStoryView(stories: viewModel.suggestedStories)
                    .padding(.horizontal)
            }
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct DiaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryTabView()
            .previewDisplayName("Diary Tab")
    }
}
