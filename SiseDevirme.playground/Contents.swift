import UIKit

class Thrower {
    
    var teta :Int {
        didSet {
            if teta > 90 {
            teta = 90
        }
            else if teta < 0 {
                teta = 0
            }
            
        }
    }
    var speed : Int {
        didSet {
            
            if speed > 100 {
                speed = 100
            }
            
            else if speed < 0 {
                    speed = 0
                }
            }
        }
    
    init(teta: Int,speed:Int) {
        self.teta = teta
        self.speed = speed
    }
    
    
    func firlat() -> Int{
        
        var range = self.speed * self.speed
        
        let sinus = sin(2.0 * Double(self.teta))
        
        
        range = Int(Double(range) * sinus) / 10
        
        
        
        return range
    }
}


class Bottle {
    
    var position: Int {
        didSet {
            
            if position > 1500 {
                position = 1500
            }
            else if position < 0 {
                position = 0
            }
        }
    }
    
    var delta: Double {
        
        didSet {
            if delta > 1.0 {
                delta = 1.0
            }
            
            else if delta < 0.1 {
                delta = 0.1
            }
        }
    }
    
    var state : Bool
    
    init(state: Bool, delta: Double, position: Int) {
        
        self.state = state
        self.delta = delta
        self.position = position
    }
    
}

class Player {
    
    var playerNickName: String
    var score = 0
    
    init(nickName : String) {
        self.playerNickName = nickName
    }
    
}


class Game {
    
    var player : Player?
    var thrower : Thrower?
    var bottle : Bottle?
    
    init(player: Player, thrower: Thrower, bottle: Bottle) {
        self.player = player
        self.thrower = thrower
        self.bottle = bottle
    }
    
    
    func setTheNickName(nickName:String){
        player?.playerNickName = nickName
        
    }
    
    func setTheBottle(delta: Double,position: Int) {
        bottle?.position = position
        bottle?.delta = delta
    }
    
    func setTheThrower(teta: Int, speed: Int) {
        thrower?.speed = speed
        thrower?.teta = teta
        
    }
    
    func firlat() {
        
        guard let rangeValue = thrower?.firlat() else {return}
        
        if rangeValue >= bottle!.position - Int(bottle!.delta) && rangeValue <= bottle!.position + Int(bottle!.delta) {
         
            print("vuruldu")
            player?.score += 1
            
            print(player?.score)
        }
    }
    
    
    
    
}

let playerOne = Player(nickName: "Player1")
let throwerOne = Thrower(teta: 90, speed: 20)
let bottleOne = Bottle(state: false, delta: 8.2, position: 20)

let crazyBirds = Game(player: playerOne, thrower: throwerOne, bottle: bottleOne)

crazyBirds.setTheNickName(nickName: "PlayerOne")
crazyBirds.setTheBottle(delta: 0.8, position: 350)
crazyBirds.setTheThrower(teta: 80, speed: 70)


print(crazyBirds.player?.playerNickName)
print(crazyBirds.player?.score)





crazyBirds.firlat()









    
    


