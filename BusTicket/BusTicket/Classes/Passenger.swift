//
//  Passenger.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import Foundation


class Passenger {
    
    static let shared = Passenger()
    
    var name = ""
    var surname = ""
    var id = 0
    
    func printThePassenger(){
        print("passenger name:\(name) surname:\(surname) id:\(id)")
    }
}
