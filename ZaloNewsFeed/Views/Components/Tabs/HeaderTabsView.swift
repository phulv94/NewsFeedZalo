import SwiftUI

struct HeaderTabsView: View {
    @StateObject private var viewModel = HeaderTabsViewModel()
    @StateObject private var diaryViewModel = DiaryTabViewModel()
    @StateObject private var videoViewModel = VideoTabViewModel()

    var body: some View {
        VStack(spacing: 16) {
            header

            switch viewModel.selectedTab {
            case .diary:
                DiaryTabView(viewModel: diaryViewModel)
            case .video:
                VideoTabView(viewModel: videoViewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.selectedTab)
    }

    private var header: some View {
        HStack(spacing: 0) {
            ForEach(HeaderTabsViewModel.Tab.allCases) { tab in
                Button {
                    viewModel.selectedTab = tab
                } label: {
                    Text(tab.rawValue)
                        .font(.headline)
                        .foregroundStyle(tab == viewModel.selectedTab ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(tab == viewModel.selectedTab ? Color.primary : Color.clear)
                                .frame(height: 2)
                        }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}
