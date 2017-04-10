//
//  Settings.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import SystemConfiguration

class Settings: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 50

    
   
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
  
    
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
                       window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
         
            
            blackView.alpha = 0
            
            let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
            btn.backgroundColor = UIColor.green
            btn.setTitle("Click Me", for: .normal)
            btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            btn.tag = 1
           
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
              
                
                
            }, completion: nil)
            
        }
        
        
    }
    
    func buttonAction(sender: UIButton!) {
        let alert = UIAlertController(title: "Youre logged in", message: "conglagulations!", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAlert = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
        })
        alert.addAction(cancelAlert)
        var btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            //do anything here
        }
    }
    
    func dissmisSettingsMenu(_ sender: UITapGestureRecognizer) {
        dismissMenu()
    }
    

    
    func handleDownSwipe(sender: UISwipeGestureRecognizer) {
        dismissMenu()
    }
    
    func dismissMenu() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    //Mark: Collection View
    

    
   
    }
    



public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

