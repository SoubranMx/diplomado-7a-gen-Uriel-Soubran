//: [Previous](@previous)

import Foundation

class Vehicle {
    var brand: String
    let model: String
    var owner: String?
    let serialNumber: String
    let wheels: Int?
    
    var type: String {
        return (wheels ?? 0) > 0 ? "land" : "other"
    }
    
    var registration: (name: String, serialNumber: String, type: String)? {
        get {
            if let owner = owner {
                return (owner, serialNumber, type)
            }
            return nil
        }
        //newRegistration es la tupla (name, serialNumber, type)
        set (newRegistration) {
            if let newRegistration = newRegistration {
                owner = newRegistration.name
            }
        }
    }
    
    //Metodos de instancia (usables solamente al tener una instancia, como myVehicle = Vehicle(...)
    private var isMoving: Bool = false
    func move() {
        isMoving = true
    }
    func stop(){
        isMoving = false
    }
    
    func makeNoise() -> String {"Run run!"}
    
    //Metodos de tipo (usables solo con llamar a la clase Vehicle.metodo)
    //tambien encontrado como class func,
    static func describe(){
        print("A vehicle!")
    }
    
    
    
    //Inicializador designado (asegura que estará completamente inicializado)
    init(brand: String, model: String, serialNumber: String, wheels: Int?) {
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.wheels = wheels
    }
    
    
    
}

let myVehicle = Vehicle(brand: "Tesla", model: "Y", serialNumber: "000-001", wheels: 4)

myVehicle.registration = (name: "Uriel", serialNumber: "000-002", type: "other")
myVehicle.move()
//myVehicle.isMoving //con private esta variable ya no puede ser accesada por fuera
myVehicle.stop()
//myVehicle.isMoving
//Vehicle.describe()
print(myVehicle.makeNoise())

class Car: Vehicle {
    override var type: String { "Car" } //Sobreescribe la variable computada definida en Vehicle
    var isElectric: Bool
    
    init(electric: Bool) {
        self.isElectric = electric
        super.init(brand: "Toyota", model: "Prius", serialNumber: "000-001", wheels: nil)
    }
    
    override func makeNoise() -> String {"BRRRRM"}
    
    override var brand: String {
        willSet {
            print("My new brand is \(newValue)")
        }
        didSet{
            print("My last brand was \(oldValue)")
        }
    }

    //tambien puedes overreadear inits
    //aunque igual debes llamar super.init ?
    
    init(brand: String, model: String, serialNumber: String, isElectric: Bool) {
        self.isElectric = isElectric
        super.init(brand: brand, model: model, serialNumber: serialNumber, wheels: 4)
    }
    //llama al designado de su mismo nivel subclase
    convenience init(suzukiModel model: String, serialNumber: String, isElectric: Bool, boughtBy name: String) {
        self.init(brand: "Suzuki", model: model, serialNumber: serialNumber, isElectric: isElectric )
        owner = name
    }
}

var myCar = Car(electric: true)
myCar.brand
myCar.makeNoise()

var mynewCar = Car(suzukiModel: "Suzukis", serialNumber: "000-003", isElectric: true, boughtBy: "Alejandro")

mynewCar.brand = "Tesla"
//: [Next](@next)
