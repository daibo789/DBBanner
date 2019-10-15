//
//  DDBannerFlowAnimationLayout.swift
//  DBBanner
//
//  Created by botu on 2019/10/14.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class DDBannerFlowAnimationLayout: DBBannerBaseLayout {
    

    public override func layoutAnimationAttributes(collectionView: UICollectionView, configs:  DBBannerLayoutConfigs, attributes: UICollectionViewLayoutAttributes) {
           
                  let collectionViewWidth = collectionView.frame.width
                  if collectionViewWidth <= 0 { return }
                  
                  let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5;
                  let delta = abs(attributes.center.x - centetX)
                  let angle = min(delta / collectionViewWidth * (1 - configs.rateOfChange), configs.maximumAngle)
                  let alpha = max(1 - delta / collectionViewWidth, configs.minimumAlpha)
           
           applyCoverflowTransformToAttributes(viewCentetX: centetX,
                                               attributes: attributes,
                                               configs: configs,
                                               angle: angle,
                                               alpha: alpha)
       }
    
    
    
    
    func applyCoverflowTransformToAttributes(viewCentetX: CGFloat,
                                              attributes: UICollectionViewLayoutAttributes,
                                              configs: DBBannerLayoutConfigs,
                                              angle: CGFloat,
                                              alpha: CGFloat) -> Void {
           var transform3D: CATransform3D = CATransform3DIdentity
              transform3D.m34 = -0.002
              var _angle: CGFloat = angle
              var _alpha: CGFloat = alpha
              let location = DBBannerTransfrom.itemLocation(viewCentetX: viewCentetX,
                                          itemCenterX: attributes.center.x)
              
              var translate: CGFloat = 0.0
              switch location {
              case .left:
                  _angle = angle
                  translate = (1.0 - cos(_angle * (1 + configs.rateHorisonMargin) * CGFloat.pi)) * attributes.size.width
              case .right:
                  _angle = -angle
                  translate = -(1.0 - cos(_angle * (1 + configs.rateHorisonMargin) * CGFloat.pi)) * attributes.size.width
              case .center:
                  _angle = 0
                  _alpha = 1
              }
              attributes.alpha = _alpha
              transform3D = CATransform3DRotate(transform3D,
                                                           CGFloat.pi * _angle,
                                                           0, 1, 0)
              attributes.transform3D = CATransform3DTranslate(transform3D,
                                                              translate, 0, 0)
     }
    
}




public struct DBBannerTransfrom {

    public enum DBBTransformLocation {
        case left
        case center
        case right
    }
    
    public static func itemLocation(viewCentetX: CGFloat,
                      itemCenterX: CGFloat) -> DBBTransformLocation {
        var location: DBBTransformLocation = .right
        if abs(itemCenterX - viewCentetX) < 0.5 {
            location = .center
        }else if (itemCenterX - viewCentetX) < 0 {
            location = .left
        }
        return location
    }
}
