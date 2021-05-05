//
//  Ticket.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import Foundation


class Ticket {
    
     
    static let shared = Ticket()
    
    var passenger: Passenger?
    var ticketDate: String?
    var ticketTime: String?
    var koltuk: [Int]?
    var koltukSayisi = 0
    var ticketDestTime: String?
    var ticketpickupLocation: String?
    var ticketdestLocation: String?
    
    
    func compare(ticket : Ticket) -> Bool{
        if self.koltuk != nil {
            for i in 0..<ticket.koltuk!.count {
                if self.koltuk!.contains(ticket.koltuk![i]) {
                    
                    return true
                }
            }
            
            return false
        }
        
        return false
  
    }
    
    func resSeat(numberOf seat: Int) -> [Int]{
        
        if koltukSayisi > 0 {
            
            return koltuk!
        }
        
        else {
            
            let tempArray = repeatElement(0, count: seat)
            let tempIntArray = tempArray.map{Int($0)}
            return tempIntArray
        }
    }
    
    func setSeatToTheArray(numberOf seat: Int){
        
        koltuk?.append(seat)
        
    }
    
    func printTheTicket() {
        
        print(passenger as Any)
        print(ticketDate as Any)
        print(ticketTime as Any)
        print(ticketpickupLocation as Any)
        print(ticketdestLocation as Any)
        print(ticketDestTime as Any)
        print(koltuk as Any)
        
    }
}
