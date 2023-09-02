//: [Previous](@previous)

import XCTest

class MyTests: XCTestCase {
    
    func getFullName( _ nameTuple: (String, String?, String, String?) ) -> String {
        guard let second = nameTuple.1, second.count > 0 else {
            guard let secondLastName = nameTuple.3, secondLastName.count > 0 else {
                return nameTuple.0 + " " + nameTuple.2
            }
            return nameTuple.0 + " " + nameTuple.2 + " " + secondLastName
        }
        
        guard let secondLastName = nameTuple.3, secondLastName.count > 0 else {
            return nameTuple.0 + " " + second + " " + nameTuple.2
        }
        
        return nameTuple.0 + " " + second + " " + nameTuple.2 + " " + secondLastName
    }
    
    func test_GetFullName() {
        //Buena practica, dividir la prueba en 3 partes: given, when, then
        //given
        let firstPerson: (String, String?, String, String?) = (first: "Uriel", second: "Alejandro", firstLastName: "Estrada", secondLastName: "Soubran")
        let secondPerson: (String, String?, String, String?) = (first: "Manuel", second: nil, firstLastName: "Perez", secondLastName: nil)
        let thirdPerson: (String, String?, String, String?) = (first: "Dante", second: "", firstLastName: "Sanchez", secondLastName: nil)
        let fourthPerson: (String, String?, String, String?) = (first: "Dante", second: nil, firstLastName: "Sanchez", secondLastName: "")
        let fifthPerson: (String, String?, String, String?) = (first: "Dante", second: "", firstLastName: "Sanchez", secondLastName: "")
        //when
        let firstFullName = getFullName(firstPerson)
        let secondFullName = getFullName(secondPerson)
        let thirdFullName = getFullName(thirdPerson)
        let fourthFullName = getFullName(fourthPerson)
        let fifthFullName = getFullName(fifthPerson)
        
        //then
        XCTAssertEqual(firstFullName, "Uriel Alejandro Estrada Soubran")
        XCTAssertEqual(secondFullName, "Manuel Perez")
        XCTAssertEqual(thirdFullName, "Dante Sanchez")
        XCTAssertEqual(fourthFullName, "Dante Sanchez")
        XCTAssertEqual(fifthFullName, "Dante Sanchez")
        
    }
}

//Este test solo aplica para playground, en XCode correr los test es distinto

MyTests.defaultTestSuite.run()

//: [Next](@next)
