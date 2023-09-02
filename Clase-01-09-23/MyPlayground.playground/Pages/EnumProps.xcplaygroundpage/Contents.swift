//: [Previous](@previous)

import Foundation

//Variables computadas ENUM
enum Pet: String {
    case dog = "🐶"
    case cat = "🐱"
    case mouse = "🐭"
    case parrot = "🦜"
    case turtle = "🐢"
    
    var type: String {
        //hacer un "calculo" en la variable computada
        switch self {
        case .dog, .cat, .mouse: return "mamífero"
        case .turtle: return "reptil"
        case .parrot: return "ave"
        }
    }
    
    //los inicializadores de enums son opcionales
    //el inicializador por defecto seria Dog(rawValue: )
    init?(name: String){
        switch name {
        case "dog": self.init(rawValue: "🐶")
        case "cat": self.init(rawValue: "🐱")
        case "turtle": self.init(rawValue: "🐢")
        case "mouse": self.init(rawValue: "🐭")
        case "parrot": self.init(rawValue: "🦜")
        default: return nil
        }
    }
}

let myComputedPet = Pet.dog.type
let myBird = Pet.parrot.type
let myReptile = Pet.turtle.type
let myDog = Pet(name: "dog")
//: [Next](@next)
