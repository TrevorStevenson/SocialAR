//
//  ViewController.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/13/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSKViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    lazy var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var indicatorView: UIActivityIndicatorView?
    var indicatorBG: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 500
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        if let postAnchor = anchor as? PostAnchor
        {
            let labelNode = SKLabelNode(text: postAnchor.content)
            labelNode.numberOfLines = 0
            labelNode.preferredMaxLayoutWidth = 250
            labelNode.lineBreakMode = .byWordWrapping
            labelNode.horizontalAlignmentMode = .center
            labelNode.verticalAlignmentMode = .center
            return labelNode
        }
        
        return SKLabelNode(text: "Hello World!")
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    @IBAction func showPosts(_ sender: Any)
    {
        locationManager.requestLocation()
        
        indicatorBG = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 50, height: 50)))
        
        if let bg = indicatorBG
        {
            bg.backgroundColor = .black
            bg.layer.cornerRadius = 10.0
            bg.layer.masksToBounds = true
            view.addSubview(bg)
        }
        
        indicatorView = UIActivityIndicatorView(frame: CGRect(origin: view.center, size: CGSize(width: 50, height: 50)))
        
        if let inView = indicatorView
        {
            view.addSubview(inView)
            inView.startAnimating()
        }
    }
}
