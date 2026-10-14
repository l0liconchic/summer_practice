import Foundation
import Observation

// MARK: - Хранение и изменение записей

@Observable
class MoodViewModel {
    var entries: [MoodEntry] = []

    func addMood(_ mood: String) {
        entries.insert(MoodEntry(mood: mood, date: Date()), at: 0)
    }

    func deleteMood(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}
