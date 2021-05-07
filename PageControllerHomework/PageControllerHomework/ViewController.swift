//
//  ViewController.swift
//  PageControllerHomework
//
//  Created by Oguz Demırhan on 7.05.2021.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var customPageControl: UIPageControl!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var textLabel: UILabel!
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customPageControl.numberOfPages = 3
        customPageControl.isUserInteractionEnabled = true
        
        let animation = Animation.named("locationpin")
        animationView.animation = animation
        textLabel.text = "For the best experience please open your location services."
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundColor = .clear
        animationView.play()
        skipButton.layer.cornerRadius = 12
        skipButton.backgroundColor = #colorLiteral(red: 0.5449637771, green: 0.3688879609, blue: 0.5118675232, alpha: 1)
      
        
        
    }
    
    func configure(animation name: String, label: String){
        textLabel.text = label
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundColor = .clear
        animationView.play()
    }
    
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        
        currentPage += 1
        
        if currentPage >= customPageControl.numberOfPages {
            
            currentPage = 0
        }
        
        customPageControl.currentPage = currentPage
        
        switch customPageControl.currentPage {
        case 0:
            configure(animation: "locationpin", label: "For the best experience please turn on your location services.")
        case 1:
            configure(animation: "notificationbell", label: "Do not miss anything please allow notification services.")
        default:
            configure(animation: "rocket", label: "You are ready to fly now!")
        }
        
        
        
    }
    
 
        
    

    
    
    
}



