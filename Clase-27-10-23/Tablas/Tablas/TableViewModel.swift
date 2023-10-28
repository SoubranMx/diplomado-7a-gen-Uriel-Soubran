//
//  TableViewModel.swift
//  Tablas
//
//  Created by Diplomado on 27/10/23.
//

import Foundation

struct Rows {
    var title: String
    var detail: String
}

//aqui ira todo lo que necesitemos para mandar el modelo o recibir cosas
class TableViewModel {
    var rowsArr: [Rows]
    init() {
        self.rowsArr = [Rows(title: "Pikachu", detail: "Electrico"), Rows(title: "Charmander", detail: "Fuego"), Rows(title: "Gengar", detail: "Fantasma"), Rows(title: "Lucario", detail: "Lucha")]
    }
    
    func getCountArray() -> Int { rowsArr.count }
    
    func getTitle(index: IndexPath) -> String { rowsArr[index.row].title }
    
    func getDetail(index: IndexPath) -> String { rowsArr[index.row].detail }
    
    func getSections() -> Int {3}
    func getSectionTitle() -> String {"Pokemon"}
    
    func addRow(withTitle title: String){
        rowsArr.append(Rows(title: title, detail: ""))
    }
    func deleteRow(withIndex index: IndexPath) {
        rowsArr.remove(at: index.row)
    }
}
