import SwiftUI

// MARK: - Ввод и сохранение имени

struct WelcomeView: View {
    @Binding var name: String
    @State private var enteredName = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("😊").font(.system(size: 64))
            Text("Mood Tracker").font(.largeTitle.bold())
            Text("Привет! Как тебя зовут?").font(.title3)

            TextField("Твоё имя", text: $enteredName)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .padding(.horizontal)

            Button("Начать") {
                name = enteredName.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .buttonStyle(.borderedProminent)
            .disabled(enteredName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            Spacer()
        }
        .padding()
    }
}
