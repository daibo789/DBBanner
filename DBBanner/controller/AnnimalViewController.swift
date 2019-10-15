

import UIKit

class AnnimalViewController: UIViewController {
     
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动画"
        banner.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.width-100 )
        self.view.addSubview(banner)
        self.view.backgroundColor = UIColor.white
    }


}



extension AnnimalViewController: DBBannerDelegate,DBBannerDataSource{
    func dbBanner(_ banner: DBBannerStyle, cellForItemAt index: Int, cell: BDBannerBaseCell) -> BDBannerBaseCell {
        let cell: CustomAnimationCell1 = cell as! CustomAnimationCell1
                   cell.layer.cornerRadius = 3
                   cell.layer.masksToBounds = true
        let model =  data[index]
        
        cell.imageView.image = UIImage(named: model.icon)
        cell.articleLabel.text = model.title
                   cell.numLabel.text = "\(index)"
                   return cell
    }
    
  
    
    public func dbBanner(_ banner: DBBannerStyle) -> DBBannerCellModel {
        return DBBannerCellModel(type: CustomAnimationCell1.self, reuseIdentifier: "DBBannerCell")
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
        return layoutconfigs.itemSize(CGSize(width:(self.view.bounds.size.width-100)/2 , height: self.view.bounds.size.width-150 )).itemSpacing(20)
    }
    
    func dbBanner(_ banner: DBBannerStyle, current index: Int) {
        print("----------dddddasdasda-index---\(index)")
    }
    
}
