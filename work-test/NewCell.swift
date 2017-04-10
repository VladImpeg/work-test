//
//  NewCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit

class NewCell: DataCell {
    
    override func fetchVideos() {
        
        getJSON(stringUrl: "\(baseURL)videos/new")
    }
    
    
}
