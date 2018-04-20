//
//  RSSelectThemeViewController.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit


class RSMenuScrollController: UIViewController, UICollectionViewDataSource {

    var menuView: RSMenuView!   //上方滑动的菜单View
    var contentCollectionView: RSContentCollectionView!     //下方滚动的内容Cell
    var dataSource: DataSourceType!
    
    init(dataSource: DataSourceType) {
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white

        self.addMenuView()
        self.addContentCollectionView()
    }
    
    //MARK:- Private Method
    
    /// 添加菜单View
    private func addMenuView() {
        self.menuView = RSMenuView(dataSource: self.dataSource, frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 45))
        weak var weak_self = self
        self.menuView.setTapSelectThemeClosure {
            weak_self?.presentRSSelectThemeController()
        }
        
        ///点击每个菜单时的回调
        self.menuView.setDidSelectItemClosure { (indexPath) in
            weak_self?.handelMeneClickEvent(indexPath: indexPath)
        }
        
        self.view.addSubview(self.menuView)
    }
    
    /// 添加下方的内容CollectionView
    private func addContentCollectionView() {
        let y = self.menuView.frame.origin.y + self.menuView.frame.height
        self.contentCollectionView = RSContentCollectionView(frame: CGRect(x: 0, y: y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - y), data: self.dataSource[0])
        self.contentCollectionView.dataSource = self
        weak var weak_self = self
        self.contentCollectionView.setCurrentShowCellClosure { (currentShowIndexPath) in
            weak_self?.menuView.scrollToItem(indexPath: currentShowIndexPath)
        }
        self.view.addSubview(contentCollectionView)
    }
    
    /// 处理菜单点击的事件
    ///
    /// - Parameter indexPath: 点击的菜单的IndexPath
    private func handelMeneClickEvent(indexPath: IndexPath) {
        dataSource = DataSourceTools.setSelcted(dataSource: self.dataSource, index: indexPath.row)
        menuView.updateDataSource(data: self.dataSource)
        contentCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    /// 模态展示菜单编辑VC
    private func presentRSSelectThemeController() {
        let selectThemeController = RSSelectThemeController(dataSource: self.dataSource)
        
        //获取更新后的DataSource
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            self.updateDataSource(dataSource: dataSource)
            let firstIndexPath = IndexPath(row: 0, section: 0)
            self.menuView.scrollToItem(indexPath: firstIndexPath)
            self.contentCollectionView.scrollToItem(at: firstIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        self.present(selectThemeController, animated: true) {}
    }
    
    /// 编辑后更新数据源
    ///
    /// - Parameter dataSource: 编辑后的数据源
    private func updateDataSource(dataSource: DataSourceType) {
        self.dataSource = DataSourceTools.setSelcted(dataSource: dataSource, index: 0)
        self.menuView.updateDataSource(data: self.dataSource)
        self.contentCollectionView.reloadData()
    }

    
    //MARK:- UICollectionViewDataSource
    
    ///返回Section的个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///返回每个Section中Item的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.first!.count
    }
    
    ///返回相应的Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return fetchRSThemeCollectionViewCell(indexPath: indexPath)
    }
    
    func fetchRSThemeCollectionViewCell(indexPath: IndexPath ) -> RSContentCollectionViewCell {
        let cell: RSContentCollectionViewCell = self.contentCollectionView.dequeueReusableCell(withReuseIdentifier: RSContentwCellReusableIdentifier, for: indexPath) as! RSContentCollectionViewCell
        
        weak var weak_self = self
        cell.callBackBlock { () in
            weak_self?.dismiss(animated: true, completion: nil)
        }
        
        let item = dataSource[indexPath.section][indexPath.row] as RSThemeDataSourceProtocal
        cell.setContent(text: item.menuItemName())
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
