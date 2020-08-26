//
//  TableViewCell.swift
//  sirenOrderTest
//
//  Created by Dustin on 2020/08/26.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        layout.itemSize = CGSize(width: 100, height: 100)
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        collectionView.anchor(top:topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
