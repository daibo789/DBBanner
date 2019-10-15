//
//  DBBaseBanner.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit
let sMultiplier = 1000
public class DBBaseBanner: UIView {
    var pageCount: Int = 0
    var configs: DBBannerConfigs = DBBannerConfigs()
    
    //MARK:-- 当前显示单元格
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var cellRegister: DBBannerCellModel = DBBannerCellModel(type: DBBannerCell.self,
                                                                     reuseIdentifier: "DBBannerCell")
    func setCurrentIndex(){}
    
    var timer: Timer?
    lazy var layout:DBBannerLayout = {
        let layout = DBBannerLayout()
        layout.configs = DBBannerLayoutConfigs()
        return layout
    }()
    //MARK:--占位图片
    public lazy var placeholderImgView : UIImageView = {
        let placeholderImgView = UIImageView()
        placeholderImgView.contentMode = UIView.ContentMode.scaleAspectFill
        return placeholderImgView
    }()
    
    //MARK:--collectionView
    public lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)//减速
        collectionView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return collectionView
    }()
    
    lazy var coverView: UIView = {
          let coverView: UIView = UIView()
          coverView.frame = self.bounds
          coverView.isUserInteractionEnabled = false
          coverView.autoresizingMask = [
              .flexibleWidth,
              .flexibleHeight
          ]
          return coverView
      }()
    
    
    
    
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addNotifications()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        addNotifications()

    }
    
    func setupUI(){
        self.addSubview(placeholderImgView)
        self.addSubview(collectionView)
        self.addSubview(coverView)
    }
    

    public override func layoutSubviews() {
        super.layoutSubviews()
        placeholderImgView.frame = bounds
        if pageCount > 0 {
            scrollToIndexPath(currentIndexPath, animated: false)
        }
    }
    
    deinit {
          NotificationCenter.default.removeObserver(self)
           print("\(#function) ----------> \(self)")
    }
}


//MARK:--------------------scroll------------------------
extension DBBaseBanner {
    func scrollToIndexPath(
           _ indexPath: IndexPath, animated: Bool) {
            if indexPath.row >= sMultiplier * pageCount - pageCount{
                       currentIndexPath = IndexPath(row: (sMultiplier * pageCount / 2),
                                                    section: 0)
                       scrollToIndexPath(currentIndexPath, animated: false)
                        setCurrentIndex()
                        start()
                       return
                       
                }else if indexPath.row == -1 + pageCount {
                       currentIndexPath = IndexPath(row: (sMultiplier * pageCount / 2) + (pageCount - 1),
                                                    section: 0)
                        scrollToIndexPath(currentIndexPath, animated: false)
                        setCurrentIndex()
                        start()
                       return
             }
        
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
       }
}


//MARK:--------------------通知------------------------
extension DBBaseBanner {
    //MARK:--添加通知
    func addNotifications(){
       
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
        //今入后台
       @objc func applicationDidEnterBackground(
           _ notification: Notification) {
           pause()
       }
       //激活
       @objc func applicationDidBecomeActive(
           _ notification: Notification) {
           guard pageCount > 1 else { return }
           resume()
       }
   
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            stop()
        }
    }
}


//MARK:--------------------定时器------------------------
extension DBBaseBanner {
    //MARK:--开始定时器
    func start() {
        if configs.timeInterval > 0 ,configs.isAutoPlay,pageCount > 1 {
            if timer == nil {
                 if #available(iOS 10.0, *) {
                     timer =  Timer.scheduledTimer(withTimeInterval: configs.timeInterval, repeats: true) { (timer) in
                          self.autoScroll(timer)
                         }
                    return
                }
                
                timer = Timer.scheduledTimer(timeInterval: configs.timeInterval, target: self, selector: #selector(self.autoScroll), userInfo: self.autoScroll, repeats: true)
                
            }
        }
    }
    
    
    func pause() {
           if let timer = self.timer {
               timer.fireDate = Date.distantFuture
           }
       }
       
    func resume() {
           timer?.fireDate = Date(timeIntervalSinceNow: configs.timeInterval)
    }
    
    func stop() {
           timer?.invalidate()
           timer = nil
       }
    @objc func autoScroll(_ sender: Timer) {

    }
}
