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
