//
//  LocationManager.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/14/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import CoreLocation
import ARKit
import SpriteKit

extension ViewController
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        getNearbyPosts(currentLocation: locations[0]) { (s) in
            
            var translation = matrix_identity_float4x4
            
            translation.columns.3.z = -0.01 * (Float(arc4random_uniform(16)) + 5)
            let transform = simd_mul((self.sceneView.session.currentFrame?.camera.transform)!, translation)
            
            // Add a new anchor to the session
            let anchor = PostAnchor(status: s, transform: transform)
            self.sceneView.session.add(anchor: anchor)
            
            self.indicatorView?.stopAnimating()
            self.indicatorBG?.removeFromSuperview()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error")
        
    }
}
