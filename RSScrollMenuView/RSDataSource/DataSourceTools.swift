//
//  DataSourceTools.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//
import UIKit

class MeteData: RSThemeDataSourceProtocal {
    var name: String = ""
    var width: Float = 30
    var selected: Bool = false
    init(name: String) {
        self.name = name
        self.width = Float(calculateContentWidth(contentText: self.name))
    }
    
    func menuItemName() -> String {
        return self.name
    }
    
    func itemWidth() -> Float {
       return self.width
    }
    
    func isSelect() -> Bool {
        return self.selected
    }
    
    func setSelected(select: Bool) {
        self.selected = select
    }
    
    func calculateContentWidth(contentText: String) -> CGFloat {
        let maxLabelSize: CGSize = CGSize(width: 1000, height: 0)
        let contentNSString = contentText as NSString
        let rect = contentNSString.boundingRect(with: maxLabelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)], context: nil)
        return rect.size.width

    }
}

let MenuName: Array<Array<String>> = [["推荐", "博客园","语录", "汽车", "正能量", "美图", "房产", "故事", "美女", "北京", "热点", "小说",  "菜谱", "旅游", "电影", "家居", "游戏"], ["养生", "历史", "科学", "国际", "娱乐", "数码", "财经", "星座", "精选","问答", "彩票", "特卖", "热点", "人文", "音乐", "宠物", "教育"]]


class DataSourceTools: NSObject {
    class func createDataSource() -> DataSourceType {
        var dataSource = Array<Array<RSThemeDataSourceProtocal>>()
        
        for items in MenuName {
            var subArray = Array<RSThemeDataSourceProtocal>()
            for item in items {
                subArray.append(MeteData(name: item))
            }
            dataSource.append(subArray)
        }
        
        dataSource.first?.first?.setSelected(select: true)
        
//        for i in 0..<2 {
//            var subArray = Array<CEThemeDataSourceProtocal>()
//            for j in 0..<15 {
//                if j % 3 == 0 {
//                    subArray.append(MeteData(name: "特选频道\(i)-\(j)"))
//                } else {
//                    subArray.append(MeteData(name: "频道\(i)-\(j)"))
//                }
//                
//            }
//            dataSource.append(subArray)
//        }
        
        return dataSource
    }
    
    class func displayDataSource(dataSource: DataSourceType) {
        for items in dataSource {
            print("======Section=======")
            for item in items {
                print(item.menuItemName())
            }
            print("\n\n")
        }
    }
    
    class func setSelcted( dataSource: DataSourceType, index: Int) -> DataSourceType {
        for items in dataSource {
            for item in items {
                item.setSelected(select: false)
            }
        }
        
        if index < (dataSource.first?.count)! {
            dataSource[0][index].setSelected(select: true)
        }
        
        return dataSource
    }
    
    
}
