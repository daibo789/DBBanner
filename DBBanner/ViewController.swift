//
//  ViewController.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        var data:[DefultModel] = [
             DefultModel(icon:"timg",title:"默认",iconUrl:""),
             DefultModel(icon:"timg",title:"动画",iconUrl:""),
             DefultModel(icon:"timg",title:"动画网络",iconUrl:""),
             DefultModel(icon:"timg",title:"自定义",iconUrl:""),
            DefultModel(icon:"timg",title:"自定义custItem",iconUrl:""),
            DefultModel(icon:"timg",title:"自定义pageControl",iconUrl:"")
            
         ]
         
        lazy var tableView :UITableView = {
            let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 50
            tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            return tableView
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "bbc"
            tableView.frame = self.view.bounds
            self.view.addSubview(self.tableView)
            
        }


}



extension ViewController: UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
       }
       
       func numberOfSections(in tableView: UITableView) -> Int {
          return data.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
           let model = self.data[indexPath.section]
           cell.textLabel?.text = model.title

           return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        let model = self.data[indexPath.section]
        if model.title == "默认" {
            self.navigationController?.pushViewController(DefultViewController(), animated: true)
        }else if  model.title == "动画"  {
            self.navigationController?.pushViewController(AnnimalViewController(), animated: true)
        }else if  model.title == "动画网络"  {
            self.navigationController?.pushViewController(AnnimalNetViewController(), animated: true)
        }else if  model.title == "自定义"  {
            self.navigationController?.pushViewController(CustAnnimalViewController(), animated: true)
        }else if  model.title == "自定义custItem"  {
            self.navigationController?.pushViewController(CustItemsViewController(), animated: true)
        }else if  model.title == "自定义pageControl"  {
            self.navigationController?.pushViewController(CustViewPageControlController(), animated: true)
        }
        
           
       }
       
       
}
