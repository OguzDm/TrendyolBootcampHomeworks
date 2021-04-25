import Foundation

extension Int {
    func isPrime() -> Bool {
        
        if self == 2 || self == 3 {
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

4.isPrime()
