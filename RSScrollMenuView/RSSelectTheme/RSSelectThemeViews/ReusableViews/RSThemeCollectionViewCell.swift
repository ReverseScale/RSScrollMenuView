//
//  RSThemeCollectionViewCell.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit
typealias TapButtonClosure = (RSThemeCollectionViewCell) -> Void
class RSThemeCollectionViewCell: UICollectionViewCell {
    
    var textLabel: RSThemeLabel!    //菜单Name显示的Label
    var editTagImageView: UIImageView!  //cell的背景图片
    var tapButtonClosure: TapButtonClosure!     //点击Cell上的按钮事件
    var editButton: UIButton!   //编辑Cell的按钮
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = UIImageView(image: UIImage(named: "cell_background"))
        self.addTitleLabel()
        self.addImageView()
        self.addTapButton()
    }
    
    func setTapButtonClosure(closure: @escaping TapButtonClosure) {
        self.tapButtonClosure = closure
    }
    
    func addTitleLabel() {
        if textLabel == nil {
            textLabel = RSThemeLabel(frame: self.contentView.bounds)
            self.contentView.addSubview(textLabel)
        }
    }
    
    func addImageView() {
        self.editTagImageView = UIImageView(frame: CGRect(x: self.frame.width - 10, y: 0, width: 10, height: 10))
        self.editTagImageView.image = UIImage(named: "feedback_delete_image_icon")
        self.isHiddenEditImageView(isHidden: true)
        self.addSubview(self.editTagImageView)
    }
    
    func addTapButton() {
        editButton = UIButton(frame: self.contentView.bounds)
        editButton.setTitle("", for: .normal)
        editButton.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        self.contentView.addSubview(editButton)
    }
    
    @objc func tapButton(sender: UIButton) {
        if self.tapButtonClosure != nil {
            self.tapButtonClosure(self)
        }
    }
    
    func isHiddenEditImageView(isHidden: Bool) {
        self.editTagImageView.isHidden = isHidden
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
