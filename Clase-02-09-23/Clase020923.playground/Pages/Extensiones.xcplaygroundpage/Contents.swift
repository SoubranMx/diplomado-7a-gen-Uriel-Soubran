//: [Previous](@previous)

import Foundation

extension Double {
    var squared: Double { self * self }
}

let sideLength: Double = 12.5
let area = sideLength.squared

//print(area)

struct Car {
    let maker: String
    let model: String
    let year: Int
    
    var fuelLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0, "New value must be between 0 and 1")
        }
    }
}

// Podemos conformar protocolos dentro de extensiones, por lo que permite manejar mejor el codigo
extension Car: CustomStringConvertible {
    var description: String { "\(maker) - \(model)" }
}

//con extensiones podemos definir inits sin tener que perder el init por defecto
extension Car {
    init(maker: String, model: String) {
        //llama al init por defecto (cuando no defines ningun init en Car)
        self.init(maker: maker, model: model, year: 2023, fuelLevel: 1.0)
    }
}

// Nested type
extension Car {
    enum Era {
        case vintage, classic, modern
    }
    
    var era: Era {
        switch year {
        case ...1990: return .vintage
        case 1991...2000: return .classic
        case 2001...: return .modern
        default: return .modern
        }
    }
}

//add methods
extension Car {
    mutating func fillFuel(){
        fuelLevel = 1.0
    }
}

let firstCar = Car( maker: "Honda", model: "Civic", year: 2015, fuelLevel: 1.9 )
print(firstCar.era)

let secondCar = Car(maker: "Tesla", model: "Y")
print(secondCar)
//: [Next](@next)
