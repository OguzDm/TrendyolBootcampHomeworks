//
//  TicketCollectionViewCell.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import UIKit

class TicketCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceBackgroundView: UIView!
    @IBOutlet weak var ticketBackgroundView: UIView!
    @IBOutlet weak var pickupLocationLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    @IBOutlet weak var destinationTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

}
