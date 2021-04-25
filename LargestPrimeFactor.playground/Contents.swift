var givenNumber = 600851475143
var primeNumber = 2

while givenNumber > 1 {
    
    if givenNumber % primeNumber == 0 {
        print(primeNumber)
        givenNumber /= primeNumber
    }
    else{
        primeNumber += 1
    }
    
    
}
print(primeNumber)




