
enum Direction {
    
    case top
    case topRight
    case right
    case rightDown
    case down
    case leftDown
    case left
    case topLeft
}

func playerTurnAround() {
    
    for degree in 0...360 {
        
        switch degree {
        case 0...22:
            print("Player going \(Direction.top) with \(degree)")
        case 23...67:
            print("Player going \(Direction.topRight) with \(degree)")
        case 68...112:
            print("Player going\(Direction.right) with \(degree)")
        case 113...157:
            print("Player going \(Direction.rightDown) with \(degree)")
        case 158...202:
            print("Player going \(Direction.down) with \(degree)")
        case 203...247:
            print("Player going \(Direction.leftDown) with \(degree)")
        case 248...292:
            print("Player going \(Direction.left) with \(degree)")
        case 293...337:
            print("Player going \(Direction.topLeft) with \(degree)")
        case 338...359:
            print("Player going \(Direction.top) with \(degree)")
        default:
            print("Player going \(Direction.top) with \(degree)")
        }
    }
    
}

playerTurnAround()
