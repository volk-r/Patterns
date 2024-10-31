import Foundation

// ### Определение паттерна

// **Имя и тип**: Состояние (State) - поведенческий паттерн проектирования.
// **Задача**:
// **Решение**: 
//   Паттерн позволяет объектам изменять свое поведение в зависимости от своего состояния.
//   Это достигается путем переключения связанных классов состояний внутри контекстного объекта.
// **Результаты, с плюсами и минусами**:
// **Плюсы**:
// - Упрощает код контекста за счет устранения многочисленных условных операторов.
// - Группирует вариации поведения по разным классам.
// - Упрощает добавление новых состояний и переходов между ними.
// **Минусы**:
// - Увеличивает количество классов, так как каждое состояние реализуется в отдельном классе.

// ### Задача

// Представим, что мы разрабатываем приложение в котором есть управлемое сетевое подключение.
// Создадим модель управления сетевым соединением, которое может находиться в трех состояниях:
// подключено, отключено и в процессе подключения.

// ### Пример кода

import Foundation

// Определяем протокол состояния соединения
protocol ConnectionState {
    func connect(_ context: NetworkConnectionContext)
    func disconnect(_ context: NetworkConnectionContext)
}

// Контекст соединения, управляющий текущим состоянием
class NetworkConnectionContext {
    var state: ConnectionState = DisconnectedState()

    func connect() {
        state.connect(self)
    }

    func disconnect() {
        state.disconnect(self)
    }
}

// Конкретные состояния
class ConnectedState: ConnectionState {
    func connect(_ context: NetworkConnectionContext) {
        print("Already connected. No action needed.")
    }

    func disconnect(_ context: NetworkConnectionContext) {
        print("Disconnecting...")
        context.state = DisconnectedState()
        print("Disconnected.")
    }
}

class DisconnectedState: ConnectionState {
    func connect(_ context: NetworkConnectionContext) {
        print("Starting connection...")
        context.state = ConnectingState()
        // Передача управления в ConnectingState для имитации процесса подключения
        context.connect()
    }

    func disconnect(_ context: NetworkConnectionContext) {
        print("Already disconnected.")
    }
}

class ConnectingState: ConnectionState {
    func connect(_ context: NetworkConnectionContext) {
        print("Connected.")
        context.state = ConnectedState()
    }

    func disconnect(_ context: NetworkConnectionContext) {
        print("Cancelling connection...")
        context.state = DisconnectedState()
        print("Disconnected.")
    }
}

// Использование
let connection = NetworkConnectionContext()

// Попытка подключения
connection.connect() // "Starting connection..." -> "Connected."

// Отключение
connection.disconnect() // "Disconnecting..." -> "Disconnected."

// ### Выводы

// Использование паттерна **Состояние** позволяет нам гибко управлять поведением объектов в зависимости от их состояния,
// делая код более чистым и организованным. В нашем примере это позволяет легко добавлять новые состояния
// и управлять переходами между ними без усложнения логики в классе контекста.
// Особенно полезно это становится в более сложных системах с множеством возможных состояний и переходов.
