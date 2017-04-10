//
//  Auth.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit


var loginUser = "VladImpeg"
var passUser = "qwerty"

var token = ""

var isLogIn: Bool = false

var session: URLSession?

//protocol LoginDelegate {
//    func showLogInView(view: UIView)
//}
//
//extension UIView: LoginDelegate {
//    func showLogInView(view: UIView) {
//        LogInView().showLogInView(view: view)
//    }
//}

class LogInFormLauncher: NSObject {
    
    let user = User()
    
    let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        //view.layer.zPosition = CGFloat.greatestFiniteMagnitude
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let loginText: UITextField = {
        let login = UITextField()
        //login.backgroundColor = UIColor.blue
        login.contentMode = .center
        login.placeholder = "your login"
        return login
    }()
    
    let passwordText: UITextField = {
        let password = UITextField()
        //password.backgroundColor = UIColor.red
        password.contentMode = .center
        password.placeholder = "your password"
        return password
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 245, green: 47, blue: 87, alpha: 1)
        button.titleLabel?.textColor = UIColor.white
        button.setTitle("Log In", for: UIControlState.normal)
        button.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        return button
    }()
    
   
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 25, green: 80, blue: 220, alpha: 1)
        button.titleLabel?.textColor = UIColor.white
        button.setTitle("Cancel", for: UIControlState.normal)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    func showLogInView() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView()
            view.backgroundColor = UIColor.white
           
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let button = UIButton(frame: CGRect(x: 100, y: 50, width: 44, height: 44))
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(handleLogInButton), for: .touchUpOutside)
            view.addSubview(button)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
                
                view.addSubview(self.loginText)
                view.addSubview(self.passwordText)
                view.addSubview(self.loginButton)
                view.addSubview(self.cancelButton)
                
            }, completion: { (comleted) in
                UIApplication.shared.isStatusBarHidden = true
            })
            
            
            keyWindow.addSubview(view)
            view.addConstraintsWithFormat(visualFormat: "H:|-30-[v0]-30-|", views: loginText)
            //loginView.addConstraintsWithFormat(visualFormat: "V:|-100-[v0(30)]|", views: loginText)
            
            view.addConstraintsWithFormat(visualFormat: "V:|-100-[v0(30)]-60-[v1(30)]-60-[v2(30)]", views: loginText, passwordText, loginButton)
            
            view.addConstraintsWithFormat(visualFormat: "V:|-150-[v0(30)]", views: cancelButton)
            
            view.addConstraintsWithFormat(visualFormat: "H:|-30-[v0]-30-|", views: passwordText)
            //loginView.addConstraintsWithFormat(visualFormat: "V:|-140-[v0(30)]|", views: passwordText)
            
            view.addConstraintsWithFormat(visualFormat: "H:|-30-[v0(150)][v1(150)]-30-|", views: cancelButton, loginButton)
            //loginView.addConstraintsWithFormat(visualFormat: "V:|-180-[v0(30)]|", views: loginButton)
        }
        
    }
  
    func handleLogInButton() {
        let alert = UIAlertController(title: "Youre logged in", message: "conglagulations!", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAlert = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
        })
        alert.addAction(cancelAlert)
    }
    
    func handleCancelButton() {
        print("cancel")
        //_ = UINavigationController?.popToRootViewControllerAnimated(true)
    }
    
    func checkUser() {
        if !(passwordText.text?.isEmpty)! && !(loginText.text?.isEmpty)! {
            
        } else {
            
        }
        
    }
    
}


