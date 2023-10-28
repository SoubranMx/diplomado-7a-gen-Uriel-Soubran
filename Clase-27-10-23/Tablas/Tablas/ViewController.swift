//
//  ViewController.swift
//  Tablas
//
//  Created by Diplomado on 27/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
//            para cells custom, necesitan registrarse primero
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    let model = TableViewModel()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func onAddTapped(_ sender: UIButton) {
        model.addRow(withTitle: textField.text ?? "")
        tableView.reloadData()
        textField.text = ""
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.getSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.getSectionTitle()
    }
// en una sola linea no es necesario el return, define cuantas rows van a "clonarse"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getCountArray()
//        switch section {
//        case 0: model.getCountArray()
//        case 1: 1
//        default:
//            2
//        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        hacerlo de esta forma puede llevar a una perdida de memoria fuerte para tablas con miles o millones de celdas
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        cell.textLabel?.text = "Holis"
//        cell.detailTextLabel?.text = "Super holis"
//        return cell
        
//        hacerlo de esta forma implica que se reutiliza una misma celda, sin crear mas celdas distintas (todas son "cell", no son "cell1", "cell2", ... , "cellN"
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell
//        necesita al menos una celda ya puesta, por lo que la primera vez que no tiene una cell, la creamos
//        if cell == nil {
//            cell = CustomTableViewCell(style: .subtitle, reuseIdentifier: "cell")
//            cell?.backgroundColor = .lightGray
//            es la flechita hasta la derecha que indica visualmente que tocar la celda lleva a otra view
//            cell?.accessoryType = .disclosureIndicator
//        }
        
        switch indexPath.section {
        case 0: cell?.backgroundColor = .systemCyan
        case 1: cell?.backgroundColor = .systemMint
        default:
            cell?.backgroundColor = .systemTeal
        }
//        con custom cells
        cell?.titleLabel.text = model.getTitle(index: indexPath)
        cell?.detailLabel.text = model.getDetail(index: indexPath)
//        para cada iteracion de la cant de cells requerida en la func de arriba, el indexPath cambia, por lo que podemos obtener para cada celda el titulo y el subtitulo para la celda usando el modelo (que viene de una estructura)
//        cell?.textLabel?.text = model.getTitle(index: indexPath)
//        cell?.detailTextLabel?.text = model.getDetail(index: indexPath)
        return cell! //ya nos aseguramos que existe al menos una celda inicial en el if cell == nil
    }
    
    //Para hacer swipe
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Delete"
    }
    
    //esto habilita el swipe
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Eliminar \(indexPath.row)")
            model.deleteRow(withIndex: indexPath)
            tableView.reloadData()
            
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
//    si no hubieramos hecho delegado de esto, habria tomado los constraints puestos en el XIB
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: 80.0
        case 1: 100.0
        default:
            150.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(model.getTitle(index: indexPath))
        performSegue(withIdentifier: "FromTableToView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
