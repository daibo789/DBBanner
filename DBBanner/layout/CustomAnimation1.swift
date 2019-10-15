//
//  JXCustomTransform.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/7/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


class CustomAnimation1: DBBannerBaseLayout {
    
    override func layoutAnimationAttributes(collectionView: UICollectionView, configs: DBBannerLayoutConfigs, attributes: UICollectionViewLayoutAttributes){
        
        let collectionViewWidth = collectionView.frame.width
        if collectionViewWidth <= 0 { return }
        
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5;
        let delta = abs(attributes.center.x - centetX)
        let calculateRate = 1 - delta / collectionViewWidth
        let angle = min(delta / collectionViewWidth * (1 - configs.rateOfChange), configs.maximumAngle)
        
    
        let alpha = CGFloat(0.8)
        
        
        flowToAttributes(viewCentetX: centetX,
                                            attributes: attributes,
                                            params: configs,
                                            angle: angle,
                                            alpha: alpha,
                                            calculateRate: calculateRate)
    }
    
    func flowToAttributes(viewCentetX: CGFloat,
                                             attributes: UICollectionViewLayoutAttributes,
                                             params: DBBannerLayoutConfigs,
                                             angle: CGFloat,
                                             alpha: CGFloat,
                                             calculateRate: CGFloat) -> Void {
        var transform3D: CATransform3D = CATransform3DIdentity
        
        
        let location = DBBannerTransfrom.itemLocation(viewCentetX: viewCentetX,
                                                      itemCenterX: attributes.center.x)

        var _angle = angle
        var _alpha = alpha
        var _translateX: CGFloat = 0
        var _translateY: CGFloat = 0
        attributes.zIndex = 0
        
        switch location {
        case .left:
            _angle = angle
            _translateX = 0.9 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.9 * attributes.size.height * (1 - calculateRate)
            
            
        case .right:
            _angle = -angle
            _translateX = -0.9 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.0 * attributes.size.height * (1 - calculateRate)
            
        case .center:
            _angle = 0
            _alpha = 1
            _translateY = 0
            attributes.zIndex = 10000
        }
        
        transform3D = CATransform3DTranslate(transform3D, _translateX, _translateY, 0)
        transform3D = CATransform3DRotate(transform3D, -CGFloat.pi * _angle, 0, 0, 1)
        attributes.alpha = _alpha
        attributes.transform3D = transform3D
    }

}
