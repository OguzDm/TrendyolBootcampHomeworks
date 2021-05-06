//
//  LoginViewController.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let passenger = Passenger.shared
    let ticket = Ticket.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginBackgroundView: UIView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    
    private func configure(){
        imageView.image = UIImage(named: "landscapeone")
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        loginButton.layer.cornerRadius = 8
        loginButton.layer.shadowColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        loginButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        loginButton.layer.shadowRadius = 2.1
        loginButton.layer.shadowOpacity = 0.6
        
        loginBackgroundView.layer.cornerRadius = 40
        
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2301841378, green: 0.2445887327, blue: 0.2756669521, alpha: 1).withAlphaComponent(0.6)])
        nameTextfield.layer.shadowColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        nameTextfield.layer.shadowOffset = CGSize(width: 1, height: 1)
        nameTextfield.layer.shadowRadius = 1.1
        nameTextfield.layer.shadowOpacity = 0.6
        
        surnameTextfield.attributedPlaceholder = NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2301841378, green: 0.2445887327, blue: 0.2756669521, alpha: 1).withAlphaComponent(0.6)])
        surnameTextfield.layer.shadowColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        surnameTextfield.layer.shadowOffset = CGSize(width: 1, height: 1)
        surnameTextfield.layer.shadowRadius = 1.1
        surnameTextfield.layer.shadowOpacity = 0.6
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        passenger.name = nameTextfield.text!
        passenger.surname = surnameTextfield.text!
        
        ticket.passenger = passenger
        
        print("Welcome \(passenger.name)")
        
        nameTextfield.text = ""
        surnameTextfield.text = ""
        
        let mainVC = storyboard?.instantiateViewController(identifier: "mainVC") as! ViewController
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
    
}



