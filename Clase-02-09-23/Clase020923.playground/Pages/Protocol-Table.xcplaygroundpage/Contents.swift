//: [Previous](@previous)

import Foundation

protocol TabularDataSource {
    var numberOfRows: Int {get}
    var numberOfColumns: Int {get}
    
    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible){
    print(dataSource)
    var headerRow = "|"
    var columnWidths = [Int]()
    
    //Obtiene label, los imprime y agrega label.count a columnWidths
    for index in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: index)
        let columnHeader = "\(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    
    print(headerRow)
    
    //Obtiene cada cell, la va imprimiendo, y añade espacios dependiendo de cell.count y su respectivo columnWidth
    for index in 0..<dataSource.numberOfRows {
        var output = "|"
        for columnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: index, column: columnIndex)
            let paddingNeeded = columnWidths[columnIndex] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            output += "\(padding)\(item) |"
        }
        print(output)
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

//Protocolo comun: CustomStringConvertible
//Podemos conformar con multiples protocolos
//CustomStringConvertible requiere que se tenga una prop description
struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()
    var description: String { "Department \(name)" }
    
    init(name: String){
        self.name = name
    }
    
    mutating func add(_ person: Person){
        people.append(person)
    }
    
    //Metodos y propiedades de TabularDataSource, se dice que al tenerlas, la struct conforma TabularDataSource
    var numberOfRows: Int { people.count }
    var numberOfColumns: Int { 3 } //hardcoded porque en este ejemplo sabemos que las columnas son name, age, ageExp
    func label(forColumn column: Int) -> String {
        let columnHeader: String //hacerlo let obliga a que en algun momento se asigne esta variable en alguno de los cases
        switch column {
        case 0: columnHeader = "Employee name"
        case 1: columnHeader =  "Age"
        case 2: columnHeader =  "Years of Experience"
        default: fatalError("Invalid column header index!")
        }
        return columnHeader
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column index for person!")
        }
    }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))


printTable(department)
//Si se imprime department sin CustomStringConvertible:
//Department(name: "Engineering", people: [__lldb_expr_13.Person(name: "Eva", age: 30, yearsOfExperience: 6), __lldb_expr_13.Person(name: "Saleh", age: 40, yearsOfExperience: 18), __lldb_expr_13.Person(name: "Amit", age: 50, yearsOfExperience: 20)])

//Con CustomStringConvertible :> Department: Engineering
print(department)

//Si se usan protocolos en clases:
//class ClassName: ProtocolOne, ProtocolTwo {...}
//class ClassName: SuperClass, ProtocolOne, ProtocolTwo {...}
//Si SuperClass conforma X cantidad de protocolos, heredar de esa clase conforma tambien por defecto a esos protocolos
//Un protocolo tambien puede conformar otro protocolo :> protocol SomeProtocol: CustomStringConvertible
//Los protocolos como tal son un type
let operationsDataSource: TabularDataSource = Department(name: "Other department")
print(operationsDataSource)

//cast
//engineeringDataSource sin as Tabular... es de tipo Department
let engineeringDataSource = department as TabularDataSource

//let testPerson = Person(name: "Alejandro", age: 27, yearsOfExperience: 5)
//testPerson is TabularDataSource //false

//: [Next](@next)
