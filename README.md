# 📱 Zalo News Feed Clone

A simple clone of **Zalo News Feed** built with SwiftUI, applying **MVVM architecture** and a `Manager` Singleton to initialize and manage sample data.

---

## ✨ Features
- **Tab Diary**: Display diary feed with sample data.
- **Tab Video**: Display video feed with sample data.
- **MVVM architecture** for clean separation of concerns.
- **Singleton Manager**: Centralized place to initialize and provide mock/sample data.

---

## 📸 Screenshots

### Tab Diary
<img width="300" src="https://github.com/user-attachments/assets/a6eaf732-97c8-4590-b854-e98fd863720a" />
<img width="300" src="https://github.com/user-attachments/assets/fc6d168a-c3bb-4073-8b4c-fde04f6a641f" />

### Tab Video
<img width="300" src="https://github.com/user-attachments/assets/7181f7cf-1956-4a1a-887e-171538524eda" />

---

## 🛠 Architecture

### MVVM
- **Model**: Represents Diary and Video data (id, title, description, thumbnail, etc.).
- **ViewModel**: Exposes processed data to Views.
- **View**: SwiftUI components (`DiaryTabView`, `VideoTabView`).

### Data Manager (Singleton)
```swift
final class Manager {
    static let shared = Manager()
    
    private init() {
        // private để đảm bảo singleton
    }
    
    // Sample data
    let diaries: [Diary] = [
        Diary(id: 1, title: "First Diary", content: "Sample content 1", author: "UserA"),
        Diary(id: 2, title: "Second Diary", content: "Sample content 2", author: "UserB")
    ]
    
    let videos: [Video] = [
        Video(id: 1, title: "Funny Cat", url: "sample_video_url_1"),
        Video(id: 2, title: "Travel Vlog", url: "sample_video_url_2")
    ]
}
```
## 🚀 Getting Started
- Clone this repo:
  ```bash
    git clone https://github.com/phulv94/NewsFeedZalo.git
  ```
- Open project in Xcode
- Run on iOS Simulator or real device.
