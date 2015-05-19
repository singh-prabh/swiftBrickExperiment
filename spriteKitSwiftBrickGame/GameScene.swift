

import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"

var isFingerOnPaddle = false


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        // Create a physics body that borders the screen
        let borderBody = SKPhysicsBody( edgeLoopFromRect: self.frame)
        // Set the friction of that physicsBody to 0
        borderBody.friction = 0
        // Set physicsBody of scene to borderBody
        self.physicsBody = borderBody
        
        //remove gravity
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        // Xcode 6.3 syntax:
         let ball = childNodeWithName(BallCategoryName) as! SKSpriteNode
        // Xcode 6.2 syntax:
//        let ball = childNodeWithName(BallCategoryName) as SKSpriteNode

        ball.physicsBody!.applyImpulse( CGVectorMake( 10,-10 ))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode( self )
        
        if let body = physicsWorld.bodyAtPoint( touchLocation ){
            if body.node!.name == PaddleCategoryName{
                println("Began touch on paddle!")
                isFingerOnPaddle = true
            }
        }
        
    }
    
    
}


