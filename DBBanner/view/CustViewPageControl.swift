//
//  CustViewPageControl.swift
//  DBBanner
//
//  Created by botu on 2019/10/15.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class CustViewPageControl: BDBannerBaseCell {
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(infoView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoView.frame = self.bounds
    }
    
    public lazy var infoView: CustViewPageControlView = {
        let infoView = CustViewPageControlView.loadFromNib()
       return infoView
    }()
}


class CustViewPageControlView: UIView, NibLoadable {
    @IBOutlet weak var icon: UIImageView!
    
}




