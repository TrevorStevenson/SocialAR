//
//  Math.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/13/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import Foundation
import CoreLocation

func degreesToRadians(degrees: Double) -> Double
{
    return degrees * .pi / 180.0
}

func radiansToDegrees(radians: Double) -> Double
{
    return radians * 180.0 / .pi
}

func distanceAndBearing(point1 : CLLocation, point2 : CLLocation) -> (distance: Double, bearing: Double)
{
    let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
    let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
    
    let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
    let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
    
    let dLon = lon2 - lon1
    let dLat = lat2 - lat1
    
    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
    let radiansBearing = atan2(y, x)
    
    let dBearing = radiansToDegrees(radians: radiansBearing)
    
    let a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2)
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    let d = 6371000 * c
    
    return (d ,(dBearing < 0) ? dBearing + 360 : dBearing)
}
