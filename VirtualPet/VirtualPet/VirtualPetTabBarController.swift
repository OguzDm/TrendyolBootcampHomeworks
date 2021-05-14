//
//  VirtualPetTabBarController.swift
//  VirtualPet
//
//  Created by Oguz Demırhan on 14.05.2021.
//

import UIKit

class VirtualPetTabBarController: UITabBarController {

    @IBOutlet weak var customTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCenterButton()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 80
        tabBar.frame.origin.y = view.frame.height - 80
    }

    
    
    func setupCenterButton() {

         let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-33, y: -18, width: 66, height: 66))
        middleBtn.setImage(UIImage(systemName:"plus.circle"), for: .normal)
        middleBtn.imageView?.contentMode = .scaleAspectFit
        middleBtn.imageView?.tintColor = .white
        middleBtn.imageEdgeInsets = UIEdgeInsets(top: 55, left: 55, bottom: 55, right: 55)
        middleBtn.backgroundColor = UIColor.systemTeal
         middleBtn.layer.cornerRadius = middleBtn.frame.size.height / 2
        
        
         
         self.tabBar.addSubview(middleBtn)
         middleBtn.addTarget(self, action: #selector(self.CenterButtonAction), for: .touchUpInside)
        

        tabBar.hitTest(middleBtn.center , with: nil)

         self.view.layoutIfNeeded()
     }
    
    @objc func CenterButtonAction(sender: UIButton) {
          self.selectedIndex = 1
        
      }
    
    
}
