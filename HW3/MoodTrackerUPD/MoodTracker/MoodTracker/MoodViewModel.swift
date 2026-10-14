import Foundation
import Observation

// MARK: - Состояния экрана

enum ScreenState {
    case idle
    case loading
    case success
    case error(String)
}

@Observable
class MoodViewModel {

    var entries: [MoodEntry] = []
    var searchQuery: String = ""
    var state: ScreenState = .idle

    // MARK: - Поиск записей

    // Возвращает записи, подходящие под поисковый запрос
    var filteredEntries: [MoodEntry] {

        if searchQuery.isEmpty {
            return entries
        }

        return entries.filter {
            $0.mood.localizedCaseInsensitiveContains(searchQuery) ||
            $0.moodName.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    // MARK: - Загрузка данных

    // Загружаем записи через отдельный сервис
    func loadMoods() async {

        state = .loading

        do {
            let moods = try await MoodService.fetchMoods()

            entries = moods
            state = .success

        } catch {
            state = .error(error.localizedDescription)
        }
    }

    // MARK: - Добавление и удаление записей

    func addMood(_ mood: String) {
        entries.insert(
            MoodEntry(mood: mood, date: Date()),
            at: 0
        )
    }

    func deleteMood(_ entry: MoodEntry) {
        entries.removeAll { $0.id == entry.id }
    }
}
