//
//  FeedCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class FeedCell: DataCell {
    
    override func fetchVideos() {
        
        getJSON(stringUrl: "\(baseURL)videos/following", authentification: true)
        
    }
    
}
