//
//  TicketsViewController.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import UIKit

class TicketsViewController: UIViewController {


    var collectionView: UICollectionView! = nil
    var ticket = Ticket.shared
    var passenger = Passenger.shared
    var activeDate = "11"
    var activeTime = "12"
    var activePickupLocation = "13"
    var activeDestLocation = "14"
    var activeDestTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        print(activeDate)
        print(activeTime)
        print(activeDestTime)
        print(activeDestLocation)
        print(activePickupLocation)
        
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(.init(nibName: "TicketCollectionViewCell",
                                           bundle: .main),
                                     forCellWithReuseIdentifier: "ticket")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        view.addSubview(collectionView)
    }
    


}

extension TicketsViewController : UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ticket.ticketDate = activeDate
        ticket.passenger = passenger
        ticket.ticketdestLocation = activeDestLocation
        ticket.ticketpickupLocation = activePickupLocation
        ticket.ticketTime = activeTime
        ticket.ticketDestTime = activeDestTime
        
        let seatVC = storyboard?.instantiateViewController(identifier: "seatVC") as! SeatViewController
        present(seatVC, animated: true, completion: nil)
    }
}

extension TicketsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ticket", for: indexPath) as! TicketCollectionViewCell
        cell.ticketBackgroundView.backgroundColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        cell.ticketBackgroundView.layer.cornerRadius = 12
        cell.ticketBackgroundView.layer.borderWidth = 1.7
        cell.ticketBackgroundView.layer.borderColor = #colorLiteral(red: 0.08500792831, green: 0.6792595983, blue: 0.7107330561, alpha: 1)
        
        //TO-DO configure cell
        
        cell.destinationLabel.text = "\(activeDestLocation)"
        cell.destinationLabel.textColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        cell.pickupTimeLabel.textColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        cell.pickupLocationLabel.text = "\(activePickupLocation)"
        cell.priceBackgroundView.layer.cornerRadius = 8
        cell.priceBackgroundView.backgroundColor = #colorLiteral(red: 0.6688070297, green: 0.8481757045, blue: 0.8288198709, alpha: 1)
        cell.priceLabel.text = "100₺"
        cell.priceLabel.textColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        cell.destinationTime.text = activeDestTime
        cell.destinationTime.textColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        cell.pickupTimeLabel.text = activeTime
        
        return cell
    }
}

extension TicketsViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(UIScreen.main.bounds.height / 4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
