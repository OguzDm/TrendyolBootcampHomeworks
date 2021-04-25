var str = "Around the world around the world Around the world around the world Around the world around the world Around the world around the world Around the world around the world"

// Örnek olarak Daft Punk'ın Around the world şarkısından 5 satır lyricsini kullandım

func splitStringsWithFrequency(givenString: String) -> [String:Int] {
    var count = 0
    var stringAndCountDict = [String:Int]()
    let stringArray = givenString.split(separator: " ")
    
    for i in 0..<stringArray.count{
     
        for j in 0..<stringArray.count{
            
            if stringArray[i].lowercased() == stringArray[j].lowercased() {  // Küçük büyük harf farkı yaşamadan "Aynı" kelimeyi almak için .lowercased kullandım
                count = count + 1
                
                stringAndCountDict[String(stringArray[i].lowercased())] = count
            }
            
        }
        count = 0
    }
    
    
    return stringAndCountDict
}


print(splitStringsWithFrequency(givenString: str))
