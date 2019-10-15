//
//  DBBannerTransformLinear.swift
//  DBBanner
//
//  Created by botu on 2019/10/14.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class DBBannerAnimationLayout: DBBannerBaseLayout {
     
    public override func layoutAnimationAttributes(collectionView: UICollectionView, configs:  DBBannerLayoutConfigs, attributes: UICollectionViewLayoutAttributes)  {
           
           let collectionViewWidth = collectionView.frame.width
           if collectionViewWidth <= 0 { return }
           let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5
           let delta = abs(attributes.center.x - centetX)
           let scale = max(1 - delta / collectionViewWidth * configs.rateOfChange, configs.minimumScale)
           let alpha = max(1 - delta / collectionViewWidth, configs.minimumAlpha)
            var transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
           var _alpha = alpha
           
           // 旋转时 调整间距
           let location = DBBannerTransfrom.itemLocation(viewCentetX: centetX,
                                                         itemCenterX: attributes.center.x)
           let rate = 1.05 + configs.rateHorisonMargin
           var translate: CGFloat = 0
           switch location {
           case .left:
               translate = rate * attributes.size.width * (1 - scale) / 2
           case .right:
               translate = -rate * attributes.size.width * (1 - scale) / 2
           case .center:
               _alpha = 1.0
           }
           transform = transform.translatedBy(x: translate, y: 0)
           
           // 设置旋转
           attributes.transform = transform;
           attributes.alpha = _alpha;
       }}
