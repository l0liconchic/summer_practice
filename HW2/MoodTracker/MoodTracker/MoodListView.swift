import SwiftUI

// MARK: - Список настроений и удаление

struct MoodListView: View {
    @Environment(MoodViewModel.self) private var viewModel
    @State private var showAddMood = false
    let username: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                SectionCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Привет, \(username)!").font(.title2.bold())
                        Text("Как ты себя чувствовал(а)?").foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if viewModel.entries.isEmpty {
                    ContentUnavailableView(
                        "Записей пока нет",
                        systemImage: "face.smiling",
                        description: Text("Нажми «Добавить запись», чтобы отметить настроение.")
                    )
                } else {
                    List {
                        ForEach(viewModel.entries) { entry in
                            HStack(spacing: 14) {
                                Text(entry.mood).font(.system(size: 36))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(moodName(for: entry.mood)).font(.headline)
                                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption).foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: viewModel.deleteMood)
                    }
                    .listStyle(.insetGrouped)
                }

                Button {
                    showAddMood = true
                } label: {
                    Label("Добавить запись", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .padding(.top)
            .navigationTitle("Мои настроения")
            .toolbar { EditButton() }
            .sheet(isPresented: $showAddMood) {
                AddMoodView().environment(viewModel)
            }
        }
    }

    private func moodName(for mood: String) -> String {
        switch mood {
        case "😊": return "Хорошее настроение"
        case "😐": return "Нейтральное настроение"
        case "😔": return "Грустное настроение"
        default: return "Настроение"
        }
    }
}
