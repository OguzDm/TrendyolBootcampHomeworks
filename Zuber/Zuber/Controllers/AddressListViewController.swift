//
//  AddressListViewController.swift
//  Zuber
//
//  Created by Oguz Demırhan on 7.05.2021.
//

import UIKit

class AddressListViewController: UIViewController {

    @IBOutlet weak var addressTableView: UITableView!
    let userDefault = UserDefaults.standard
    var savedTitles = [String]()
    var savedAddresses = [String]()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        addressTableView.dataSource = self
        if let savedTitles = userDefault.array(forKey: "titleArray") as? [String], let savedAddress = userDefault.array(forKey: "addressArray") as? [String] {
            print(savedTitles)
            print(savedAddress)
            self.savedTitles = savedTitles
            self.savedAddresses = savedAddress
            addressTableView.reloadData()
        }

    }
    
}
extension AddressListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedTitles.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        let title = savedTitles[indexPath.row + 1]
        let detail = savedAddresses[indexPath.row + 1]
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = detail
        
        return cell
    }
    
    
}
