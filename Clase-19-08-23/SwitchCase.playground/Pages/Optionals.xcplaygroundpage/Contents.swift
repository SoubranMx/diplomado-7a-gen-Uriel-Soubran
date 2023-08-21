//: [Previous](@previous)

import Foundation

var cellphone: String = "5566090705"
var landline: String? = nil;

print(cellphone)
//print(landline ?? "no tengo telefono") //?? nil coalescing
//tambien funciona algo como en ts, !, para decir simon creeme aqui hay algo => print(landline!)

if let landline2 = landline {
    print(landline2)
}
//landline2 no existe fuera del scope de arriba

guard let landlineguard = landline else {fatalError("ooops")}
print(landlineguard)
//: [Next](@next)
