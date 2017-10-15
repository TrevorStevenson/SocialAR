//
//  JobAnchor.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/14/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import UIKit
import ARKit

class JobAnchor: ARAnchor {
    
    var content: [String]?
    var img: UIImage
    
    init(data: [String], image: UIImage, transform: matrix_float4x4)
    {
        content = data
        img = image
        super.init(transform: transform)
    }

}
