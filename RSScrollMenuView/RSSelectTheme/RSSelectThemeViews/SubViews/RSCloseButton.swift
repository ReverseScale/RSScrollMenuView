//
//  RSCloseButton.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit

class RSCloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 10
        self.setTitle("关闭", for: .normal)
        self.setTitleColor(UIColor.gray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
