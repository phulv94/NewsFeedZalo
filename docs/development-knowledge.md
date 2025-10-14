# Knowledge Requirements for Building the Zalo News Feed Clone

## 1. Swift and SwiftUI Foundations
- Understand Swift structures, value semantics, and how views conform to the `View` protocol with a computed `body`. The `SearchBarView` demonstrates struct-based views that return layout hierarchies composed of SwiftUI primitives such as `HStack`, `ZStack`, and `TextField`.【F:ZaloNewsFeed/Views/Components/Search/SearchBarView.swift†L1-L35】
- Be comfortable with SwiftUI modifiers for styling (e.g., `foregroundStyle`, `padding`, and `background`) that drive the blue header search experience.【F:ZaloNewsFeed/Views/Components/Search/SearchBarView.swift†L8-L35】

## 2. Application Entry and Scene Management
- Know how SwiftUI apps declare their entry point with the `@main` attribute and structure scenes via `WindowGroup`. `ZaloNewsFeedApp` wires the root search bar and tab container views inside the primary scene.【F:ZaloNewsFeed/ZaloNewsFeedApp.swift†L3-L19】

## 3. MVVM Architecture Basics
- Model layer: Define lightweight data structures that conform to `Identifiable`/`Hashable` to power lists (`Story`, `Post`, `VideoItem`, etc.).【F:ZaloNewsFeed/Models/FeedModels.swift†L3-L64】
- View-model layer: Implement `ObservableObject` classes that expose published properties for the UI and accept dependencies (e.g., `FeedDataManager`).【F:ZaloNewsFeed/ViewModels/DiaryTabViewModel.swift†L3-L30】【F:ZaloNewsFeed/ViewModels/VideoTabViewModel.swift†L3-L15】
- Data service layer: Centralize mock data behind a singleton (`FeedDataManager`) to keep views decoupled from data creation logic.【F:ZaloNewsFeed/Managers/FeedDataManager.swift†L3-L172】

## 4. State Management with Property Wrappers
- Use `@Published` in view models so SwiftUI updates when feed data changes.【F:ZaloNewsFeed/ViewModels/DiaryTabViewModel.swift†L3-L20】【F:ZaloNewsFeed/ViewModels/VideoTabViewModel.swift†L3-L15】
- Employ `@StateObject` to own long-lived view models in container views (e.g., `HeaderTabsView`) and `@ObservedObject` to read injected view models inside child tabs.【F:ZaloNewsFeed/Views/Components/Tabs/HeaderTabsView.swift†L3-L40】【F:ZaloNewsFeed/Views/Components/Tabs/DiaryTabView.swift†L3-L34】【F:ZaloNewsFeed/Views/Components/Tabs/VideoTabView.swift†L3-L32】
- Manage local control state with `@State` for transient UI values such as search text.【F:ZaloNewsFeed/Views/Components/Search/SearchBarView.swift†L3-L23】

## 5. Layout Composition Techniques
- Compose vertically scrolling feeds using `ScrollView` and `LazyVStack`, injecting reusable components to match the diary tab layout.【F:ZaloNewsFeed/Views/Components/Tabs/DiaryTabView.swift†L10-L34】
- Arrange grid-based video content with `LazyVGrid` and flexible columns to support adaptive two-column layouts.【F:ZaloNewsFeed/Views/Components/Tabs/VideoTabView.swift†L6-L32】
- Build horizontally scrolling story rails through nested `ScrollView`/`HStack` combinations.【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L7-L24】

## 6. Custom View Components and Reuse
- Design composable cards for stories, posts, ads, and suggestions by encapsulating layout and styling in dedicated views (e.g., `StoryCell`, `PostCellBody`, `AdsPostView`, `SuggestStoryCell`).【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L27-L90】【F:ZaloNewsFeed/Views/Components/Post/PostView.swift†L3-L256】【F:ZaloNewsFeed/Views/Components/Post/AdsPostView.swift†L3-L139】【F:ZaloNewsFeed/Views/Components/Story/SuggestStoryView.swift†L3-L133】
- Provide initializer hooks and callback closures for interaction points, such as tapping a story or triggering media buttons in `CreatePostView`.【F:ZaloNewsFeed/Views/Components/Post/CreatePostView.swift†L3-L113】【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L3-L24】【F:ZaloNewsFeed/Views/Components/Story/SuggestStoryView.swift†L3-L117】

## 7. Remote Media Handling with `AsyncImage`
- Load remote avatars, thumbnails, and link previews asynchronously while supplying placeholders and error fallbacks. This pattern is used throughout story cells, posts, ads, and video cards.【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L37-L87】【F:ZaloNewsFeed/Views/Components/Post/PostView.swift†L42-L228】【F:ZaloNewsFeed/Views/Components/Post/AdsPostView.swift†L18-L121】【F:ZaloNewsFeed/Views/Components/Tabs/VideoTabView.swift†L35-L132】

## 8. Styling, Overlays, and Visual Polish
- Apply gradients, rounded rectangles, shadows, and overlays to mimic social-feed aesthetics, as seen in story backgrounds, post cards, and video play buttons.【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L49-L88】【F:ZaloNewsFeed/Views/Components/Post/PostView.swift†L42-L256】【F:ZaloNewsFeed/Views/Components/Post/AdsPostView.swift†L13-L82】【F:ZaloNewsFeed/Views/Components/Tabs/VideoTabView.swift†L35-L132】
- Use typography choices (`font`, `fontWeight`, `foregroundStyle`) and layout spacings to emphasize hierarchy across sections.【F:ZaloNewsFeed/Views/Components/Tabs/HeaderTabsView.swift†L8-L44】【F:ZaloNewsFeed/Views/Components/Tabs/DiaryTabView.swift†L10-L34】【F:ZaloNewsFeed/Views/Components/Tabs/VideoTabView.swift†L15-L32】

## 9. User Interaction Patterns
- Wire tab switching through buttons that mutate shared state in `HeaderTabsViewModel`, illustrating how to connect user actions to view updates.【F:ZaloNewsFeed/ViewModels/HeaderTabsViewModel.swift†L3-L11】【F:ZaloNewsFeed/Views/Components/Tabs/HeaderTabsView.swift†L22-L44】
- Provide affordances for future features via placeholder button actions (e.g., like/comment buttons, "See all" links), showing where gesture handling or navigation can be added later.【F:ZaloNewsFeed/Views/Components/Post/PostView.swift†L233-L254】【F:ZaloNewsFeed/Views/Components/Story/SuggestStoryView.swift†L26-L53】

## 10. Previewing and Iteration
- Leverage SwiftUI previews to iterate on individual components in isolation, which is showcased across multiple views for faster UI development loops.【F:ZaloNewsFeed/Views/Components/Story/StorySectionView.swift†L94-L124】【F:ZaloNewsFeed/Views/Components/Post/CreatePostView.swift†L107-L113】【F:ZaloNewsFeed/Views/Components/Post/AdsPostView.swift†L124-L139】【F:ZaloNewsFeed/Views/Components/Story/SuggestStoryView.swift†L119-L133】

Mastering these areas equips you to extend the project with real networking, persistence, or richer interactions while keeping the MVVM-driven SwiftUI codebase maintainable.
