import Foundation

// MARK: - Song Model
struct Song {
    let title: String
    let artist: String
}

// MARK: - Protocol for Music Sources
protocol MusicSource {
    func play()
    func pause()
    func skip()
    var currentSong: Song? { get }
}

// MARK: - Local Source Implementation
class LocalSource: MusicSource {
    private var playlist: [Song]
    private var index = 0

    init(playlist: [Song]) {
        self.playlist = playlist
    }

    var currentSong: Song? {
        return index < playlist.count ? playlist[index] : nil
    }

    func play() {
        if let song = currentSong {
            print("🎵 Playing local song: \(song.title) by \(song.artist)")
        } else {
            print("📂 No more songs in local playlist.")
        }
    }

    func pause() {
        print("⏸️ Paused local song.")
    }

    func skip() {
        index += 1
        play()
    }
}

// MARK: - Spotify Source (Mock) Implementation
class SpotifySource: MusicSource {
    private var songs: [Song]
    private var index = 0

    init() {
        // Pretend we fetched these from Spotify API
        self.songs = [
            Song(title: "Blinding Lights", artist: "The Weeknd"),
            Song(title: "Levitating", artist: "Dua Lipa")
        ]
    }

    var currentSong: Song? {
        return index < songs.count ? songs[index] : nil
    }

    func play() {
        if let song = currentSong {
            print("🎶 Streaming song from Spotify: \(song.title) by \(song.artist)")
        } else {
            print("📡 No more songs on Spotify.")
        }
    }

    func pause() {
        print("⏸️ Spotify playback paused.")
    }

    func skip() {
        index += 1
        play()
    }
}

// MARK: - Singleton Music Player Manager
class MusicPlayerManager {
    static let shared = MusicPlayerManager()

    private var source: MusicSource?

    private init() {}

    func setSource(_ source: MusicSource) {
        self.source = source
        print("🔄 Music source set.")
    }

    func play() {
        source?.play()
    }

    func pause() {
        source?.pause()
    }

    func skip() {
        source?.skip()
    }
}

// MARK: - ViewModel
class PlayerViewModel {
    func play() {
        MusicPlayerManager.shared.play()
    }

    func pause() {
        MusicPlayerManager.shared.pause()
    }

    func skip() {
        MusicPlayerManager.shared.skip()
    }
}

// MARK: - Main Program (Console UI)
func main() {
    let localSongs = [
        Song(title: "Perfect", artist: "Ed Sheeran"),
        Song(title: "Let Her Go", artist: "Passenger")
    ]

    let localSource = LocalSource(playlist: localSongs)
    let spotifySource = SpotifySource()

    let vm = PlayerViewModel()

    print("🎧 Welcome to Mock Music Player!")
    print("Choose source:")
    print("1. Local Files")
    print("2. Spotify (mock)")

    if let input = readLine(), input == "1" {
        MusicPlayerManager.shared.setSource(localSource)
    } else {
        MusicPlayerManager.shared.setSource(spotifySource)
    }

    while true {
        print("""
        \n🔘 Choose an action:
        [1] Play
        [2] Pause
        [3] Skip
        [4] Exit
        """)
        guard let choice = readLine() else { continue }

        switch choice {
        case "1": vm.play()
        case "2": vm.pause()
        case "3": vm.skip()
        case "4":
            print("👋 Exiting Music Player.")
            return
        default:
            print("❓ Invalid choice.")
        }
    }
}

main()
