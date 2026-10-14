import SwiftUI

// MARK: - Экран добавления записи

struct AddMoodView: View {
    @Environment(MoodViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMood = "😊"

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Text("Какое у тебя настроение?").font(.title2.bold())
                SectionCard { MoodPicker(selectedMood: $selectedMood) }

                Button("Сохранить") {
                    viewModel.addMood(selectedMood)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding()
            .navigationTitle("Новая запись")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
            }
        }
    }
}
