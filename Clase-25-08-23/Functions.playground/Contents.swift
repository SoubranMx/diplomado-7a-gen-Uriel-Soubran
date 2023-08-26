import Foundation

func divideTerminalOutput(title: String){
    print("\n================\n")
    print("\(title)\n")
}

//camelCase
func myAwesomePrintingFunction(name: String){
    print("Hello \(name)!")
}

myAwesomePrintingFunction(name: "Uriel")


//lhs left hand side, rhs right hand side. Mas o menos, lo mismo que en otros lenguajes seria hacer variables x,y i,j, etc
func add(lhs: Int, rhs: Int) {
    print("\(lhs) + \(rhs) = \(lhs + rhs)")
}

add(lhs: 4, rhs: 5)


//renombrar variable local
//Se intenta que los nombres sean muy descriptivos, inclusive los parametros
//Para ello, puedes renombrar los parametros para que sean mas entendibles dentro del scope de la funcion y ademas sean mas simples de leer cuando usas la funcion.
//Por ejemplo: usage -> printWelcomeMessage(to: "Alguien)
//Por dentro de la funcion -> print("Hello, \(name)")
//Valores por defecto necesitan de un =
func printWelcomeMessage(to name: String, course: String = "Diplomado iOS") {
    print("Hello, \(name), welcome to \(course)")
}

printWelcomeMessage(to: "Uriel", course: "Diplomado Android")
printWelcomeMessage(to: "Alejandro")

//------------ PARAMS INOUT ---------------
divideTerminalOutput(title: "Parametros inout")

var error = "The process failed: "
//Para que al llamar la funcion no requiera que escribas el nombre del argumento, basta con poner guion bajo
func appendErrorCode(_ code: Int, toErrorString errorString: inout String){
    if code == 400 {
        errorString += "bad request."
    }
}
print(error)
appendErrorCode(400, toErrorString: &error)
print(error)

//-------- RETURN TYPE ------------
divideTerminalOutput(title: "Tipo de return")

//Las anteriores funcs funcionaban como si devolvieran tipo void, parecido
func welcomeMessage(to name: String) -> String {
    //Puedes omitir la palabra return si el cuerpo de la funcion es una sola linea, casi como en JS arrow funcs
//    return "Welcome \(name)"
    "Welcome \(name)"
}

var message = welcomeMessage(to: "Uriel")
print(welcomeMessage(to: "Alejandro"))

//------- SCOPE ------------
divideTerminalOutput(title: "Scope")
func areaOfTriangleWith(base: Double, height: Double) -> Double {
    let rectangle = base * height
    
    //Esta funcion, como esta dentro de la funcion areaOfTriangleWith, por scope, tiene acceso a las variables que son de areaOfTriangleWith
    func divide() -> Double {
        let unreachableVariable = "I can't be used within areaOfTriangleWith"
        return rectangle / 2
    }
    
    //no puedes acceder a la variable unreachableVariable, pues fue definida dentro del scope de divide()
    return divide()
}

print(areaOfTriangleWith(base: 4, height: 5))



//----------------- EJEMPLO EXTRA ------------------
divideTerminalOutput(title: "Split evens/odds")
func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    //() es un inicializador de los array, en este caso array vacio
    //otra forma de hacerlo seria var odds: [Int] = []
    //var odds: Array<Int> = []
    var evens = [Int]()
    var odds = [Int]()
    
    for number in numbers {
        //% es modulo usualmente, pero aqui se comporta como "reminder" (el resto, funciona distinto a modulo)
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    
    return (evens, odds)
}
let aBunchOfNumbers = [1,2,3,4,5,6,7,8,9,10,43,57,27,84]
let sortedEvenAndOddNumbers = sortedEvenOddNumbers(aBunchOfNumbers)
print("The even numbers are: \(sortedEvenAndOddNumbers.evens)")
print("The odd numbers are: \(sortedEvenAndOddNumbers.odds)")


//-------------- RETURN OPTIONALS ---------------
divideTerminalOutput(title: "Retornar opcionales")
func grabMiddleName(fullName name: (first: String, middle: String?, last: String)) -> String? {
    return name.middle
}
let middleName = grabMiddleName(fullName: (first: "Uriel", middle: nil, last: "Soubran"))
//let guard para evitar el warning de que puede que estes queriendo imprimir un nil
if let middleName = middleName {
    print(middleName)
}


//---------------- TERMINAR FUNCION ANTES ---------------
divideTerminalOutput(title: "Terminar antes una funcion")

func greetByMiddleName(fromFullname name:(first: String, middle: String?, last: String), withAge age: Int) {
    // la coma sirve como && (aunque hace early validation), puedes tambien tener condiciones or con ||
    guard let middleName = name.middle, age > 18  else {
        print("Hey, there, you must be 18+")
        return
    }
    print("Hey, \(middleName), welcome to McCarthys")
}

greetByMiddleName(fromFullname: (first: "Uriel", middle: nil, last: "Soubran"), withAge: 10)
greetByMiddleName(fromFullname: (first: "Uriel", middle: "Alejandro", last: "Soubran"), withAge: 17)
greetByMiddleName(fromFullname: (first: "Uriel", middle: "Alejandro", last: "Soubran"), withAge: 27)

// Las funciones en swift son firstClassCitizens ?
let myTypedFunction: ([Int]) -> ([Int],[Int]) = sortedEvenAndOddNumbers

myTypedFunction([])


// Challenge: https://classroom.github.com/a/f9-UgIJg
