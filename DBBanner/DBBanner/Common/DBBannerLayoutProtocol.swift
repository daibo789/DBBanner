//
//  DBBannerLayoutProtocol.swift
//  DBBanner
//
//  Created by botu on 2019/9/30.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public protocol DBBannerLayoutProtocol {
    
    
    /**
     //MARK:----布局动画协议
     */
    func layoutAnimationAttributes(collectionView: UICollectionView, configs: DBBannerLayoutConfigs, attributes: UICollectionViewLayoutAttributes)
    
}
