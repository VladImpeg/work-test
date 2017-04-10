//
//  MenuCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/9/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 210, green: 20, blue: 50, alpha: 0.9)
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured"
        //label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    override var isHighlighted: Bool  {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 90, green: 40, blue: 230, alpha: 1)
            titleLabel.textColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 90, green: 40, blue: 230, alpha: 1)
        }
    }
    
    override var isSelected: Bool  {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 90, green: 40, blue: 230, alpha: 1)
            titleLabel.textColor = isSelected ? UIColor.white : UIColor.rgb(red: 90, green: 40, blue: 230, alpha: 1)
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(visualFormat: "H:[v0(20)]", views: imageView)
        addConstraintsWithFormat(visualFormat: "H:[v0(80)]", views: titleLabel)
        
        
        addConstraintsWithFormat(visualFormat: "V:[v0(20)]", views: imageView)
        addConstraintsWithFormat(visualFormat: "V:|-30-[v0(17)]", views: titleLabel)
        
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
