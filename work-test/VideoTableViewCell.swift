//
//  VideoTableViewCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/10/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import SDWebImage

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageForPreview: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var labelForName: UILabel!
    @IBOutlet weak var labelForCountLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCell(video: Video) {
        labelForName.text = video.title
        labelForCountLikes.text = "\(video.countLikes!) likes"
        imageForPreview.sd_setImage(with: URL(string: video.urlForPicture!))
    }

}
