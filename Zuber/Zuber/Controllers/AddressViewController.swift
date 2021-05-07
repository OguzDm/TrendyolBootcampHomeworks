//
//  AdressViewController.swift
//  Zuber
//
//  Created by Oguz Demırhan on 7.05.2021.
//

import UIKit

class AddressViewController: UIViewController {

    let userDefault = UserDefaults.standard
    @IBOutlet weak var addressTitleTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var adressTextField: UITextField!
    
    var addressText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        adressTextField.text = addressText
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard let tempTitle = addressTitleTextField.text else{return}
        guard let tempAddress = adressTextField.text else{return}
        var tempTitleArray = userDefault.array(forKey: "titleArray") as! [String]
        var tempAddressArray = userDefault.array(forKey: "addressArray") as! [String]
        tempTitleArray.append(tempTitle)
        tempAddressArray.append(tempAddress)
        userDefault.set(tempTitleArray, forKey: "titleArray")
        userDefault.set(tempAddressArray, forKey: "addressArray")
        
        adressTextField.text = ""
        addressTitleTextField.text = ""
        
        
    }
    

    
}
