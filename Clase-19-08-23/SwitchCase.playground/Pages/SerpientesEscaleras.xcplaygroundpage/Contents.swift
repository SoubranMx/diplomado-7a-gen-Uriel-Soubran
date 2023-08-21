//: [Previous](@previous)

import Foundation

print("Serpientes y Escaleras")

var currentPos = 0
var dice: Int = 0

repeat {
    print("Currently at position \(currentPos)")
    dice = Int.random(in: 1...6)
    print("Dice is ... \(dice)")
    currentPos += dice
    
    switch currentPos {
    case 2:
        print("Escalera encontrada (\(currentPos)), avanza a casilla \(10)")
        currentPos = 10
    case 8:
        print("Escalera encontrada (\(currentPos)), avanza a casilla \(17)")
        currentPos = 17
    case 9:
        print("Escalera encontrada (\(currentPos)), avanza a casilla \(11)")
        currentPos = 11
    case 5:
        print("Escalera encontrada (\(currentPos)), avanza a casilla \(16)")
        currentPos = 16
        
    case 13:
        print("Serpiente encontrada (\(currentPos)), retrocede a casilla \(3)")
        currentPos = 3
    case 18:
        print("Serpiente encontrada (\(currentPos)), retrocede a casilla \(7)")
        currentPos = 7
    case 21:
        print("Serpiente encontrada (\(currentPos)), retrocede a casilla \(10)")
        currentPos = 10
    case 23:
        print("Serpiente encontrada (\(currentPos)), retrocede a casilla \(15)")
        currentPos = 15
    default:
        print("Safe!")
    }
} while currentPos < 25

print("Ganaste!")
//: [Next](@next)
