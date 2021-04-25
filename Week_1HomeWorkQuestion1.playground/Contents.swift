import Foundation

var charAndDict = [String: Int]()
var deletingCharachers = Set<Character>()
let charSetForQ = ["a","b","c","ç","d","e","f","g","ğ","h","ı","i","j","k","l","m","n","o","ö","p","r","s","ş","t","u","ü","v","y","z","q","w","x"]
for char in charSetForQ {
    charAndDict[char]  = 0
}


func questionOne(sentence: inout String,count: Int) {

    for char in sentence {
        
        switch char {
        case "a"..."z":
            charAndDict[String(char)]! += 1
        default:
            break
        }
        
    }

    for char in charAndDict {
        
        if char.value >= count {
            deletingCharachers.insert(Character(char.key))
        }
    }
    
    sentence.removeAll(where: {deletingCharachers.contains($0)})
  

    let trimmed = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
    print(trimmed)

}

var mySentence = "aaba kouq bux"
questionOne(sentence: &mySentence,count: 3)

