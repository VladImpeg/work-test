//
//  SingInVC.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/7/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import CoreData


class SignupViewController: UIViewController,UITextFieldDelegate {
    
    
    var displayError = ""
    
    //MARK:- Outlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //Alert View
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupDelegate(){
        // firstName.delegate = self.firstName as? UITextFieldDelegate
        //        lastName.delegate = self.lastName as! UITextFieldDelegate?
        //       email.delegate = self.email as! UITextFieldDelegate?
        //    password.delegate = self.password as! UITextFieldDelegate?
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        
        // Do any additional setup after loading the view.
    }
    
    func saveData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let user = NSEntityDescription.insertNewObject(forEntityName: "SignUp", into: context) as! SignUp
            user.firstName = firstName.text
            user.lastName = lastName.text
            user.email = email.text
            user.password = password.text
            
            delegate?.saveContext()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Actions
    
    @IBAction func continueButton(_ sender: UIButton) {
        if(firstName.text == "" ){
            displayError = "Please enter first Name"
        }else if  password.text == ""{
            displayError = "Please enter password"
        }else if lastName.text == ""{
            displayError = "Please enter Last Name"
        }else if email.text == ""{
            displayError = "Please enter Email"
        }
        
        if displayError != ""{
            displayAlert(title: "Incomplete Form", displayError: displayError)
        }
        else{
            self.performSegue(withIdentifier: "continueSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "continueSegue"{
            let addUserInfoVC = segue.destination as! ContinueViewController
            addUserInfoVC.firstName = self.firstName.text!
            addUserInfoVC.lastName = self.lastName.text!
            addUserInfoVC.email = self.email.text!
            addUserInfoVC.password = self.password.text!
        }
    }
    
    
    
    
}
