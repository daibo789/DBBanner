//
//  DBBannerStyle.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public protocol DBBannerStyle: UIView {
    //MARK:--唯一标识
    var indentify : String? {set get
    }
        
    //MARK:--数据源协议
    var dataSource :DBBannerDataSource?{
        get set
    }
    //MARK:--代理协议
    var delegate :DBBannerDelegate?{
        get set
    }
    
    //MARK:--刷新
    func reloadUI()
}





//MARK:-------------------缓存池中区分和检索重用Model-----------------------
public struct DBBannerCellModel {
    //类型
    var type :  BDBannerBaseCell.Type
    //标识
    var reuseIdentifier : String
    
    init(type:BDBannerBaseCell.Type,reuseIdentifier:String) {
        self.type = type
        self.reuseIdentifier = reuseIdentifier
    }
    
}
