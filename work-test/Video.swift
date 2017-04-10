//
//  Video.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class Video {
    var countLikes: String?
    var title: String?
    var urlForPlayVideo: String?
    var urlForPicture: String?
    
    init(count: String, title: String, urlForVideo: String, urlForPicture: String ) {
        self.countLikes = count
        self.title = title
        self.urlForPlayVideo = urlForVideo
        self.urlForPicture = urlForPicture
    }
}
