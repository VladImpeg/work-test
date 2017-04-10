//
//  VideoCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit


class VideoCell: BaseCell {
    
    var downloadTask: URLSessionDownloadTask?
    
    
    var video: Video? {
        didSet {
            
            if let titleLabelText = video?.title {
                titleLabel.text = titleLabelText
            }
            
            
            if let thumbnailImageUrl = video?.thumbnailImageName {
                if !thumbnailImageUrl.isEmpty {
                    thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageUrl)
                    //                settingImage(imageView: thumbnailImageView, imageURL: thumbnailImageUrl)
                }
                
            }
            
            if let avatar_url = video?.user.avatar_url {
                if !avatar_url.isEmpty {
                    userProfileImageView.loadImageUsingURLString(urlString: avatar_url)
                    //                settingImage(imageView: userProfileImageView, imageURL: avatar_url)
                    
                }
            }
            
            
            //            if let username = video?.user.username {
            //             //userProfileImageView.loadImageUsingURLString(urlString: username)
            //            }
            
            if let numberOfViews = video?.numberOfLikes {
                
                
                
                let numberOfLikes = "\(numberOfViews) likes"
                numberOfLikesLabel.text = numberOfLikes
            }
            
        }
    }
    
    //    func settingImage(imageView: UIImageView, imageURL: String) {
    //        if let url = URL(string: imageURL) {
    //            downloadTask = imageView.loadImageWithURL(url: url, callback: { (image) in
    //
    //            })
    //        }
    //    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "thumbnail")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The cutest video on this site"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "0 likes"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var titleLabelHeightConstraint: NSLayoutConstraint?
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(numberOfLikesLabel)
        
        addConstraintsWithFormat(visualFormat: "H:|-1-[v0]|", views: thumbnailImageView)
        
        addConstraintsWithFormat(visualFormat: "H:|-8-[v0(44)]", views: userProfileImageView)
        
        addConstraintsWithFormat(visualFormat: "H:|-40-[v0]-40-|", views: titleLabel)
        
        addConstraintsWithFormat(visualFormat: "H:[v0(62)]-8-|", views: numberOfLikesLabel)
        
        
        //vertical constraints
        addConstraintsWithFormat(visualFormat: "V:|[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat(visualFormat: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 50)
        addConstraint(titleLabelHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 50))
        
    }
    
    
}




