import SwiftUI

// MARK: - Экран добавления записи

struct AddMoodView: View {

    @Environment(MoodViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var selectedMood = "😊"

    var body: some View {

        NavigationStack {

            // Form предназначена для экранов ввода данных
            Form {

                Section("Выбери настроение") {
                    MoodPicker(selectedMood: $selectedMood)
                }
            }
            .navigationTitle("Новая запись")
            .navigationBarTitleDisplayMode(.inline)

            // Кнопки в верхней панели экрана
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        viewModel.addMood(selectedMood)
                        dismiss()
                    }
                }
            }
        }
    }
}
