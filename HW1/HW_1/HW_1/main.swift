import Foundation

// MARK: - Шаги 1 и 5. Модель книги

struct Book: Printable {
    let title: String
    let author: String
    let year: Int
    let pages: Int
    let genre: Genre
    var isAvailable: Bool
    var readerName: String?

    var shortDescription: String {
        return "\(title) — \(author) (\(pages) стр.)"
    }

    func printInfo() {
        print("""
        Название: \(title)
        Автор: \(author)
        Год издания: \(year)
        Страниц: \(pages)
        Жанр: \(genre.rawValue)
        Доступна: \(isAvailable ? "Да" : "Нет")
        Читатель: \(readerName ?? "Нет")
        """)
    }
}

// MARK: - Шаг 2. Жанры

enum Genre: String {
    case fantasy = "Фантастика"
    case detective = "Детектив"
    case classic = "Классика"
    case nonFiction = "Нон-фикшн"
}

// MARK: - Шаг 3. Описание жанра

func describeGenre(_ genre: Genre) -> String {
    switch genre {
    case .fantasy:
        return "Книги о вымышленных мирах и технологиях."
    case .detective:
        return "Произведения о расследованиях."
    case .classic:
        return "Литература, прошедшая проверку временем."
    case .nonFiction:
        return "Книги о реальных событиях и знаниях."
    }
}

// MARK: - Шаг 5. Протокол

protocol Printable {
    func printInfo()
}

// MARK: - Шаги 8 и 9. Класс библиотеки

class Library {
    // Хранение коллекции книг
    private var books: [Book]

    init(books: [Book]) {
        self.books = books
    }

    // Создание библиотеки с тестовыми данными
    static func makeTestLibrary() -> Library {
        let books = [
            Book(title: "Дюна", author: "Фрэнк Герберт", year: 1965, pages: 688, genre: .fantasy, isAvailable: true),
            Book(title: "Убийство в Восточном экспрессе", author: "Агата Кристи", year: 1934, pages: 256, genre: .detective, isAvailable: true),
            Book(title: "Преступление и наказание", author: "Фёдор Достоевский", year: 1866, pages: 672, genre: .classic, isAvailable: true),
            Book(title: "Краткая история времени", author: "Стивен Хокинг", year: 1988, pages: 256, genre: .nonFiction, isAvailable: true),
            Book(title: "Властелин колец", author: "Джон Толкин", year: 1954, pages: 1178, genre: .fantasy, isAvailable: true),
            Book(title: "Десять негритят", author: "Агата Кристи", year: 1939, pages: 288, genre: .detective, isAvailable: true),
            Book(title: "Мастер и Маргарита", author: "Михаил Булгаков", year: 1967, pages: 480, genre: .classic, isAvailable: true),
            Book(title: "Sapiens", author: "Юваль Ной Харари", year: 2011, pages: 512, genre: .nonFiction, isAvailable: true),
            Book(title: "451 градус по Фаренгейту", author: "Рэй Брэдбери", year: 1953, pages: 256, genre: .fantasy, isAvailable: true)
        ]

        return Library(books: books)
    }

    // Поиск книги по названию
    func findBook(title: String) -> Book? {
        return books.first {
            $0.title.localizedCaseInsensitiveCompare(title) == .orderedSame
        }
    }

    // Поиск книг по автору: возвращает все книги автора
    func findBooks(author: String) -> [Book] {
        return books.filter {
            $0.author.localizedCaseInsensitiveCompare(author) == .orderedSame
        }
    }
    
    // Выдача книги по названию
    func lendBook(title: String, to reader: String) {
        guard let index = books.firstIndex(where: {
            $0.title.localizedCaseInsensitiveCompare(title) == .orderedSame
        }) else {
            print("Книга «\(title)» не найдена.")
            return
        }

        guard books[index].isAvailable else {
            print("Книга «\(title)» уже выдана.")
            return
        }

        books[index].isAvailable = false
        books[index].readerName = reader
        print("Книга «\(title)» выдана читателю \(reader).")
    }
    
