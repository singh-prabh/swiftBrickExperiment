import SpriteKit

let GameOverLabelCategoryName = "gameOverLabel"

class GameOverScene: SKScene {
    
    var gameWon:Bool = false {
        // set property observer attached to gameWon value; didSet is called did after the property value is set .. the other property observer (not being used) is willSet and its run right BEFORE a property changes
        
        didSet{
            let gameOverLabel = childNodeWithName( GameOverLabelCategoryName ) as! SKLabelNode
            gameOverLabel.text = gameWon ? "Game Won!" : "Game Over"
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // if you touch anywhere on GameOverScene; instantiate new round and load of GameScene
        if let view = view {
            let gameScene = GameScene.unarchiveFromFile("GameScene") as! GameScene
            view.presentScene( gameScene )
        }
    }
}
