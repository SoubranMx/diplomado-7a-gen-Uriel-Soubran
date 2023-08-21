import UIKit

let pointsA = (5,3)
let pointsB = (-0.5,1)
let pointsB = (-2.3,-4)

let points = pointsA

let coordinate: (Double,Double) = (0.001,0.5)

switch coordinate {
case (0.nextUp...5, 0.nextUp...5):
    print("Primer cuadrante")
}





//Guard
//cambia el scope
//si guard es verdadero, permite ejecutar lo que sigue, en else debes terminar la funcion o el workflow, ya sea mandando un error o retornando algo
let animal = "dog"
guard animal == "dog" else { fatalError("It's not a dog :c") }

print("Esto no deberia ejecutarse al saltar fatalError del guard")
