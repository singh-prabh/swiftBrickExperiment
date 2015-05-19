

import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"

var isFingerOnPaddle = false

// setting up constant categories for physics body bit masks
let BallCategory   : UInt32 = 0x1 << 0 // 00000000000000000000000000000001
let BottomCategory : UInt32 = 0x1 << 1 // 00000000000000000000000000000010
let BlockCategory  : UInt32 = 0x1 << 2 // 00000000000000000000000000000100
let PaddleCategory : UInt32 = 0x1 << 3 // 00000000000000000000000000001000


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
        
        let ball = childNodeWithName(BallCategoryName) as! SKSpriteNode
        ball.physicsBody!.applyImpulse( CGVectorMake( 10,-10 ))
        
        
        // Adding physics body to bottom of the screen
        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        addChild(bottom)
        
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
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent){
        
        //check if fingerOnPaddle already set to true!
        if isFingerOnPaddle {
        // get location
            var touch = touches.first as! UITouch
            var touchLocation = touch.locationInNode( self )
            var previousLocation = touch.previousLocationInNode( self )

            // get paddle node
            var paddle = childNodeWithName(PaddleCategoryName) as!SKSpriteNode
            
            //calc new position for x
            var paddleXPosition = paddle.position.x + (touchLocation.x - previousLocation.x)
            
            //cage paddle within screen bounds
            paddleXPosition = max( paddleXPosition, paddle.size.width/2)
            paddleXPosition = min(paddleXPosition, size.width - paddle.size.width/2)
            
            // update paddle to new position
            paddle.position = CGPointMake( paddleXPosition, paddle.position.y )
            
        } // end if
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        isFingerOnPaddle = false
    }
    
    
}// end class


