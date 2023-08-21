//: [Previous](@previous)

import Foundation

/**
 dog y cat son del mismo tipo Pet
 puedes darle raw value, valor asociado
 si no se le asigna, convertira los case en strings
 valor unico
 valores opcionales
 */
enum Pet: String {
    case dog = "🐶"
    case cat = "🐱"
    case parrot = "🦜"
    case mouse = "🐭"
    case turtle = "🐢"
}

let myPet = Pet(rawValue: "🦜")

let myTurtle: Pet = .turtle
let myParrot = Pet.parrot

print(myTurtle) //prints "turtle"

switch myPet {
case .dog:
    print(myPet!.rawValue)
case .cat:
    print(myPet!.rawValue)
case .mouse:
    print(myPet!.rawValue)
default:
    print(myPet?.rawValue)
}



//: [Next](@next)
