//
//  detailVC.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/18/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class detailVC: UIViewController {
    
    // uiview outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    // referencing MeMeStruct to access meme array
    
    var memeItem : MeMeme!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        memeImageView.image = memeItem.memeImage
        
    }
    
    
}
