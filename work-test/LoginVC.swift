//
//  LoginVC.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/7/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import CoreData


class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var username = ""
    var passwordVariable = ""
    var profilePhoto: UIImage? = nil
    var loginSuccess = false
    
    //MARK:- Outlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signupButtonOutlet: UIButton!

    
    //MARK:- user Functions
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let fetchRequeset: NSFetchRequest<SignUp> = SignUp.fetchRequest()
            
            do{
                let users = try(context.fetch(fetchRequeset))
                
                for user in users{
                    context.delete(user)
                }
            }catch let err{
                print(err)
            }
        }
    }
    
    
    
    func logInMethod(){
        var displayError = ""
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            let fetchRequest:NSFetchRequest<SignUp> = SignUp.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email = %@", email.text!)
            do{
                
                let users = try(context.fetch(fetchRequest))
                print(users.count)
                
                if users.count > 0{
                    for user in users{
                        if(email.text == user.email && password.text == user.password){
                            print("Login Sucessfully")
                            username = user.firstName!
                            passwordVariable = user.password!
                            profilePhoto = UIImage(data: user.profilePicture as! Data)
                            self.performSegue(withIdentifier: "toMainVCFromLogin", sender: self)
                        }else{
                            displayError = "You have entered Wrong Details Inside User"
                            displayAlert(title: "Wrong Creditials", displayError: displayError)
                            email.text = ""
                            password.text = ""
                        }
                    }
                }else{
                    email.text = ""
                    password.text = ""
                    
                    displayError = "You have entered Wrong Details OutSide"
                    displayAlert(title: "Wrong Creditials", displayError: displayError)
                }
            }
            catch let err{
                email.text = ""
                password.text = ""
                displayAlert(title: "Error", displayError: err as! String)
            }
        }
    }
    
    //MARK:- View Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //clearData()
        email.delegate = self
        password.delegate = self
        
    
        
        
    }
       
    
    
    
    //MARKL:- UITextfield Method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Action method
    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        var displayError = ""
        if(email.text == ""){
            displayError = "Please Enter Valid Email"
        }else if(password.text == ""){
            displayError = "Please Enter Password"
        }
        
        if displayError != ""{
            displayAlert(title: "Incomplete Form", displayError: displayError)
        }
        
        if(email.text != "" && password.text != ""){
            logInMethod()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainVCFromLogin"{
            let mainVC = segue.destination as! MainViewController
            mainVC.email = email.text!
            mainVC.password = password.text!
            mainVC.firstName = username
            mainVC.profilePhoto = profilePhoto
        }
    }
}
