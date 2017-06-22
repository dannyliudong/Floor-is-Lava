//
//  GameViewController.swift
//  Floor is Lava
//
//  Created by liudong on 2017/6/21.
//  Copyright © 2017年 liudong. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    var gameScene: SCNScene!
    var gameView: SCNView!
    
    var playerNode: SCNNode!
    var cameraNode: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initScene()
        initScene()
        initCamera()
        initPlayer()
    
    }
    
    func initView() {
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = false
        gameView.autoenablesDefaultLighting = true
        gameView.delegate = self
    }
    
    func initScene() {
        gameScene = GameScene(named: "art.scnassets/GameScene.scn")!
        gameView.scene = gameScene
        gameView.isPlaying = true
    }
    
    func initCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
    }
    
    func initPlayer() {
        self.playerNode = gameScene.rootNode.childNode(withName: "player", recursively: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scnViewWidth = self.view.frame.width
        
        if let touch = touches.first {
            let touchLocation = touch.location(in: self.view)
            if touchLocation.x < scnViewWidth/2 {

                let direction = SCNVector3(x: -1, y: 3, z: 0)
                self.playerNode.physicsBody?.applyForce(direction, asImpulse: true)
                
                
            } else if touchLocation.x > scnViewWidth/2 {
                
                let direction = SCNVector3(x: 1, y: 3, z: 0)
                self.playerNode.physicsBody?.applyForce(direction, asImpulse: true)
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if cameraNode !== nil && playerNode != nil {
            self.cameraNode.position.y = self.playerNode.position.y
        }
        
        if playerNode.position.y < -2 || playerNode.position.z != 0{
            playerNode.position = SCNVector3(x: -1, y: 2.8, z: 0)
            
        }
        print(playerNode.position)
    
    }
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
