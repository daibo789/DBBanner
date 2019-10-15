//
//  BDBannerBaseCell.swift
//  DBBanner
//
//  Created by botu on 2019/9/27.
//  Copyright © 2019 dbb. All rights reserved.
//

import UIKit

public class BDBannerBaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK:--加载控件
    open func setupUI(){
        contentView.addSubview(imageView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
    //MARK:--------------------lazy-----------------------------
    public lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        imageView.autoresizingMask = [
            .flexibleHeight,
            .flexibleWidth
        ]
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
}
