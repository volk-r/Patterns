import Foundation

// **Адаптер (Adapter)** - это паттерн позволяющий объектам с несовместимыми интерфейсами работать вместе.
// Этот паттерн обычно используется для создания обертки вокруг объекта,
// чтобы адаптировать его интерфейс к другому интерфейсу.

// **Имя и тип**: Адаптер, структурный паттерн.

// ### Задача

// **Решение**: Паттерн Адаптер решает проблему несовместимости интерфейсов, 
// позволяя объектам с различными интерфейсами работать вместе без изменения их кода.
// **Результаты**:
// **Плюсы**:
// - Позволяет несовместимым классам работать вместе.
// **Минусы**:
// - Усложняет код из-за введения дополнительных классов.

// ### Задача

// Представим, что у нас есть система, которая выводит информацию о продуктах. 
// Новая система предоставляет данные о продуктах через новый интерфейс,
// но наш старый модуль клиента ожидает данные через старый интерфейс.
// Вот как мы можем решить эту проблему:

// ### Пример кода

// Это целевой интерфейс, который ожидает наш клиент
protocol OldProductsInterface {
    func getProducts() -> [String]
}

// Это адаптируемый класс, который нужно адаптировать к целевому интерфейсу
class NewProductsService {
    func fetchProducts() -> [Product] {
        [Product(name: "Apple"), Product(name: "Banana")]
    }
}

struct Product {
    let name: String
}

// Это адаптер, который реализует целевой интерфейс и оборачивает адаптируемый объект
class ProductsAdapter: OldProductsInterface {
    private let newProductsService: NewProductsService

    init(newProductsService: NewProductsService) {
        self.newProductsService = newProductsService
    }

    func getProducts() -> [String] {
        // Преобразование продуктов из нового сервиса в формат, ожидаемый клиентом
        newProductsService.fetchProducts().map { $0.name }
    }
}

// Это клиент, который ожидает работать с продуктами через старый интерфейс
class ProductsClient {
    private let service: OldProductsInterface

    init(service: OldProductsInterface) {
        self.service = service
    }

    func printProducts() {
        let products = service.getProducts()
        print("Available products: \(products.joined(separator: ", "))")
    }
}

let newProductsService = NewProductsService()
let adapter = ProductsAdapter(newProductsService: newProductsService)
let client = ProductsClient(service: adapter)

client.printProducts()

// ### Выводы

// Использование паттерна Адаптер позволяет интегрировать новые сервисы или системы с существующей кодовой базой
// без необходимости изменять её. Это делает ваш код более гибким и устойчивым к изменениям,
// упрощает интеграцию с внешними системами и сервисами. Однако стоит помнить о потенциальном усложнении архитектуры
// и увеличении количества классов. Всегда важно оценивать, когда использование Адаптера действительно уместно,
// и не применять этот паттерн без необходимости.
