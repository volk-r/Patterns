import Foundation

// ### Определение паттерна

// - **Имя и тип:** Снимок (Memento) — поведенческий паттерн проектирования.

// - **Задача**
//   Паттерн "Снимок" решает задачу сохранения и восстановления предыдущих состояний объекта
//   без нарушения его инкапсуляции.
// - **Решение**
//   Позволяет сохранять и восстанавливать прошлые состояния объекта используя 
//   объекты "Снимок" для хранения этого состояния и 
//   "Опекун" управляющий когда и какие снимки создавать и восстанавливать,
//   обеспечивая возможность отката изменений без нарушения инкапсуляции объекта.

// - **Результаты, с плюсами и минусами:**
// - **Плюсы:**
// - Обеспечивает сохранение инкапсуляции.
// - Упрощает структуру объектов за счет делегирования функций по работе с историей.
// - **Минусы:**
// - Может привести к повышенному использованию памяти,
//   если снимки сохраняются часто или если объекты для сохранения большие.
// - Может быть сложно управлять жизненным циклом снимков, если нет четкой стратегии их хранения.

// ### Задача

// Разработаем систему для текстового редактора,
// позволяющую сохранять состояния текста (например, содержимое документа)
// в определенные моменты времени (например, перед выполнением важных операций)
// и восстанавливать их при необходимости.
// Это может быть полезно для функций отмены изменений или восстановления предыдущих версий документа.

// ### Пример кода

// Memento: Хранитель, который сохраняет состояние Originator
class TextMemento {
    private var state: String

    init(state: String) {
        self.state = state
    }

    func getState() -> String {
        state
    }
}

// Создатель, чье состояние необходимо сохранять
class TextEditor {
    private var content: String = ""

    func append(text: String) {
        content += text
    }

    func getContent() -> String {
        content
    }

    func save() -> TextMemento {
        TextMemento(state: content)
    }

    func restore(memento: TextMemento) {
        self.content = memento.getState()
    }
}

// Опекун, который знает, когда и почему Создатель должен сохранять и восстанавливать свое состояние
class Caretaker {
    private var mementos: [TextMemento] = []
    private var editor: TextEditor

    init(editor: TextEditor) {
        self.editor = editor
    }

    func backup() {
        print("Caretaker: Saving Editor's state...")
        mementos.append(editor.save())
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        let memento = mementos.removeLast()
        print("Caretaker: Restoring state...")
        editor.restore(memento: memento)
    }
}

// Использование
let editor = TextEditor()
let caretaker = Caretaker(editor: editor)

editor.append(text: "First Line\n")
caretaker.backup()

editor.append(text: "Second Line\n")
caretaker.backup()

editor.append(text: "Third Line\n")

print("Current Content:\n\(editor.getContent())")
caretaker.undo() // Отмена последнего изменения
print("After Undo:\n\(editor.getContent())")

// ### Выводы

// Применение паттерна показывает его мощность и гибкость при работе с состояниями объектов.
// Это особенно полезно в приложениях, где необходима функциональность отмены действий
// или восстановления предыдущих состояний.
// Важно помнить о потреблении памяти и управлении жизненным циклом снимков,
// чтобы эффективно использовать этот паттерн в реальных проектах.
