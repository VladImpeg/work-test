//
//  NewsTableViewCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/9/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var new: News! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI()
    {
        nameLabel.text = new.title
        //NewimageView.image = new.photoURL
        if let thubnailURL = new.photoURL {
            let netwirkService = NetworkService(url: thubnailURL)
            netwirkService.downloadImage({ (imageData) in
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async {
                    self.NewimageView.image = image
                }
            })
        }
        
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var NewimageView: UIImageView!
    
}
