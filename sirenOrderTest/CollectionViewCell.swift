//
//  CollectionViewCell.swift
//  sirenOrderTest
//
//  Created by Dustin on 2020/08/26.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let boxView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .black
        uv.setDimensions(width: 100, height: 100)
        return uv
    }()
    
    let label : UILabel = {
        let lb = UILabel()
        lb.text = "샷 추가"
        lb.textColor = .red
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(boxView)
        boxView.anchor(top:topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor)
        addSubview(label)
        label.center(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
