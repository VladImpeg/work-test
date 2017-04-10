//
//  SettingsCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class Setting {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case privacy = "Privacy Policy"
    case settings = "Settings"
    case feedback = "Feedback"
    
    
}

class SettingsCell: VideoCell {
    
    var setting: Setting? {
        didSet {
            if let name = setting?.name {
                
                settingsLabel.text = name.rawValue
            }
            
            if let iconName = setting?.imageName {
                settingsIcon.image = UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal)
                settingsIcon.tintColor = UIColor.darkGray
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
            settingsLabel.textColor = isHighlighted ? UIColor.white : UIColor.blue
            settingsIcon.tintColor = isHighlighted ? UIColor.white : UIColor.green
        }
    }
    
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let settingsIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(settingsIcon)
        addSubview(settingsLabel)
        
        addConstraintsWithFormat(visualFormat: "H:|-16-[v0(20)]-16-[v1]|", views: settingsIcon, settingsLabel)
        addConstraintsWithFormat(visualFormat: "V:|[v10]|", views: settingsLabel)
        addConstraintsWithFormat(visualFormat: "V:[v0(30)]", views: settingsIcon)
        addConstraint(NSLayoutConstraint(item: settingsIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
    
}


