

import SwiftUI

@main
struct ZaloNewsFeedApp: App {
    enum NewsFeedTabs: Equatable, Hashable {
        case story
        case video
    }
    @State private var selectedTab:NewsFeedTabs = .story
    var body: some Scene {
        WindowGroup {
            SearchBarView()
            HStack {
                HeaderTabsView()
            }
        }
    }
}
