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
        if let content = postContent
        {
            postStatus(status: content, username: "tstevenson", location: locations[0])
            postContent = nil
            return
        }

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        getNearbyPosts(currentLocation: locations[0]) { (json) in
            
            // Add a new anchor to the session
            for item in json
            {
                if let post = item as? [Any]
                {
                    let anchorPos = distanceAndBearing(point1: locations[0], point2: CLLocation(latitude: post[0] as! CLLocationDegrees, longitude: post[1] as! CLLocationDegrees))
                    var translation = matrix_identity_float4x4
                    translation.columns.3.y = 1.0 * (Float(arc4random_uniform(5)) - 2)
                    translation.columns.3.z = -1.0 * Float(anchorPos.distance)
                    
                    let transform = simd_mul((self.sceneView.session.currentFrame?.camera.transform)!, translation)
                    
                    let decodedData = Data(base64Encoded: post[2] as! String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)

                    let textAnchor = PostAnchor(image: UIImage(data: decodedData!)!, transform: transform)
                    self.sceneView.session.add(anchor: textAnchor)
                }
            }
            
            self.indicatorView?.stopAnimating()
            self.indicatorBG?.removeFromSuperview()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error")
        
    }
}
