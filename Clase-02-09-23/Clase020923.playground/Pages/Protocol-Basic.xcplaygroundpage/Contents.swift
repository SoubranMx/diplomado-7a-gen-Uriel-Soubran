import Foundation

protocol Student {
    var accountNumber: Int { get }
    var name: String { get }
}

struct EngineeringStudent: Student, CustomStringConvertible {
    var accountNumber: Int
    var name: String
    let hasCalculator: Bool
    var description: String { "Engineering Student - \(name)" }
}

struct MedicineStudent: Student {
    var accountNumber: Int
    var name: String
    let hasLabCoat: Bool
}

let engineeringStudent = EngineeringStudent(accountNumber: 312096568, name: "Uriel Soubran", hasCalculator: true)

let medicineStudent = MedicineStudent(accountNumber: 312096566, name: "Dani Cao", hasLabCoat: true)

func printStudentsInformation(_ student: Student){
    print("\(student.name) - \(student.accountNumber)")
    if let medicineStudent = student as? MedicineStudent {
        print(medicineStudent.hasLabCoat)
    }
}

printStudentsInformation(engineeringStudent)
printStudentsInformation(medicineStudent)
print(engineeringStudent)
