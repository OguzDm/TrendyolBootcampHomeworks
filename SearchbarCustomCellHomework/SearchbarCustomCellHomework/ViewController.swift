//
//  ViewController.swift
//  SearchbarCustomCellHomework
//
//  Created by Oguz Demırhan on 7.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let animals = ["Dog","Cat","Hedgehog","Lion","Meerkat","Fish","Dolphin","Penguin","Whale"]

    @IBOutlet weak var customSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var filteredAnimals = [String]()
    var isFiltering = false
    var identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customSearchBar.delegate = self
        tableView.dataSource = self
        filteredAnimals = animals
        tableView.register(.init(nibName: "EmptyTableViewCell", bundle: .main), forCellReuseIdentifier: "error")
    }


}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredAnimals = searchText.isEmpty ? animals : animals.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
            
         })
        
        if filteredAnimals.count == 0 {
            identifier = "error"
            filteredAnimals.append("dummy")
        }
        else {
            identifier = "cell"
        }

         tableView.reloadData()

    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        if identifier == "cell" {
            cell.textLabel?.text = filteredAnimals[indexPath.row]
        }
        
        else if identifier == "error" {
            print("Something")
            _ = tableView.dequeueReusableCell(withIdentifier: identifier) as! EmptyTableViewCell
            
        }
  
        
        return cell
        
    }
    
    
}

