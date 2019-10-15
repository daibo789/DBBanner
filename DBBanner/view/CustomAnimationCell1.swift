//
//  DBBannerCell.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

class CustomAnimationCell1: BDBannerBaseCell {
    
    open var articleBGViewH : CGFloat = 24
    open var articleMargin : CGFloat = 10
    
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(numLabel)
        contentView.addSubview(articleBgView)
        articleBgView.addSubview(articleLabel)
    }
    
    
    public lazy var numLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16,
                             y: 0,
                             width: 80,
                             height: 35)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return label
    }()
    
    public lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: articleMargin,
                             y: 0,
                             width: articleBgView.bounds.width - 2*articleMargin,
                             height: articleBgView.bounds.height)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return label
    }()
    
    public lazy var articleBgView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0,
                            y: self.contentView.bounds.height - articleBGViewH,
                            width: self.contentView.bounds.width,
                            height: articleBGViewH)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.autoresizingMask = [
            .flexibleWidth,
            .flexibleTopMargin
        ]
        return view
    }()
}
