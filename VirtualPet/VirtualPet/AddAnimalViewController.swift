//
//  AddAnimalViewController.swift
//  VirtualPet
//
//  Created by Oguz Demırhan on 14.05.2021.
//

import UIKit
import CoreData

class AddAnimalViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var animalNameTextField: UITextField!
    
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalImageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        animalImageView.addGestureRecognizer(tapRecognizer)

    }
    
    @objc func choosePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    

    @IBAction func addAnimalButtonTapped(_ sender: UIButton) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Animal", into: context)
        newCook.setValue(animalNameTextField.text, forKey: "name")
        let imageData = animalImageView.image?.jpegData(compressionQuality: 0.5)
        
        print("Data: \(String(data: imageData!, encoding: .utf8))")
        newCook.setValue(imageData, forKey: "image")
        
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
        
        animalNameTextField.text = ""
        animalImageView.image = UIImage(systemName: "plus.circle")
    }
    
    
    
    
}

extension AddAnimalViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        animalImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
