//
//  PostAnchor.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/13/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import UIKit
import ARKit

class PostAnchor: ARAnchor {
    
    var content: UIImage?
    
    init(image: UIImage, transform: matrix_float4x4)
    {
        super.init(transform: transform)
        content = image
    }

}
