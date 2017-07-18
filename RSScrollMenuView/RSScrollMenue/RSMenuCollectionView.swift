//
//  RSMenuCollectionView.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit
let MenuCellReuseIdentifier = "RSMenuCollectionViewCell"
typealias RSDidSelectItemClosureType = (IndexPath) -> ()
class RSMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let minimumLineAndInteritemSpacingForSection: CGFloat = 15  //菜单的左右边距
    private var data: Array<RSThemeDataSourceProtocal>!
    private var didSelectItmeClosure: RSDidSelectItemClosureType!       //点击菜单Cell要执行的回调
    private var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    //MARK:- Life Cycle
    init(frame: CGRect, data: Array<RSThemeDataSourceProtocal>) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.configCurrentView()
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public Method
    public func setDidSelectItemClosure(closure: @escaping RSDidSelectItemClosureType) {
        self.didSelectItmeClosure = closure
    }
    
    public func setDataSource(data: Array<RSThemeDataSourceProtocal>!) {
        self.data = data
    }
    
    //MARK:- Private Method
    private func configCurrentView() {
        self.register(RSMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: MenuCellReuseIdentifier)
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //将点击的Cell移到中点
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
        if self.didSelectItmeClosure != nil{
            self.didSelectItmeClosure(indexPath)
        }
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(self.data[indexPath.row].itemWidth())  , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }


}
