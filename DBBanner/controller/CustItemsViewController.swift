//
//  CustItemsViewController.swift
//  DBBanner
//
//  Created by botu on 2019/10/15.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class CustItemsViewController: UIViewController {
     
    var data:[DefultModel] = [
        DefultModel(icon:"timg",title:"斗罗生姜",iconUrl:"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=196179111,3839526291&fm=26&gp=0.jpg"),
        DefultModel(icon:"timg",title:"千手斗罗",iconUrl:"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2409440235,1502401388&fm=26&gp=0.jpg"),
        DefultModel(icon:"timg",title:"肉骨斗罗",iconUrl:"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2931041332,2249046569&fm=26&gp=0.jpg"),
        DefultModel(icon:"timg",title:"大香肠叔叔",iconUrl:"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3467141532,4067544460&fm=26&gp=0.jpg")
    ]
    
    lazy var banner: DBBanner = {
        let banner = DBBanner()
        banner.backgroundColor = UIColor.black
        banner.placeholderImgView.image = UIImage(named: "bg")
        banner.configs.isAutoPlay = false
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    
    public lazy var numLabel: UILabel = {
              let label = UILabel()
              label.frame = CGRect(x: 16,
                                   y: 0,
                                   width: 40,
                                   height: 40)
              label.textColor = UIColor.white
              label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
              label.layer.cornerRadius = 20
              label.clipsToBounds = true
              label.textAlignment = .center
              label.font = UIFont.systemFont(ofSize: 18)
              return label
          }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "custitems"
        banner.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.width )
        self.view.addSubview(banner)
        banner.addSubview(numLabel)
        numLabel.frame = CGRect(x: banner.frame.size.width - 60, y: banner.frame.size.width - 60, width: 40, height: 40)
        numLabel.text = "0/\(data.count)"
        self.view.backgroundColor = UIColor.white
    }


}



extension CustItemsViewController: DBBannerDelegate,DBBannerDataSource{
    func dbBanner(_ banner: DBBannerStyle, cellForItemAt index: Int, cell: BDBannerBaseCell) -> BDBannerBaseCell {
        let cell: CustItemsViewCell = cell as! CustItemsViewCell
                   cell.layer.cornerRadius = 3
                   cell.layer.masksToBounds = true
        let model =  data[index]
        
        cell.imageView.image = UIImage(named: model.icon)
        cell.articleLabel.text = model.title    
        return cell
    }
    
  
    
    public func dbBanner(_ banner: DBBannerStyle) -> DBBannerCellModel {
        return DBBannerCellModel(type: CustItemsViewCell.self, reuseIdentifier: "DBBannerCell")
    }
    
    public func dbBanner(numberOfItems banner: DBBannerStyle) -> Int {
        return self.data.count
      }
    
    func dbBanner(_ banner: DBBannerStyle, configs: DBBannerConfigs) -> DBBannerConfigs {
        configs.timeInterval = 2
        return configs
    }
    public func dbBanner(_ banner: DBBannerStyle,layoutconfigs: DBBannerLayoutConfigs)->DBBannerLayoutConfigs {
        layoutconfigs.layoutProtocol = DBBannerAnimationLayout()
        return layoutconfigs.itemSize(CGSize(width:self.view.bounds.size.width , height: self.view.bounds.size.width)).itemSpacing(0)
    }
    
    func dbBanner(_ banner: DBBannerStyle, current index: Int) {
        print("----------dddddasdasda-index---\(index)")
        numLabel.text = "\(index)/\(data.count)"
    }
    
}
