//
//  DateClass.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import Foundation


class DateClass {
    
    var day: Int?
    var month: Int?
    var year: Int?
    
    init(dd: Int, MM: Int, YYYY: Int) {
        self.day = dd
        self.month = MM
        self.year = YYYY
    }
    
    func printTheDate(){
        print(day as Any)
        print(month as Any)
        print(year as Any)
    }
}
