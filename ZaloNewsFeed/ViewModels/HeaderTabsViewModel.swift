import Foundation

final class HeaderTabsViewModel: ObservableObject {
    enum Tab: String, CaseIterable, Identifiable {
        case diary = "Diary"
        case video = "Video"

        var id: String { rawValue }
    }

    @Published var selectedTab: Tab = .diary
}
