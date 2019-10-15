//
//  DBBannerConfigs.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

//MARK:--banner配置文件
public class DBBannerConfigs{
    public var isAutoPlay: Bool = true
    
    public var isBounces: Bool = true
    
    public var isShowPageControl: Bool = true
    
    public var timeInterval: TimeInterval = 1.0
    

}



// MARK: - Public 枚举
public extension DBBannerConfigs {
    
    enum DBBannerTransitionType : String {
        case fade
    }
    
    enum CycleWay {
        case forward
        case skipEnd
        case rollingBack
    }
    
    enum RollingDirection {
        case right
        case left
    }
}




public extension DBBannerConfigs {
    
      func isAutoPlay(_ isAutoPlay: Bool) -> DBBannerConfigs {
        self.isAutoPlay = isAutoPlay
        return self
    }
    
      func isBounces(_ isBounces: Bool) -> DBBannerConfigs {
        self.isBounces = isBounces
        return self
    }
    
      func isShowPageControl(_ isShowPageControl: Bool) -> DBBannerConfigs {
        self.isShowPageControl = isShowPageControl
        return self
    }
    
      func timeInterval(_ timeInterval: TimeInterval) -> DBBannerConfigs {
        self.timeInterval = timeInterval
        return self
    }
    
  

}
