//
//  RSThemeDataSourceProtocal.swift
//  RSScrollMenuView
//
//  Created by WhatsXie on 2017/7/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import Foundation
protocol RSThemeDataSourceProtocal {
    func menuItemName() -> String
    func itemWidth() -> Float
    func isSelect() -> Bool
    func setSelected(select: Bool)
}
