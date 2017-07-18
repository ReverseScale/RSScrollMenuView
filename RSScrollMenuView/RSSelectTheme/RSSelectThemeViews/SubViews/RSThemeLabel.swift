//
//  RSThemeLabel.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//
import UIKit

class RSThemeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.darkGray
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 14)
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
