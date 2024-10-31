import Foundation

// ### Определение паттерна

// **Заместитель (Proxy)** — это структурный паттерн проектирования, 
// который позволяет подставлять вместо реальных объектов специальные объекты-заменители.
// Эти заменители перехватывают вызовы к оригинальному объекту,
// позволяя сделать что-то до или после передачи вызова оригиналу.

// #### Имя и тип
// - **Имя**: Заместитель (Proxy)
// - **Тип**: Структурный паттерн

// #### Задача (решаемая паттерном)

// **Решение**: Обеспечить контроль доступа к объекту, логирование, ленивую инициализацию, 
// распределение операций по различным объектам и т.д., не изменяя при этом клиентский код.
// **Результаты**:
// **Плюсы**:
// - Удается контролировать сервисный объект незаметно для клиента.
// - Можно управлять жизненным циклом сервисного объекта при использовании умных указателей.
// - Прокси работает, даже если сервисный объект не готов или не доступен.
// - Открывает возможность к расширению функционала без изменения сервисного объекта.
// **Минусы**:
// - Может замедлить работу программы из-за дополнительных вызовов.
// - Усложнение кода из-за введения дополнительных классов.

// #### Задача
// В качестве примера рассмотрим ситуацию, где необходимо контролировать доступ к ресурсу,
// который требует аутентификации. Представим, что у нас есть система, в которой пользовательские запросы
// к определенной части контента должны быть доступны только авторизованным пользователям.

// #### Пример кода

// Протокол, описывающий общее поведение для Защищаемого контента и его Заместителя
protocol SecuredContentAccess {
    func accessContent() -> String
}

// Реальный объект, предоставляющий защищенный контент
class SecuredContent: SecuredContentAccess {
    func accessContent() -> String {
        "Доступ к защищенному контенту предоставлен"
    }
}

// Заместитель, контролирующий доступ к защищенному контенту
class ContentProxy: SecuredContentAccess {
    private var securedContent: SecuredContent?

    func accessContent() -> String {
        guard isAuthenticatedUser() else {
            return "Доступ запрещен: пользователь не аутентифицирован"
        }

        if securedContent == nil {
            securedContent = SecuredContent()
        }

        return securedContent!.accessContent()
    }

    private func isAuthenticatedUser() -> Bool {
        // Здесь должна быть логика проверки аутентификации пользователя
        // Для примера предположим, что пользователь аутентифицирован
        true
    }
}

// Использование Заместителя для доступа к защищенному контенту
func main() {
    let proxy = ContentProxy()
    print(proxy.accessContent())
}

main()

// #### Выводы

// В этом примере мы использовали паттерн **Заместитель (Proxy)** для контроля доступа к защищенному контенту.
// Заместитель `ContentProxy` предоставляет тот же интерфейс, что и реальный объект `SecuredContent`,
// благодаря чему клиентский код может использовать заместителя так же, как и реальный объект,
// не зная о разнице между ними. Это позволяет добавить дополнительные проверки
// (в данном случае аутентификацию пользователя) перед предоставлением доступа к контенту, не меняя клиентский код.

// Таким образом, паттерн **Заместитель** предлагает эффективное решение для контроля доступа,
// логирования, ленивой инициализации и других сценариев, требующих дополнительной обработки при обращении к объекту.