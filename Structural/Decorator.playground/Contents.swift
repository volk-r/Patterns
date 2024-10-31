import Foundation

// ### Определение паттерна

// - **Имя и тип**: Декоратор (Decorator) — структурный паттерн проектирования.

// - **Задача**: Позволяет динамически добавлять объектам новую функциональность, оборачивая их в полезные "обертки". 
// Это предоставляет гибкую альтернативу наследованию для расширения функциональности.

// **Решение**: Вместо изменения кода объекта или использования наследования,
// паттерн предлагает создать набор декораторов, которые могут добавлять новое поведение или данные к объекту. 
// Это достигается за счет создания класса декоратора, который обертывает основной объект
// и предоставляет дополнительную функциональность, переопределяя или дополняя его методы.

// **Результаты**:

// **Плюсы**:
// - Большая гибкость, чем у наследования.
// - Позволяет добавлять обязанности объектам "на лету".
// - Можно добавлять несколько новых обязанностей одновременно.
// - Соблюдение принципа открытости/закрытости.
// **Минусы**:
// - Может привести к созданию множества мелких классов.
// - Может усложнить архитектуру и ввести дополнительную сложность.

// ### Задача

// Допустим, у нас есть приложение для отображения уведомлений, 
// и мы хотим динамически изменять их внешний вид и поведение,
// например, добавляя к ним иконки, срочность и другие декорации, не изменяя основной класс уведомления.

// ### Пример кода

// Основной компонент
protocol Notification {
    var description: String { get }
}

// Конкретный компонент
class BasicNotification: Notification {
    var description: String {
        "Basic Notification"
    }
}

// Декоратор
class NotificationDecorator: Notification {
    private let decoratedNotification: Notification

    required init(_ notification: Notification) {
        self.decoratedNotification = notification
    }

    var description: String {
        decoratedNotification.description
    }
}

// Конкретные декораторы
class UrgentNotificationDecorator: NotificationDecorator {
    override var description: String {
        "Urgent: \(super.description)"
    }
}

class IconNotificationDecorator: NotificationDecorator {
    override var description: String {
        "\(super.description) [🔔]"
    }
}

// Использование
let basicNotification = BasicNotification()
print(basicNotification.description)

let urgentNotification = UrgentNotificationDecorator(basicNotification)
print(urgentNotification.description)

let iconNotification = IconNotificationDecorator(urgentNotification)
print(iconNotification.description)

// ### Выводы

// Использование паттерна Декоратор позволяет нам гибко и эффективно расширять функциональность объектов, 
// добавляя новые обязанности "на лету". Это делает код более модульным, легко масштабируемым и поддерживаемым.
// В нашем примере мы смогли изменить внешний вид и поведение уведомлений без внесения изменений в исходный класс,
// что демонстрирует мощность и гибкость паттерна Декоратор.

// Этот паттерн особенно полезен в ситуациях, когда нужно добавить новые функции к объектам во время выполнения программы
// или когда наследование может привести к неудобно большому иерархическому дереву классов.
// Однако, как и любой инструмент, его следует использовать уместно, с учетом потенциального усложнения архитектуры.
