import SwiftUI

// MARK: - Список настроений и удаление

struct MoodListView: View {

    @Environment(MoodViewModel.self) private var viewModel
    @State private var showAddMood = false

    let username: String

    var body: some View {

        // MARK: - Навигация

        NavigationStack {

            Group {

                // MARK: - Состояния экрана

                switch viewModel.state {

                case .idle, .loading:

                    VStack(spacing: 16) {
                        ProgressView()

                        Text("Загружаем записи...")
                            .foregroundStyle(.secondary)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )

                case .error(let message):

                    VStack(spacing: 16) {

                        Image(systemName: "wifi.slash")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)

                        Text("Не удалось загрузить записи")
                            .font(.headline)

                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)

                        Button("Попробовать снова") {
                            Task {
                                await viewModel.loadMoods()
                            }
                        }
                    }
                    .padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )

                case .success:

                    moodContent
                }
            }
            .navigationTitle("Мои настроения")

            // MARK: - Кнопка добавления

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                    Button {
                        showAddMood = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            // MARK: - Переход на подробный экран

            .navigationDestination(for: MoodEntry.self) { entry in
                MoodDetailView(entry: entry)
            }

            // MARK: - Загрузка при открытии экрана

            .task {
                await viewModel.loadMoods()
            }

            // Открываем экран добавления
            .sheet(isPresented: $showAddMood) {
                AddMoodView()
                    .environment(viewModel)
            }
        }
    }

    // MARK: - Список и поиск

    private var moodContent: some View {

        // @Bindable позволяет привязать строку поиска
        // к свойству объекта из @Environment
        @Bindable var bindableViewModel = viewModel

        // Две равные колонки для сетки
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return ScrollView {

            VStack(spacing: 16) {

                // Приветствие пользователя
                SectionCard {
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Привет, \(username)!")
                            .font(.title2.bold())

                        Text("Как ты себя чувствовал(а)?")
                            .foregroundStyle(.secondary)
                    }
                }

                if viewModel.filteredEntries.isEmpty {

                    ContentUnavailableView(
                        "Записей не найдено",
                        systemImage: "face.smiling",
                        description: Text(
                            viewModel.searchQuery.isEmpty
                            ? "Нажми +, чтобы добавить первую запись."
                            : "Попробуй изменить запрос поиска."
                        )
                    )
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 200
                    )

                } else {

                    // LazyVGrid создаёт ячейки по мере необходимости
                    LazyVGrid(columns: columns, spacing: 16) {

                        ForEach(viewModel.filteredEntries) { entry in

                            // NavigationLink передаёт запись в NavigationStack
                            NavigationLink(value: entry) {

                                VStack(spacing: 12) {

                                    Text(entry.mood)
                                        .font(.system(size: 44))
                                        .frame(maxWidth: .infinity)

                                    Text(entry.moodName)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)

                                    Text(entry.date.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    ))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .frame(
                                    maxWidth: .infinity,
                                    minHeight: 150
                                )
                                .background(Color(.systemGray6))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 16)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }

        // Строка поиска связана с ViewModel через @Bindable
        .searchable(
            text: $bindableViewModel.searchQuery,
            prompt: "Настроение или эмодзи"
        )
    }
}
