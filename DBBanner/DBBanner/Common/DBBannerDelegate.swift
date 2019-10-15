//
//  DBBannerDelegate.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public protocol DBBannerDelegate: class {
    //MARK:-----点击事件
    func dbBanner(_ banner: DBBannerStyle,didSelectItemAt index: Int)
    
    /**
     //MARK:-----当前item index
     */
    func dbBanner(_ banner: DBBannerStyle,current index: Int)
}


extension DBBannerDelegate{
    func dbBanner(_ banner: DBBannerStyle,
                  didSelectItemAt index: Int){
    
    }
    
    func dbBanner(_ banner: DBBannerStyle,current index: Int){
    
    }
}
