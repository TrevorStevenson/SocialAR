//
//  JobPopOverView.swift
//  SocialAR
//
//  Created by Trevor Stevenson on 10/14/17.
//  Copyright © 2017 DeepBlue. All rights reserved.
//

import UIKit

class JobPopOverView: UIView
{
    var nameLabel: UILabel?
    var titleLabel: UILabel?
    var urlLabel: UILabel?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
        nameLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 100))
        titleLabel = UILabel(frame: CGRect(x: 20, y: 110, width: 200, height: 20))
        urlLabel = UILabel(frame: CGRect(x: 20, y: 220, width: 200, height: 20))
        nameLabel?.textColor = .black
        titleLabel?.textColor = .black
        urlLabel?.textColor = .black
        addSubview(nameLabel!)
        addSubview(titleLabel!)
        addSubview(urlLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = 30.0
        layer.masksToBounds = true
        
        
    }
    
    @IBAction func dismiss(_ sender: Any)
    {
        removeFromSuperview()
    }
    
}
