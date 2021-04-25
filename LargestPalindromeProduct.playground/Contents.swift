var largestPalindrome = [Int]()

for i in 500..<1000 {
    for j in 500..<1000{
        if String(i*j) == String(String(i*j).reversed()) {
            largestPalindrome.append(i*j)
            
        }
    }
}
largestPalindrome.sort(by: >)
print(largestPalindrome[0])