    // Вывод всех книг
    func printAllBooks() {
        for book in books {
            book.printInfo()
            print("--------------------")
        }
    }

    // Получение книг определенного жанра
    func books(genre: Genre) -> [Book] {
        return books.filter { $0.genre == genre }
    }

    // Получение книг определенного автора
    func books(byAuthor author: String) -> [Book] {
        return findBooks(author: author)
    }

    // Сортировка по количеству страниц
    func sortedByPages(ascending: Bool = true) -> [Book] {
        return books.sorted {
            ascending ? $0.pages < $1.pages : $0.pages > $1.pages
        }
    }

    // Список названий книг
    func bookTitles() -> [String] {
        return books.map { $0.title }
    }

    // Общее количество страниц
    func totalPages() -> Int {
        return books.reduce(0) { $0 + $1.pages }
    }
    
    // Дополнительная возможность. Возврат книги в библиотеку
    func returnBook(title: String) {
        guard let index = books.firstIndex(where: {
            $0.title.localizedCaseInsensitiveCompare(title) == .orderedSame
        }) else {
            print("Книга «\(title)» не найдена.")
            return
        }

        guard !books[index].isAvailable else {
            print("Книга «\(title)» уже находится в библиотеке.")
            return
        }

        books[index].isAvailable = true
        books[index].readerName = nil
        print("Книга «\(title)» возвращена.")
    }
    
    // Дополнительная возможность. Подсчет количества доступных книг
    func availableBooksCount() -> Int {
        return books.filter { $0.isAvailable }.count
    }
    
}

// MARK: - Шаг 10. Три самые объёмные книги

extension Library {
    func threeLongestBooks() -> [Book] {
        return sortedByPages(ascending: false).prefix(3).map { $0 }
    }
}

// MARK: - Дополнительное задание. Наследование

class LibraryUser {
    let name: String
    let id: Int

    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }

    func maxBooksCount() -> Int {
        return 0
    }
}

class Student: LibraryUser {
    override func maxBooksCount() -> Int {
        return 3
    }
}

class Teacher: LibraryUser {
    override func maxBooksCount() -> Int {
        return 10
    }
}

// MARK: - Проверка работы

let library = Library.makeTestLibrary()

print("=== Краткое описание ===")
if let book = library.findBook(title: "Дюна") {
    print(book.shortDescription)
}

print("\n=== Описание жанра ===")
print(describeGenre(.detective))

print("\n=== Поиск книг автора ===")
for book in library.findBooks(author: "Агата Кристи") {
    print(book.shortDescription)
}

print("\n=== Выдача книги ===")
library.lendBook(title: "Дюна", to: "Иван")
library.lendBook(title: "Дюна", to: "Мария")

print("\n=== Доступные книги ===")
print(library.availableBooksCount())

print("\n=== Возврат книги ===")
library.returnBook(title: "Дюна")

print("\n=== Книги жанра «Классика» ===")
for book in library.books(genre: .classic) {
    print(book.shortDescription)
}

print("\n=== Сортировка по убыванию страниц ===")
for book in library.sortedByPages(ascending: false) {
    print(book.shortDescription)
}

print("\n=== Названия всех книг ===")
print(library.bookTitles())

print("\n=== Всего страниц во всех книгах ===")
print(library.totalPages())

print("\n=== Три самые объёмные книги ===")
for book in library.threeLongestBooks() {
    print(book.shortDescription)
}

print("\n=== Полиморфизм пользователей ===")
let users: [LibraryUser] = [
    Student(name: "Иван", id: 1),
    Teacher(name: "Елена", id: 2),
    Student(name: "Мария", id: 3)
]

for user in users {
    print("\(user.name): можно взять до \(user.maxBooksCount()) книг.")
}

