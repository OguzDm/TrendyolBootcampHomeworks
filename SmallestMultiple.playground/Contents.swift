var number = 20

while number < 100000 {
    
    var isDivided = true
    for i in 1...20 {
        if number % i != 0 {
            isDivided = false
            }
        }
        if isDivided {
                print(number)
            }
    
    number += 1
    print(number)
        }
    






