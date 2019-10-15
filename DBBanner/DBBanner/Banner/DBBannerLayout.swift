//
//  DBBannerLayout.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class DBBannerLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var configs : DBBannerLayoutConfigs? {
        didSet{
            if let configs = configs {
                itemSize = configs.itemSize ?? collectionView?.bounds.size ?? CGSize(width: 2, height: 2)
                minimumLineSpacing = configs.itemSpacing
                minimumInteritemSpacing = configs.itemSpacing
            }
        }
    }
    
    /**该方法用来决定是否需要更新布局。如果collection view需要重新布局返回YES,否则返回NO,默认返回值为NO。子类重载该方法的时候，基于是否collection view的bounds的改变会引发cell和view布局的改变，给出正确的返回值。
    如果collection view的bounds改变,该方法返回YES，collection view通过调用
    invalidateLayoutWithContext方法使原来的layout失效
 **/
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) ->
           Bool {
           if let _ = configs?.layoutProtocol { return true }
           return super.shouldInvalidateLayout(forBoundsChange: newBounds)
       }
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        
        // 设置 margins
        let inset: CGFloat = (collectionView!.frame.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top: 0,
                                    left: inset,
                                    bottom: 0,
                                    right: inset)
    }
       
    
    override func layoutAttributesForElements(in rect: CGRect) ->
           [UICollectionViewLayoutAttributes]? {
     
            if (configs?.layoutProtocol) != nil {

               let attributesArray: [UICollectionViewLayoutAttributes] =
                   NSArray(array: super.layoutAttributesForElements(in: rect) ?? [],
                           copyItems: true) as! [UICollectionViewLayoutAttributes]
               let visibleRect = CGRect(origin: collectionView!.contentOffset,
                                        size: collectionView!.bounds.size)

               for attributes in attributesArray {
                   if !visibleRect.intersects(attributes.frame) { continue }
                    //布局自定义动画
                layoutAnimationAttributes(collectionView: collectionView!, configs: configs!, attributes: attributes)
               }
               return attributesArray

           }
           return super.layoutAttributesForElements(in: rect)
       }
}



extension DBBannerLayout {
    /**
     //MARK:----布局动画协议
     */
    func layoutAnimationAttributes (collectionView: UICollectionView,configs: DBBannerLayoutConfigs,attributes: UICollectionViewLayoutAttributes){
        let cProtocol = configs.layoutProtocol
        cProtocol?.layoutAnimationAttributes(collectionView: collectionView, configs: configs, attributes: attributes)
    }
}
