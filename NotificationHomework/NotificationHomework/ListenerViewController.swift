//
//  ListenerViewController.swift
//  NotificationHomework
//
//  Created by Oguz Demırhan on 8.05.2021.
//

import UIKit

class ListenerViewController: UIViewController {

    @IBOutlet weak var notificationDataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter: NotificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
    }
    
    @objc func changeLabel() {
     }
    
    @objc func handleData(notification:Notification) {
         
         if let name = notification.userInfo?["name"] as? String {
             notificationDataLabel.text = name
         }
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Notification.Name {
    static let sendDataNotification = Notification.Name(rawValue: "sendData")
}
