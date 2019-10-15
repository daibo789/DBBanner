//
//  DBBannerLayoutConfigs.swift
//  DBBanner
//
//  Created by botu on 2019/9/30.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public class DBBannerLayoutConfigs {
    public var itemSize: CGSize?//cellSize
    public var itemSpacing: CGFloat = 0.0 //间隙
    public var layoutProtocol: DBBannerLayoutProtocol? //布局协议
    
    
    
    // DBBannerLayoutProtocol
    public var minimumScale: CGFloat = 0.8
    public var minimumAlpha: CGFloat = 1.0
    public var maximumAngle: CGFloat = 0.2
    public var rateOfChange: CGFloat = 0.4
    public var rateHorisonMargin: CGFloat = 0.2
}


public extension DBBannerLayoutConfigs {

        func itemSize(_ itemSize: CGSize) -> DBBannerLayoutConfigs {
            self.itemSize = itemSize
            return self
        }

        func itemSpacing(_ itemSpacing: CGFloat) -> DBBannerLayoutConfigs {
            self.itemSpacing = itemSpacing
            return self
        }
        func layoutProtocol(_ layoutProtocol: DBBannerLayoutProtocol?) -> DBBannerLayoutConfigs {
           self.layoutProtocol = layoutProtocol
           return self
       }
    
}
