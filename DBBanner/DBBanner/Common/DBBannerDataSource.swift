//
//  DBBannerDataSource.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public protocol DBBannerDataSource : class{
    //MARK:----------注册cell --类型:DBBannerStyle cell配置:DBBannerCellModel
    func dbBanner(_ banner: DBBannerStyle)-> DBBannerCellModel
    
    //MARK:----------Items的数量 --类型:DBBannerStyle
    func dbBanner(numberOfItems banner: DBBannerStyle)-> Int
    //MARK:----------cell实例 --类型:DBBannerStyle
    func dbBanner(_ banner: DBBannerStyle,
                     cellForItemAt index: Int,
                     cell: BDBannerBaseCell)
           -> BDBannerBaseCell
    
    //MARK:----------banner配置--类型:DBBannerStyle banner配置:DBBannerConfigs
    func dbBanner(_ banner: DBBannerStyle,configs: DBBannerConfigs)->DBBannerConfigs
    
    //MARK:----------布局配置--类型:DBBannerStyle 布局配置:DBBannerLayoutConfigs
    func dbBanner(_ banner: DBBannerStyle,layoutconfigs: DBBannerLayoutConfigs)->DBBannerLayoutConfigs
}





//MARK:----------------------默认配置------------------------------------
public extension DBBannerDataSource {
    /// 默认banner配置
    func dbBanner(_ banner: DBBannerStyle,configs: DBBannerConfigs)->DBBannerConfigs {
        return configs
    }
    
    /// 默布局配置
    func dbBanner(_ banner: DBBannerStyle,layoutconfigs: DBBannerLayoutConfigs)->DBBannerLayoutConfigs {
        return layoutconfigs
    }
}
