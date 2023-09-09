import Foundation

func myMap<T,U>(_ items: [T], _ transformer: (T)->(U) ) -> [U] {
    var result = [U]()
    for item in items {
        let transformedItem = transformer(item)
        result.append(transformedItem)
    }
    
    return result
}

let myStrings = ["one", "two", "three"]
let stringsLengths = myMap(myStrings, {
    value in
    let numberOfCharacters: Int = value.count
    return numberOfCharacters
})

print(stringsLengths)


/// Mapping a Stack
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ newItem: Element){
        items.insert(newItem, at: 0)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    func myStackMap<U>(_ transformer: (Element) -> (U) ) -> Stack<U> {
        var result = [U]()
        for item in items {
            let transformedItem = transformer(item)
            result.append(transformedItem)
        }
        
        return Stack<U>(items: result)
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)

var doubledStack = intStack.myStackMap({$0 * 2})

//print(intStack.pop())
//print(intStack.pop())
//print(doubledStack.pop())
//print(doubledStack.pop())


func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
//    return first == second // esto no se puede usar con genericos, para ello debemos usar protocolos
    return first == second
}

//print(checkIfEqual(1, 2.0))


//func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible> (_ first: T, _ second: U) -> Bool {
//    return first.description == second.description
//}
//print(checkIfDescriptionsMatch(Int(1), UInt8(1))) //si fuera 1 y 2, diria false
//
//print(checkIfDescriptionsMatch(Float(1), Double(1.0))) // true, pues ambos datos impresos en consola se ven iguales
//print(checkIfDescriptionsMatch(Int(1), 1.0)) // false, pues ambos datos impresos en consola son distintos



/// MACCY, programa de stack de copiado, gratis
/// protocolos con genericos
/// estos dos protocolos ya vienen de la libreria estandar de swift, para evitar problemas con el compilador, se comentan.
//protocol IteratorProtocol {
//    associatedtype Element
//    mutating func next () -> Element?
//}
//
////Sequence tambien es un protocolo que viene de la libreria estandar de swift
////Tiene 2 tipos asociados
//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol
//    associatedtype Element where Element == Iterator.Element
//
//    func makeIterator () -> Iterator
//}

struct Stack2<Element>: Sequence {
//    typealias Iterator = StackIterator
//    typealias Element = StackIterator<Element>.Element
//    Puede inferir los tipos gracias a la func makeIterator
    
    var items = [Element]()
    mutating func push(_ newItem: Element){
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    func myStackMap<U>(_ transformer: (Element) -> (U) ) -> Stack<U> {
        var result = [U]()
        for item in items {
            let transformedItem = transformer(item)
            result.append(transformedItem)
        }
        
        return Stack<U>(items: result)
    }
    
    //con S: Sequence, podemos pasar Set, arreglos, diccionarios, cosas iterables. tuplas no.
    mutating func pushAll<S: Sequence>(_ array: S) where S.Element == Element {
        for item in array {
            self.push(item)
        }
    }
    
    func makeIterator () -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
}

struct StackIterator<T>: IteratorProtocol {
//    typealias Element = T //Element viene de IteratorProtocol (tipo de dato asociado), es de tipo t
    //puede obviarse debido a la conformacion de la func next() -> T (en el protocolo, seria next() -> Element)
    var stack: Stack2<T>
    mutating func next() -> T? {
        return stack.pop()
    }
}

var myStackX = Stack2<Int>()
myStackX.push(10)
myStackX.push(20)
myStackX.push(30)
myStackX.pushAll([40,50,60])
//var myStackIterator = StackIterator(stack: myStackX)
//
//while let value = myStackIterator.next(){
//    print(value)
//}

for value in myStackX {
    print("for in loop: got \(value)")
}

