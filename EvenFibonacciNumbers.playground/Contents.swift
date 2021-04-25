var fib1 = 1
var fib2 = 2
var fibNum : Int
var fibSum = fib2

while (fibSum <= 4000000) {
    fibNum = fib2
    fib2 = fib1 + fib2
    fib1 = fibNum
    if fib2 % 2 == 0 {
        fibSum += fib2
    }

}
print(fibSum)
