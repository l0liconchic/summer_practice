import Foundation

// MARK: - Модель одной записи о настроении

struct MoodEntry: Identifiable {
    let id = UUID()
    let mood: String
    let date: Date
}
