//
//  ViewController.swift
//  VirtualPet
//
//  Created by Oguz Demırhan on 14.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var animals = ["Dummy","DummyTwo"]
    var animalImages = [Data?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("Application directory: \(NSHomeDirectory())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        getAnimals()
    }
    
    
    private func getAnimals() {
        animals.removeAll()
        animalImages.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let image = result.value(forKey: "image") as? Data else { continue }
                    
                    animalImages.append(image)
                    animals.append(name)
                }
                self.tableView.reloadData()
            } else {
            }
        } catch {
            print("Error")
        }
        
    }
    
    
   
    

}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
        cell.textLabel?.text = animals[indexPath.row]
        //cell.imageView?.image = UIImage(data: animalImages[indexPath.row]!)
        
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Warning", message: "You are about to delete an animal from your list", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Nevermind", style: .default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Ok delete it", style: .destructive, handler: { delete in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
                
                do {
                    let items = try context.fetch(fetchRequest) as! [NSManagedObject]
                 
                    
                    let data = items[indexPath.row]
                    
                    context.delete(data)

                    try context.save()
                    print("Deleted")
                    
                    self.animals.remove(at: indexPath.row)
                    
                    tableView.reloadData()
                }
                catch {
                    print(error)
                }

                
            }))
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            
        }
    }
    
    

    
}

