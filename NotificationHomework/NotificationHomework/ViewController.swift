//
//  ViewController.swift
//  NotificationHomework
//
//  Created by Oguz Demırhan on 8.05.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var notificationSenderTextField: UITextField!
    
    
    //Notification sender daki mesajı kullanıcıdan alınız..
    
    var notificationData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        notificationData["name"] = notificationSenderTextField.text
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
    }
    

}

