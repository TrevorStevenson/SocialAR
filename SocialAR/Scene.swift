//
//  Scene.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/13/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    var arDelegate: ARViewDelegate?
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }

        if let touchLocation = touches.first?.location(in: sceneView)
        {
            let node = atPoint(touchLocation)
            ViewController.showJobPopover(name: node.name)
        }
    }
}
