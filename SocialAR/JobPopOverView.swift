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
    var urlLabel: String?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .black
        nameLabel = UILabel(frame: CGRect(x: frame.size.width/2-100, y: 50, width: 200, height: 100))
        titleLabel = UILabel(frame: CGRect(x: frame.size.width/2-150, y: 175, width: 300, height: 100))
        let urlButton = UIButton(frame: CGRect(x: frame.size.width/2-120, y: 300, width: 240, height: 70))
        urlButton.setBackgroundImage(#imageLiteral(resourceName: "takeMeThere"), for: .normal)
        urlButton.addTarget(self, action: #selector(launchURL), for: .touchUpInside)
        
        let poweredLabel = UILabel(frame: CGRect(x: frame.size.width/2-100, y: 520, width: 300, height: 20))
        poweredLabel.text = "Powered by"
        poweredLabel.textColor = .white
        poweredLabel.textAlignment = .center
        
        let diceLogo = UIImageView(frame: CGRect(x: frame.size.width/2-100, y: 600, width: 200, height: 80))
        diceLogo.image = #imageLiteral(resourceName: "dice")
        
        nameLabel?.textColor = .white
        titleLabel?.textColor = .white
        nameLabel?.textAlignment = .center
        titleLabel?.textAlignment = .center
        addSubview(nameLabel!)
        addSubview(titleLabel!)
        addSubview(urlButton)
        addSubview(poweredLabel)
        addSubview(diceLogo)
        
        let dismissButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        dismissButton.setBackgroundImage(#imageLiteral(resourceName: "ExitButton"), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButton.removeFromSuperview), for: .touchUpInside)
        addSubview(dismissButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect)
    {
        layer.cornerRadius = 30.0
        layer.masksToBounds = true
    }
    
    @objc func launchURL()
    {
        let url = URL(string: urlLabel!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func dismiss(_ sender: Any)
    {
        removeFromSuperview()
    }
    
}
