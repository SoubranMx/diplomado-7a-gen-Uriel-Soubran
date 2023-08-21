//: [Previous](@previous)

import Foundation

//for y while, repeat while

//for valor in rango
//rango es 0...x, 0...var.count, array, etc. Algo iterable, como en JS
//... close range?
for i in 1...5 {
    print(i)
}

print("===================")
let numbers = [1,3,5,7]

for number in numbers {
    print(number)
}

print("===================")

//i = 0, i < 20, i+=5
let intervals = stride(from:0, to:20, by:5)
//i = 0, i <= 20, i+=5
//stride(from:0, through:20,by:5)

for interval in intervals {
    print(interval)
}

print("===================")

let pokemon = ["Fire": "Charmander", "Water":"Mudkip", "Grass":"Turtwig","Electric":"Pikachu"]

for (type,name) in pokemon {
    print("I like \(name) of type \(type)")
}

for poke in pokemon {
    print("I like \(poke.value) of type \(poke.key)")
}

print("===================")

let names: Set = ["james", "dean","sam","steve","chris"]
var index = 0
for _ in names {
    print(index)
    index += 1
}

//forma elegante
let namesArr = ["james","dean","sam","steve","chris"]
for (indexTuple, nameTuple) in namesArr.enumerated() {
    print(indexTuple, nameTuple)
}

//Tambien funciona en tuplas
for (index, poke) in pokemon.enumerated() {
    print("\(index) - \(poke)")
}

for (index, (type, name)) in pokemon.enumerated() {
    print("\(index): \(type) - \(name)")
}


//Condicionales en el for
for (index,name) in names.enumerated() {
    if index % 2 == 0 {
        print(name)
    } else {break}
}

for (index,name) in names.enumerated() {
    if index % 2 == 0 {
        continue
    }
    print(name)
}

//cual es la diferencia de where a if
for (index,name) in names.enumerated() where index % 2 == 0 {
        print(name)
    
}

for poke in pokemon where poke.key == "Fire" {
    print(poke.value)
}

//: [Next](@next)
