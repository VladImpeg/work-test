//
//  extension.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(visualFormat: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down || sender.direction == .up {
            UIView.animate(withDuration: 0.3, animations: {
                if sender.direction == .down {
                    self.center.y += self.frame.size.height
                } else {
                    self.center.y -= self.frame.size.height
                }
                
                
            }, completion: { (done) in
                self.removeFromSuperview()
            })
        }
    }
    
    
       
    
    
}



extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
