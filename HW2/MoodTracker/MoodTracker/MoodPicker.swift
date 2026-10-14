import SwiftUI

// MARK: - Выбор одного из трёх настроений

struct MoodPicker: View {
    @Binding var selectedMood: String
    private let moods = ["😊", "😐", "😔"]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(moods, id: \.self) { mood in
                Button {
                    selectedMood = mood
                } label: {
                    Text(mood)
                        .font(.system(size: 42))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(selectedMood == mood ? Color.blue.opacity(0.18) : Color.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(selectedMood == mood ? Color.blue : Color.clear, lineWidth: 2)
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Выбрать настроение \(mood)")
            }
        }
    }
}
