//
//  RSThemeEditButton.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit

class RSThemeEditButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 10
        self.setTitle("编辑", for: .normal)
        self.setTitle("完成", for: .selected)
        self.setTitleColor(UIColor.gray, for: .normal)
        self.isSelected = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
