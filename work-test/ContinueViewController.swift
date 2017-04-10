//
//  ContinueViewController.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/7/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import CoreData

class ContinueViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    //Properties
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var gender = "male"
    var birthDay = ""
    var profilePhoto: NSData?
    var displayError = ""
    
    
    //OUTLETS
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var bdayTextField: UITextField!
    @IBOutlet weak var bdayLabel: UILabel!
    @IBOutlet weak var chooseProPicButton: UIButton!
    @IBOutlet weak var ProPicImageView: UIImageView!
    
    //Picks the select image and set it to imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            ProPicImageView.image = pickedImage
            ProPicImageView.layer.borderWidth = 1.5
            ProPicImageView.layer.masksToBounds = false
            ProPicImageView.layer.borderColor = UIColor.black.cgColor
            ProPicImageView.layer.cornerRadius = ProPicImageView.frame.height/2.5
            //ProPicImageView.layer.cornerRadius = ProPicImageView.frame.width/2.5
            ProPicImageView.clipsToBounds = true
            profilePhoto = UIImageJPEGRepresentation(pickedImage, 1) as NSData?
        }
        
    }
    
    //Save Data to coredata
    func saveData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "SignUp", into: context) as! SignUp
            newUser.firstName = firstName
            newUser.lastName = lastName
            newUser.email = email
            newUser.password = password
            newUser.gender = gender
            newUser.birthday = birthDay
            newUser.profilePicture = profilePhoto
            
            delegate?.saveContext()
        }
    }
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // bdayTextField.delegate = self.bdayTextField as! UITextFieldDelegate?
        bdayTextField.delegate = self
        bdayTextField.keyboardType = UIKeyboardType.phonePad
        femaleButton.isHighlighted = true
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        
        gender = "male"
        maleButton.isHighlighted = false
        femaleButton.isHighlighted = true
        
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        
        gender = "female"
        maleButton.isHighlighted = true
        femaleButton.isHighlighted = false
        
    }
    
    
    @IBAction func signupUser(_ sender: UIButton) {
        
        if bdayTextField.text == ""{
            displayError = "Please tell me what is your birthday"
            displayAlert(title: "Incomlete Form", displayError: displayError)
        }
        
        if(bdayTextField.text != "" && ProPicImageView.image != nil){
            saveData()
            print("Data Saved!!")
            performSegue(withIdentifier: "toMainVCFromSignUp", sender: self)
        }
    }
    
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if bdayTextField.text!.characters.count == 2{
            bdayTextField.text =  bdayTextField.text! + "/"
        }
        if bdayTextField.text!.characters.count == 5{
            bdayTextField.text = bdayTextField.text! + "/"
        }
    }
    
    
    
    @IBAction func chooseProfilePicture(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainVCFromSignUp"{
            let mainVC = segue.destination as! MainViewController
            mainVC.firstName = firstName
            mainVC.lastName = lastName
            mainVC.email = email
            mainVC.password = password
            mainVC.gender = gender
            mainVC.birthDay = birthDay
            mainVC.profilePhoto = UIImage(data: profilePhoto as! Data)
        }
    }
    
}
