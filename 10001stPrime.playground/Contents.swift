import Foundation

extension Int {
    func isPrime() -> Bool {
        
        if self == 2 || self == 3  {
            return true
        }
        
        let rootOfNumber = Int(sqrt(Double(self)))
        
        
        for i in 2...rootOfNumber {
            
            if self % i == 0 {
                return false
            }
            
        }
        
        return true
    }
}

func projectEulerSeventh() -> Int{
    
    var number = 2
    var primeCount = 0
    while(true) {
        
        if number.isPrime() {
            primeCount += 1
        
            if primeCount == 10001 {
                return number
            }
        }
        
        number += 1
        
        
    }
    
}

print(projectEulerSeventh())
