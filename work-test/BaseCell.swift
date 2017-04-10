//
//  BaseCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/10/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
