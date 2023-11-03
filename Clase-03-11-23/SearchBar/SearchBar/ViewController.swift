//
//  ViewController.swift
//  SearchBar
//
//  Created by Diplomado on 03/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var filterArray = [String]()
    var dataArray = ["Primero", "Segundo", "Tercero"]

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        filterArray = dataArray
        tableView.dataSource = self
        searchBar.delegate = self
    }

    @IBAction func sortButton(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = filterArray[indexPath.row]
        return cell!
    }
    
//    Para permitir mover las rows
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        swap intercambia internamente las rows y hace un reloadData
        filterArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filterArray = []
        
        if searchText == "" {
            filterArray = dataArray
        }
        
        for word in dataArray {
            if word.uppercased().contains(searchText.uppercased()) {
                filterArray.append(word)
            }
        }
        
        tableView.reloadData()
    }
}

