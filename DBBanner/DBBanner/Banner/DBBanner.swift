//
//  DBBanner.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class DBBanner: DBBaseBanner,DBBannerStyle {
    var indentify: String? = "DBBaseBanner"
    
    var dataSource: DBBannerDataSource?{
        didSet{
             reloadUI()
        }
    }
    
    var delegate: DBBannerDelegate?
    
    func reloadUI() {
        self.refreshDataSource()
        self.refreshDelegate()
        self.refreshData()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubUI()
    }
    
    
    override func setCurrentIndex() {
        let point = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.width * 0.5,
                            y: collectionView.contentOffset.y + collectionView.frame.height * 0.5)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            let currentPage = indexOfIndexPath(indexPath)
            delegate?.dbBanner(self, current: currentPage)
        }
    }
    
    private func setupSubUI() {
           collectionView.dataSource = self
           collectionView.delegate = self
       }
}

extension DBBanner {
    
    
    public  func scrollViewWillBeginDecelerating(
        _ scrollView: UIScrollView) {
        scrollToIndexPath(currentIndexPath,
                          animated: true)
            let currentPage = indexOfIndexPath(currentIndexPath)
            delegate?.dbBanner(self, current: currentPage)
    }
    
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,withVelocity velocity: CGPoint,targetContentOffset: UnsafeMutablePointer<CGPoint>) {
               if velocity.x > 0 {
               currentIndexPath =  IndexPath.init(row: currentIndexPath.row + 1,
                section: currentIndexPath.section)
               }else if velocity.x < 0 {
                currentIndexPath =  IndexPath.init(row: currentIndexPath.row - 1,section:currentIndexPath.section)
               }else {
                   indexPathErrorDetection()
               }
    }
    
    /// UICollectionCell 滚动错误检测
     private func indexPathErrorDetection() {
         let indexPaths = collectionView.indexPathsForVisibleItems
         var attriArr = [UICollectionViewLayoutAttributes?]()
         for indexPath in indexPaths {
             let attri = collectionView.layoutAttributesForItem(at: indexPath)
             attriArr.append(attri)
         }
         let centerX: CGFloat = collectionView.contentOffset.x + collectionView.frame.width * 0.5
         var minSpace = CGFloat(MAXFLOAT)
         var shouldSet = true
         if layout.configs?.layoutProtocol != nil && indexPaths.count <= 2 {
             shouldSet = false
         }
         for atr in attriArr {
             if let obj = atr, shouldSet {
                 obj.zIndex = 0;
                 if(abs(minSpace) > abs(obj.center.x - centerX)) {
                     minSpace = obj.center.x - centerX;
                     currentIndexPath = obj.indexPath;
                 }
             }
         }
         scrollViewWillBeginDecelerating(collectionView)
     }
    
}

extension DBBanner :UICollectionViewDataSource,UICollectionViewDelegate{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sMultiplier * pageCount
//        return sMultiplier * pageCount : pageCount
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(
                         withReuseIdentifier: cellRegister.reuseIdentifier,
                         for: indexPath)
            if let bannerViewCell = cell as? BDBannerBaseCell {
               return dataSource?.dbBanner(self,cellForItemAt: indexOfIndexPath(indexPath),cell: bannerViewCell) ?? bannerViewCell
            }
                     
                     return cell
    }
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.dbBanner(self, didSelectItemAt: indexOfIndexPath(indexPath))
        indexPathErrorDetection()
    }

    
    func indexOfIndexPath(_ indexPath : IndexPath)
        -> Int {
            return Int(indexPath.item % pageCount)
    }
}


//MARK:-------------------------refresh-----------------------------------
extension DBBanner {
    //MARK--刷新数据
    fileprivate func refreshDataSource(){
        if let _ =  dataSource?.dbBanner(numberOfItems: self) , let tempDataSource = dataSource{
            //注册cell
            if let register = dataSource?.dbBanner(self) {
                collectionView.register(register.type, forCellWithReuseIdentifier: register.reuseIdentifier)
                self.cellRegister = register
            }
            
            //items数量
            self.pageCount = tempDataSource.dbBanner(numberOfItems: self)
            
            //banner设置
            self.configs = dataSource?.dbBanner(self, configs: self.configs) ?? self.configs
            
            //布局配置
            layout.configs = tempDataSource.dbBanner(self, layoutconfigs: layout.configs ?? DBBannerLayoutConfigs())
            
        }
    }
    
    
    fileprivate func refreshDelegate() {
        // dalegate
//        if let tempDelegate = delegate {
//            tempDelegate.db
//        }
    }
   
    fileprivate func refreshData() {
    
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.bounces = configs.isBounces
        collectionView.reloadData()
        start()
        
        if pageCount > 0 {
                   //跳转到正中间
                   currentIndexPath = IndexPath(row: (sMultiplier * pageCount / 2),
                                                section: 0)
            }else {
                   currentIndexPath = IndexPath(row: 0, section: 0)
            }
        
            if pageCount > 0 {
                   scrollToIndexPath(currentIndexPath, animated: false)
             }
    }
}



extension DBBanner {
    override func autoScroll(_ sender: Timer) {
        if pageCount == 0 {
            return
        }
        
        currentIndexPath =  IndexPath.init(row: currentIndexPath.row + 1,
                       section: currentIndexPath.section)
        scrollToIndexPath(currentIndexPath,
                          animated: true)
    }
}
