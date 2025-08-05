import Foundation

// MARK: - Post Model
struct Post {
    let id: UUID
    let username: String
    let content: String
    let imageURL: String? // Just for simulation
}

// MARK: - Feed Service (Mock API)
class FeedService {
    func fetchPosts() -> [Post] {
        return [
            Post(id: UUID(), username: "Alice", content: "Good morning ☀️", imageURL: nil),
            Post(id: UUID(), username: "Bob", content: "Check this meme 😂", imageURL: "https://example.com/image1.jpg"),
            Post(id: UUID(), username: "Charlie", content: "Swift is awesome!", imageURL: nil)
        ]
    }
}

// MARK: - ViewModel
class FeedViewModel {
    private let service = FeedService()
    private(set) var posts: [Post] = []

    func loadFeed() {
        posts = service.fetchPosts()
        notifyUI()
    }

    private func notifyUI() {
        print("\n📱 Social Feed Loaded:\n")
        for post in posts {
            print("👤 \(post.username)")
            print("📝 \(post.content)")
            if let image = post.imageURL {
                print("🖼️ Image: \(image)")
            }
            print("— — —")
        }
    }
}

// MARK: - Simulated UI
func main() {
    let vm = FeedViewModel()

    while true {
        print("""
        \n🔘 Choose an action:
        [1] Load Feed
        [2] Refresh Feed
        [3] Exit
        """)

        guard let input = readLine() else { continue }

        switch input {
        case "1", "2":
            vm.loadFeed()
        case "3":
            print("👋 Exiting app.")
            return
        default:
            print("❓ Invalid input.")
        }
    }
}

main()
