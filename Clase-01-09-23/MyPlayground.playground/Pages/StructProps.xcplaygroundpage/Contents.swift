//: [Previous](@previous)
import UIKit

struct Dog {
    //Propiedades almacenadas
    var isAdopted: Bool = true //variable, inicializada en true
    let color: String //lectura, el unico lugar donde puede ser inicializada es aqui, o en un init
    
    var name: String {
        //llamado previo a cambiar el valor
        //name tendra el nombre original, newName el valor actualizado
        willSet(newName) {
            print("My new name is \(newName)")
        }
        
        //una vez se hizo el cambio
        //puede escribirse didSet(oldValue) o solo didSet, reconocera en las llaves el nombre oldValue
        didSet {
            print("My old name was \(oldValue)")
        }
    }
    
    static let amountOfPaws = 4
    
    var paws: Int = 4
    var specialNeeds: Bool {
        paws != Dog.amountOfPaws //o tambien puede ser Self.amountOfPaws
    }
    
    //metodos de instancia y metodos de tipo
    func getID() -> String {
        return name + "\n" + "color: \(color)" + "\n" + "paws: \(paws)"
    }
    
    //los setters se indican con la palabra mutating, lo que quiere decir que en esa funcion cambiaras propiedades de la estructura, hacer esto triggerea el willSet, didSet, etc.
    mutating func changeName(newName: String) {
        name = newName
    }
    
    //metodos de tipo, no ligadas a una instancia
    static func describeADog() -> String {
        "Dogs are really cute, ain't it?"
    }
    
    
    //Inicializadores, constructores
    //si se declara, vamos a perder el inicializador por default
    init(name: String, isAdopted: Bool, color: String){
        self.name = name
        self.isAdopted = isAdopted
        self.color = color
    }
    
    init(adopted name: String, color: String) {
        self.name = name
        self.isAdopted = true
        self.color = color
    }
    //puedes hacer referencia a otro init
    init(bought name: String, color: String){
        self.init(name: name, isAdopted: false, color: color)
    }
    
    init(){
        self.init(adopted: "Solovino", color: "Brown")
    }
}

//con el inicializador, no entra en los observadores (willSet)
//var myDog = Dog( color: "Brown", name: "Milaneso") //este inicializador default se pierde si defines un init en el struct
var myDog = Dog(name: "Milaneso", isAdopted: true, color: "brown")
myDog.isAdopted = false

myDog.name = "Dante"


//con propiedades static puedes acceder a la propiedad sin necesidad del constructor
Dog.amountOfPaws


print(myDog.getID())


myDog.changeName(newName: "Solovino")

Dog.describeADog()

//delegacion de inicializador
var yourDog = Dog(adopted: "Chilaquil", color: "Blanco")

var hisDog = Dog(bought: "Chanclas", color: "Negro")

var streetDog = Dog()



//: [Next](@next)
