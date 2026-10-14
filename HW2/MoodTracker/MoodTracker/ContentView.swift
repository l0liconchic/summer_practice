import SwiftUI

// MARK: - Выбор экрана: приветствие или основная страница

struct ContentView: View {
    @AppStorage("savedUsername") private var savedUsername = ""
    @State private var viewModel = MoodViewModel()

    var body: some View {
        Group {
            if savedUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                WelcomeView(name: $savedUsername)
            } else {
                MoodListView(username: savedUsername)
                    .environment(viewModel)
            }
        }
    }
}

#Preview { ContentView() }
