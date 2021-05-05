//
//  TimeClass.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import Foundation


class TimeClass {
    var hour: Int?
    var minute: Int?
    
    init(hour: Int, min: Int) {
        self.hour = hour
        self.minute = min
    }
    func printTheTime(){
        print("hour:\(self.hour ?? 0)")
        print("min:\(self.minute ?? 0)")
    }
}
