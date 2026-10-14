import SwiftUI

// MARK: - Подробный экран записи

struct MoodDetailView: View {

    @Environment(MoodViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    let entry: MoodEntry

    var body: some View {

        VStack(spacing: 20) {

            Text(entry.mood)
                .font(.system(size: 80))

            Text(entry.moodName)
                .font(.title2.bold())

            Text(entry.date.formatted(
                date: .long,
                time: .shortened
            ))
            .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Запись")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {

                Button(role: .destructive) {
                    viewModel.deleteMood(entry)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
