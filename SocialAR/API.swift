//
//  API.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/13/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

func updateStatus(status: String, username : String, location: CLLocation)
{
    let requestUrl = "https://secure-river-29415.herokuapp.com/addNewLocation/\(location.coordinate.latitude)/\(location.coordinate.longitude)"
    let parameters: Parameters = ["username" : username, "textpost" : status]
    
    Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
}

func getNearbyPosts(currentLocation: CLLocation, completion: @escaping (String) -> Void)
{
    let requestUrl = "https://secure-river-29415.herokuapp.com/\(currentLocation.coordinate.latitude)/\(currentLocation.coordinate.longitude)"
    
    Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).response { response in
        
        if let data = String(data: response.data!, encoding: .ascii)
        {
            completion(data)
        }
    }
    
}
