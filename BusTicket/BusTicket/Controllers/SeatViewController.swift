//
//  SeatViewController.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import UIKit

class SeatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    let ticket = Ticket.shared
    var currentSeats = [Int]()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ticket.koltukSayisi == 5 {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "You cannot choose more than 5 seats ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok :(", style: .default, handler: { alert in
                    
                    self.ticket.koltuk = self.currentSeats
                    
                    self.currentSeats.removeAll()
                    let ticketVC = self.storyboard?.instantiateViewController(identifier: "passengerTicketVC") as! PassengerTicketViewController
                    ticketVC.modalPresentationStyle = .fullScreen
                    
                    self.present(ticketVC, animated: true, completion: nil)
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
      
        }
        else {
            collectionView.cellForItem(at: indexPath)?.tintColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
            
            currentSeats.append(indexPath.row)
            ticket.koltukSayisi += 1
            
            
        }
      
      
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as! SeatCollectionViewCell
        cell.tintColor = #colorLiteral(red: 0.08500792831, green: 0.6792595983, blue: 0.7107330561, alpha: 1)
        cell.configure(withImageName: "seat")
        
        return cell
    }
    
    
    
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getTicketButtonSetup()
    }
    
    //MARK:- buttonSetup
    
    private func getTicketButtonSetup() {
        let getTicketButton = UIButton()

        getTicketButton.backgroundColor = #colorLiteral(red: 0.08500792831, green: 0.6792595983, blue: 0.7107330561, alpha: 1)
        getTicketButton.setTitle("Get Ticket", for: .normal)
        getTicketButton.setTitleColor(#colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1), for: .normal)
        getTicketButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 16.0)
        getTicketButton.addTarget(self, action: #selector(getTicketButtonAction), for: .touchUpInside)
        getTicketButton.layer.cornerRadius = 12
        getTicketButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        getTicketButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        getTicketButton.layer.shadowRadius = 2.1
        getTicketButton.layer.shadowOpacity = 0.6
        collectionView.addSubview(getTicketButton)
        
        

        NSLayoutConstraint.activate([
            getTicketButton.leftAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.leftAnchor,constant: 40),
            getTicketButton.rightAnchor.constraint(equalTo:  collectionView.safeAreaLayoutGuide.rightAnchor,constant: -40),
            getTicketButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            getTicketButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        getTicketButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    @objc func getTicketButtonAction() {
        
        self.ticket.koltuk = self.currentSeats
        currentSeats.removeAll()
        let ticketVC = storyboard?.instantiateViewController(identifier: "passengerTicketVC") as! PassengerTicketViewController
        ticketVC.modalPresentationStyle = .fullScreen
        present(ticketVC, animated: true, completion: nil)
        
    }
    
    //MARK:-configure
    
    private func configure() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(SeatCollectionViewCell.self, forCellWithReuseIdentifier: "seatCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        
        view.addSubview(collectionView)
    }
}


//MARK:- createLayout
extension SeatViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let seatSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: seatSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 50, bottom: 5, trailing: -40)
        
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                               heightDimension: .absolute(70))
        let rightGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rightGroupSize,
                                                       subitem: item, count: 2)
        
        let leftGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                               heightDimension: .absolute(70))
        let leftGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leftGroupSize, subitem: item, count: 1)
        
        
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
       
        
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [leftGroup, rightGroup, rightGroup])
        
        outerGroup.interItemSpacing = .fixed(60)
        
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.interGroupSpacing = 5
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
