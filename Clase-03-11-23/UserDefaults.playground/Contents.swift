import UIKit
//MARK: user defaults es la manera sencilla para guardar informacion en la memoria del dispositivo
//MARK: se parece, en web, a localStorage, no es un lugar para guardar información sensible

let defaults = UserDefaults.standard

//MARK: Guardar datos
//ejemplo en web: { "Entero": 5 }
//set(item, key)
defaults.set(5, forKey: "Entero")
defaults.setValue("string", forKey: "String")
defaults.setValue(["Uno", "Dos"], forKey: "Array")

//Si quisieramos guardar un arreglo de estructuras, no se puede hacer de esta forma, pues solo sirve para datos que XCode conoce por defecto, necesitamos conformar al protocolo Codable, sin esto swift no es capaz de castear a valores que necesita
//En si, en web seria como hacer un JSON.stringify de un objeto y luego un JSON.parse cuando lo recuperas
struct myStruct: Codable {
    var varUno: String
    var varDos: Int
}
let myArray = [myStruct(varUno: "Uno", varDos: 1), myStruct(varUno: "Dos", varDos: 2)]
if let encodedData = try? JSONEncoder().encode(myArray) {
//    Guarda el JSON codificado, como si hubiera sido un localStorage.set( JSON.stringify(objeto) ... )
    defaults.set(encodedData, forKey: "Struct")
}

//Es util tener las llaves dentro de un arreglo


//MARK: Recuperar valores
defaults.object(forKey: "Entero") //Trae any
defaults.integer(forKey: "String") //Si sabes que el tipo de dato es un int o cualquier valor que venga en la key lo intenta castear en uno.
//convertir "string" en un int, devuelve un 0 en playground, en realidad obtiene un nil, en app crashearia

//defaults puede recuperar en muchos tipos de objetos, bool, string, float, etc defaults.bool, defaults.string, etc
//cuando se obtiene de tipo de object, es de tipo any, por lo que si hicieramos let numero = defaults.object(forKey: "Entero")
//y luego quisieramos hacer numero + 3, tira errores porque es any.
//Para quitar eso, podrias o castear el object o directamente hacer defaults.tipado
defaults.array(forKey: "Array")


//MARK: Obtener valores de un JSONDecoder
if let savedData = defaults.data(forKey: "Struct"), let decodedArray = try? JSONDecoder().decode([myStruct].self, from: savedData) {
//    decodedArray ahora contiene los datos guardados
    print(decodedArray[0]) //lo imprime como un string, es decir, el stringified aunque dentro de un Array<myStruct>
    print(type(of: decodedArray))
} else {
//    No se encontraron datos guardados o hubo un error al decodificar
    print("error")
}
