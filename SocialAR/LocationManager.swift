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
import GLKit

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
        sceneView.session.pause()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        
        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        getNearbyPosts(currentLocation: locations[0]) { (json) in
            
            // Add a new anchor to the session
            for item in json
            {
                if let post = item as? [Any]
                {
                    let anchorPos = distanceAndBearing(point1: locations[0], point2: CLLocation(latitude: Double(post[0] as! String)!, longitude: Double(post[1] as! String)!))
                    
                    var translation = matrix_identity_float4x4
                    translation.columns.3.z = Float(anchorPos.distance) * -1
                    
                    let rotation = GLKMatrix4RotateY(GLKMatrix4Identity, Float(anchorPos.bearing) * 1)
                    let sRotation = matrix_float4x4.init(float4.init(rotation.m00, rotation.m10, rotation.m20, rotation.m30), float4.init(rotation.m01, rotation.m11, rotation.m21, rotation.m31), float4.init(rotation.m02, rotation.m12, rotation.m22, rotation.m32), float4.init(rotation.m03, rotation.m13, rotation.m23, rotation.m33))
                    
                    let transform = simd_mul(sRotation, translation)
                    
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
