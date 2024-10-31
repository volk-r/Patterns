import Foundation

// ### Определение паттерна
// **Имя и тип**: Команда (Command) - поведенческий паттерн проектирования.
// **Задача**:
// Позволяет превратить запросы в объекты, благодаря чему запросы и параметры вызова можно очередить, 
// логировать, а также поддерживать отмену операций.

// **Результаты, с плюсами и минусами**:
// **Плюсы**:
// - Уменьшает связанность между классами, вызывающими операции, и классами, на которые эти операции действуют.
// - Позволяет реализовать простую отмену и повтор операций.
// - Позволяет реализовать отложенный запуск операций.
// - Позволяет собирать сложные команды из простых.
// **Минусы**:
// - Усложняет код из-за необходимости создавать дополнительные классы.

// ### Задача (описание задачи, которая решается в примере кода)
// Давайте рассмотрим сценарий, где нам нужно реализовать систему управления умным домом. 
// Система должна включать и выключать различные устройства (например, свет и кондиционер) по команде пользователя.
// Используя паттерн Команда, мы можем инкапсулировать эти операции в объекты, что позволит нам
// добавлять новые функции управления без изменения существующего кода клиента или устройств.

// ### Пример кода

// Команда
protocol Command {
    func execute()
    func undo()
}

// Конкретные команды
class LightOnCommand: Command {
    let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.on()
    }

    func undo() {
        light.off()
    }
}

class LightOffCommand: Command {
    let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.off()
    }

    func undo() {
        light.on()
    }
}

// Объект
class Light {
    func on() {
        print("Свет включен")
    }

    func off() {
        print("Свет выключен")
    }
}

// Исполнитель с возможностью отмены и повтора команд
class RemoteControl {
    private var history: [Command] = []

    func setCommand(command: Command) {
        command.execute()
        history.append(command)
    }

    func pressUndoButton() {
        if let lastCommand = history.popLast() {
            lastCommand.undo()
        } else {
            print("Нет команд для отмены")
        }
    }
}

// Клиентский код
let light = Light()
let lightOn = LightOnCommand(light: light)
let lightOff = LightOffCommand(light: light)

let remote = RemoteControl()
remote.setCommand(command: lightOn)
remote.setCommand(command: lightOff)

// Отмена последней операции (выключение света)
remote.pressUndoButton()
// Отмена предыдущей операции (включение света)
remote.pressUndoButton()

// ### Выводы

// Использование паттерна **Команда** позволяет нам эффективно разделить ответственность между классами, 
// управляющими операциями, и классами, выполняющими эти операции.
// В нашем примере `RemoteControl` действует как исполнитель, вызывая команды без знания о деталях их реализации.
// Команды `LightOnCommand` и `LightOffCommand` инкапсулируют в себе операции над объектом `Light`,
// являясь мостом между исполнителем и объектом. Это обеспечивает гибкость в добавлении новых команд и устройств
// без необходимости изменять существующий код, что делает систему умного дома легко расширяемой и модифицируемой.