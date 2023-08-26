//: [Previous](@previous)

// STRUCT VS CLASS

import Foundation


//Puedes pasar enumeradores como tipos de dato
// Una estructura se maneja por valor
print("Struct")
struct Car {
    var wheels: Int
    var color: String
}


// let myCar = Car()   -> si se deja asi, no sabe como inicializar wheels, para ello puedes usar:
let myCar = Car(wheels: 4, color: "Black")

struct Dog {
    var name: String
    var isAdopted: Bool
}
var dante = Dog(name: "Dante", isAdopted: true)
dante.name = "Danis"

//Todas las estructuras se manejan por valor, por tanto, las copias son distintas
var danteClon = dante
danteClon.isAdopted = false
dante.isAdopted
danteClon.isAdopted


//Clases
print("\nClass")
class cCar {
    var wheels: Int
    var color: String
    
    init(wheels: Int, color: String) {
        self.wheels = wheels
        self.color = color
    }
}

var classCar = cCar(wheels: 4, color: "Red")
//cCar.color = "Blue" no puedes hacer esto, como si podias en struct, debido a que la clase no tiene la referencia. No estamos accediendo al objeto, sino a donde esta el objeto. Esta como encapsulado por defecto.
classCar.color = "Green"
let copyOfcCar = classCar  //Lo que se copia no es el objeto, sino una referencia al objeto ?
copyOfcCar.color = "Blue"

//Como ambas cosas se refieren al mismo lugar, ambas van a tener Blue al final.

print(classCar.color)
print(copyOfcCar.color)


//Herencia
class Vehicle {
    var wheels: Int? //vehiculo puede ser un coche, moto, lancha, etc Si hay algo, va a ser un Int, pero si no entonces es vacio
    
    //Puedes heredar inicializadores
    init(wheels: Int) {
        self.wheels = wheels
    }
    init(){}
}

class Scooter: Vehicle {
    //como Vehicle tiene una variable opcional, incluye por herencia a wheels, y como wheels es opcional, no es necesario inicializarlo, a menos que definas varios init (polymorph)
//    override var wheels: Int? { return 2 }
    var color: String
    init(color: String = "Blue") {
        super.init(wheels: 2)
        self.color = color
    }
    
}

let myScooter = Scooter() //por tanto, esto funciona sin problema, por lo descrito arriba
let scooterInitHeredited = Scooter(wheels: 2) //Scooter hereda el init de Vehicle descrito en line:63

//: [Next](@next)
