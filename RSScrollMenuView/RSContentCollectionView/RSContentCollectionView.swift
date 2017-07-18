//
//  RSContentCollectionView.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit
let RSContentwCellReusableIdentifier = "RSContentCollectionViewCell"
typealias RSCurrentShowContentCellClosureType = (IndexPath) -> ()
class RSContentCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let minimumLineAndInteritemSpacingForSection: CGFloat = 0   //cell的行间距
    private var data: Array<RSThemeDataSourceProtocal>!
    private var willDisplayIndexPath: IndexPath!                        //记录将要显示Cell的IndexPath
    private var currentShowCellClosure: RSCurrentShowContentCellClosureType!    //将当期显示的Cell的IndexPath回调出去
    private var scrollDragEnd: Bool = false                                     //标记是否用户滑动的标记
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
    public func setCurrentShowCellClosure(closure: @escaping RSCurrentShowContentCellClosureType) {
        self.currentShowCellClosure = closure
    }
    
    //MARK:- Private Method
    private func configCurrentView() {
        self.register(RSContentCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: RSContentwCellReusableIdentifier)
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
        self.isPagingEnabled = true
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.willDisplayIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.willDisplayIndexPath == nil {
            return
        }
        
        if self.willDisplayIndexPath.row == indexPath.row {
            return
        }
        
        //只有再内容ContentView拖动结束后再更新当前显示的IndexPath
        if self.currentShowCellClosure != nil && self.scrollDragEnd {
            self.currentShowCellClosure(self.willDisplayIndexPath)
            self.scrollDragEnd = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollDragEnd = true
    }
    
    
    //MARK:- UICollectionViewDelegateFlowLayout
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
