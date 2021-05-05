//
//  PassengerTicketViewController.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 4.05.2021.
//

import UIKit

class PassengerTicketViewController: UIViewController {
    
    let ticket = Ticket.shared
    
    @IBOutlet weak var ticketBackgroundview: UIView!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    @IBOutlet weak var pickupLocation: UILabel!
    @IBOutlet weak var passengerFullNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var destTime: UILabel!
    @IBOutlet weak var destLocation: UILabel!
    @IBOutlet weak var timeAndDatesView: UIView!
    @IBOutlet weak var seatNumberLabel: UILabel!
    
    @IBOutlet weak var seatNumberBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTicket()
        ticket.printTheTicket()
    }
    
    func configureTicket() {
        ticketBackgroundview.layer.cornerRadius = 20
        ticketBackgroundview.layer.shadowColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        ticketBackgroundview.layer.shadowOffset = CGSize(width: 2, height: 2)
        ticketBackgroundview.layer.shadowRadius = 3.0
        ticketBackgroundview.layer.shadowOpacity = 0.6
        timeAndDatesView.layer.cornerRadius = 12
        pickupTimeLabel.text = ticket.ticketTime
        pickupLocation.text = ticket.ticketpickupLocation
        passengerFullNameLabel.text = ticket.passenger!.name + " " + ticket.passenger!.surname
        dateLabel.text = ticket.ticketDate
        destLocation.text = ticket.ticketdestLocation
        destTime.text = ticket.ticketDestTime
        seatNumberBackgroundView.layer.cornerRadius = 13
        for i in 0..<ticket.koltuk!.count {
            if i != ticket.koltukSayisi - 1 {
                seatNumberLabel.text?.append(String(ticket.koltuk![i]) + ",")
            }
            else {
                seatNumberLabel.text?.append(String(ticket.koltuk![i]))
            }
            
        }
        
        
    }
    
}
