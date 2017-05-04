//
//  BaseCell.swift
//  OnFleek
//
//  Created by Kev1 on 5/4/17.
//  Copyright © 2017 Kev1. All rights reserved.
//

import UIKit

//Stop redundancy create a superclass
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
