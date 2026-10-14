import Foundation

// MARK: - Сервис загрузки записей

struct MoodService {

    // Загружаем тестовые записи с искусственной задержкой
    static func fetchMoods() async throws -> [MoodEntry] {

        // Имитируем ожидание ответа от сервера
        try await Task.sleep(for: .seconds(1))

        let now = Date()

        return [
            MoodEntry(
                mood: "😊",
                date: now.addingTimeInterval(-60 * 60)
            ),
            MoodEntry(
                mood: "😐",
                date: now.addingTimeInterval(-60 * 60 * 24)
            ),
            MoodEntry(
                mood: "😔",
                date: now.addingTimeInterval(-60 * 60 * 24 * 2)
            )
        ]
    }
}
