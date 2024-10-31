import Foundation

// ### Абстрактная фабрика (Abstract Factory)

// **Имя**: Абстрактная фабрика (Abstract Factory).
// **Тип**: Порождающий паттерн.

// **Задача**: Предоставить интерфейс для создания семейств взаимосвязанных или взаимозависимых объектов, 
// не указывая их конкретные классы.

// **Решение**: Паттерн предлагает создать интерфейс (абстрактную фабрику), который определяет методы для создания абстрактных продуктов. Конкретные фабрики, реализующие этот интерфейс, производят объекты различных типов, но с похожими функциями.

// **Результаты**:
// - **Плюсы**:
// - Изолирует конкретные классы.
// - Упрощает замену семейств продуктов.
// - Гарантирует сочетаемость создаваемых продуктов.

// - **Минусы**:
// - Может усложнить код из-за необходимости создавать множество классов.

// ### Задача
// Представим, что мы разрабатываем приложение для отображения различных стилей кнопок и переключателей,
// которые должны соответствовать определенной теме (например, "Светлая" и "Темная" темы).
// Задача - обеспечить создание соответствующих элементов управления для каждой темы
// без привязки к конкретным классам элементов управления.

// ### Код

// Протоколы для абстрактных продуктов
protocol Button {
    func draw()
}

protocol Switch {
    func toggle()
}

// Конкретные продукты для светлой темы
class LightThemeButton: Button {
    func draw() {
        print("Drawing a light-themed button.")
    }
}

class LightThemeSwitch: Switch {
    func toggle() {
        print("Toggling a light-themed switch.")
    }
}

// Конкретные продукты для темной темы
class DarkThemeButton: Button {
    func draw() {
        print("Drawing a dark-themed button.")
    }
}

class DarkThemeSwitch: Switch {
    func toggle() {
        print("Toggling a dark-themed switch.")
    }
}

// Протокол для абстрактной фабрики
protocol ThemeFactory {
    func createButton() -> Button
    func createSwitch() -> Switch
}

// Конкретные фабрики
class LightThemeFactory: ThemeFactory {
    func createButton() -> Button {
        LightThemeButton()
    }

    func createSwitch() -> Switch {
        LightThemeSwitch()
    }
}

class DarkThemeFactory: ThemeFactory {
    func createButton() -> Button {
        DarkThemeButton()
    }

    func createSwitch() -> Switch {
        DarkThemeSwitch()
    }
}

// Использование абстрактной фабрики
func clientCode(factory: ThemeFactory) {
    let button = factory.createButton()
    let switchControl = factory.createSwitch()

    button.draw()
    switchControl.toggle()
}

// Пример использования
let lightFactory = LightThemeFactory()
clientCode(factory: lightFactory)

let darkFactory = DarkThemeFactory()
clientCode(factory: darkFactory)


// Этот код демонстрирует использование паттерна "Абстрактная фабрика"
// для создания семейств объектов, соответствующих определенной теме.
// Клиентский код может работать с любой конкретной фабрикой,
// не завися от конкретных классов продуктов, что упрощает расширение и поддержку программы.
