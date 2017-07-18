//
//  RSContentCollectionViewCell.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit
typealias swiftBlock = () -> Void

class RSContentCollectionViewCell: UICollectionViewCell {
    var contentLabel: UILabel!
    var backButton: UIButton!
    var callBack : swiftBlock?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addContentLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContent(text: String) {
        self.contentLabel.text = text
    }
    
    private func addContentLabel() {
        self.contentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 300))
        self.contentLabel.textColor = UIColor.gray
        self.contentLabel.adjustsFontSizeToFitWidth = true
        self.contentLabel.font = UIFont.systemFont(ofSize: 55)
        self.contentLabel.textAlignment = .center
        self.contentView.addSubview(contentLabel)
        
        self.backButton = UIButton(frame: CGRect(x: 0, y: 300, width:self.frame.width, height:55))
        self.backButton.setTitleColor(UIColor.black, for: .normal)
        self.backButton.setTitle("返回", for: .normal)
        self.backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        self.contentView.addSubview(backButton)
    }
    func backAction() {
        if callBack != nil {
            callBack!()
        }
    }
    public func callBackBlock(_ block: @escaping () -> Void) {
        callBack = block
    }
}
