import Foundation
func differentTypeMultiply<T,U>( firstParamater: T, secondParameter: U) -> [T:U]{
    
    return [firstParamater:secondParameter]
    
}


differentTypeMultiply(firstParamater: 12.2, secondParameter: "Apple")

differentTypeMultiply(firstParamater: "Veli", secondParameter: 9)

differentTypeMultiply(firstParamater: ["Ankara","İstanbul"], secondParameter: Double.pi)
