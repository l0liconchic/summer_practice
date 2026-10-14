import Foundation

// MARK: - Модель одной записи о настроении

struct MoodEntry: Identifiable, Hashable {

    let id = UUID()
    let mood: String
    let date: Date

    // Название настроения для отображения и поиска
    var moodName: String {
        switch mood {
        case "😊": return "Хорошее настроение"
        case "😐": return "Нейтральное настроение"
        case "😔": return "Грустное настроение"
        default: return "Настроение"
        }
    }
}
