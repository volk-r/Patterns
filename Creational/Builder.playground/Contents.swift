import Foundation

// "Строитель" (Builder).
// Этот паттерн часто используется для упрощения процесса создания сложных объектов.
// Он особенно полезен, когда объект должен быть создан в несколько этапов
// или когда имеется множество возможных конфигураций объекта,
// или когда у объекта есть множество параметров конструктора.

// **Имя**: Строитель (Builder)

// **Тип**: Порождающий паттерн (Creational Pattern)

// **Задача**: Паттерн "Строитель" решает проблему создания сложного объекта *шаг за шагом*.
// Он позволяет производить различные представления объекта, используя один и тот же процесс конструирования.

// **Решение**: Паттерн "Строитель" предполагает вынесение процесса конструирования объекта
// за пределы его собственного класса, делегировав эти обязанности отдельным объектам, называемым строителями.

// **Плюсы**:
// - Позволяет изменять внутреннее представление продукта.
// - Изолирует код для конструирования и представления.
// - Дает более тонкий контроль над процессом конструирования.

// **Минусы**:
// - Усложняет код программы из-за введения дополнительных классов.
// - Требует наличия всех конкретных строителей, если клиентский код должен создавать различные представления.

// ### Пример

// Допустим, нам нужно создать конфигуратор для компьютера. Вот как это может выглядеть в коде:

// ### Код

// Определение компонентов
class Computer {
    var hdd: String?
    var ram: String?

    func describe() -> String {
        "Computer with \(hdd ?? "no") HDD and \(ram ?? "no") RAM"
    }
}

// Строитель
protocol ComputerBuilder {
    var computer: Computer { get }

    func setHDD(hdd: String)
    func setRAM(ram: String)
    func build() -> Computer
}

// Строитель для игрового компьютера
class GamingComputerBuilder: ComputerBuilder {
    var computer: Computer = Computer()

    func setHDD(hdd: String) {
        computer.hdd = hdd
    }

    func setRAM(ram: String) {
        computer.ram = ram
    }

    func build() -> Computer {
        computer
    }
}

// Строитель для офисного компьютера
class OfficeComputerBuilder: ComputerBuilder {
    var computer: Computer = Computer()

    func setHDD(hdd: String) {
        computer.hdd = hdd
    }

    func setRAM(ram: String) {
        computer.ram = ram
    }

    func build() -> Computer {
        computer
    }
}

// Директор
class ComputerDirector {
    private var builder: ComputerBuilder?

    func constructComputer(builder: ComputerBuilder, hdd: String, ram: String) {
        self.builder = builder
        builder.setHDD(hdd: hdd)
        builder.setRAM(ram: ram)
    }

    func getComputer() -> Computer? {
        builder?.build()
    }
}

// Использование
let gamingBuilder = GamingComputerBuilder()
let officeBuilder = OfficeComputerBuilder()
let director = ComputerDirector()

// Создание игрового компьютера
director.constructComputer(builder: gamingBuilder, hdd: "1TB", ram: "16GB")
let gamingComputer = director.getComputer() // "Computer with 1TB HDD and 16GB RAM"

// Создание офисного компьютера
director.constructComputer(builder: officeBuilder, hdd: "500GB", ram: "8GB")
let officeComputer = director.getComputer() // "Computer with 500GB HDD and 8GB RAM"

// В этом примере мы создаем `Computer` с помощью `GamingComputerBuilder`.
// `ComputerDirector` управляет процессом построения, задавая необходимые параметры.
// Это показывает, как паттерн "Строитель" позволяет создавать различные
// представления объекта `Computer`, не изменяя его основной класс.
