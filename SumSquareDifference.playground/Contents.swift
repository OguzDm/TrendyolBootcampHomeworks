var sumOfTheSquares = 0
var squareOfTheSum = 0
var sumOfNaturalNum = 0

for i in 1...100 {
    sumOfTheSquares += (i * i)
}

for j in 1...100 {
    sumOfNaturalNum += j
}

squareOfTheSum = sumOfNaturalNum * sumOfNaturalNum


print(squareOfTheSum - sumOfTheSquares)
