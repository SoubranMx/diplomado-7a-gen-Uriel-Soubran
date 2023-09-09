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

enum PetIterable: String, CaseIterable {
case dog = "🐶"
case cat = "🐱"
case parrot = "🦜"
case mouse = "🐭"
case turtle = "🐢"
}

let allCases = PetIterable.allCases
print("Enumerador CaseIterable")
for pet in allCases {
    print(pet.rawValue)
}



print("Enumeradores con tipado distinto")

enum ContactMethod {
    case email(String)
    case phone(Int)
    case mail(streetName: String, zipCode: String, streetNumber: Int)
}

var myPrefContactMethod = ContactMethod.email("test@test.com")
switch myPrefContactMethod {
case .email(let strEmail): print(strEmail)
case .phone(let intPhone): print(intPhone)
case .mail(streetName: let name, zipCode: let zipCode, streetNumber: let num): print("Dirección \(name)-\(zipCode)-\(num) ")
}


print("\nEnumeradores auto referenciadas")

enum ArithmeticExpression {
    case number(Float)
    //Como puede darse el caso que se referencie a si mismo, para eso se pone indirect
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    indirect case substraction(ArithmeticExpression, ArithmeticExpression)
    indirect case divition(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four) //five y four necesitan ser del tipo ArithmeticExpression, por ello no es posible solo mandarle 5 y 4
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))


// Para que el enum sepa que hacer con la "funcion" addition y multiplication, se debe evaluar
// exprX y exprY se usaran como terminos de una expresion X + Y, siendo X el termino izquierdo y Y el termino derecho
// del mismo modo, X * Y, X - Y, etc.
func evaluate(expression: ArithmeticExpression) -> Float {
    switch expression {
    case .number(let num): return num;
    case .addition(let exprX, let exprY): return evaluate(expression: exprX) + evaluate(expression: exprY)
    case .substraction(let exprX, let exprY): return evaluate(expression: exprX) - evaluate(expression: exprY)
    case .multiplication(let exprX, let exprY): return evaluate(expression: exprX) * evaluate(expression: exprY)
    case .divition(let exprX, let exprY): return evaluate(expression: exprX) / evaluate(expression: exprY)
    }e
}

print(evaluate(expression: product))

// evaluar ( 6 + ( 4 * (8-1) ) / 2 )
var subExpr: ArithmeticExpression = ArithmeticExpression.substraction(ArithmeticExpression.number(8), ArithmeticExpression.number(1))
var divExpr: ArithmeticExpression = ArithmeticExpression.divition(subExpr, ArithmeticExpression.number(2))
var mulExpr: ArithmeticExpression = ArithmeticExpression.multiplication(ArithmeticExpression.number(4), divExpr)
var addExpr: ArithmeticExpression = ArithmeticExpression.addition(ArithmeticExpression.number(6), mulExpr)
var evaluatedExpression = evaluate(expression: addExpr)
print("Evaluacion de ( 6 + ( 4 * (8-1) ) / 2 ) = \(evaluatedExpression)")


//: [Next](@next)
