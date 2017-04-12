//
//  MainViewController.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/7/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    //PROPERTIES
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var gender = ""
    var birthDay = ""
    var profilePhoto:UIImage?
    var profilePhotos:NSData?
    
    //OUTLETS
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var logoutButtonoutlet: UIButton!
    @IBOutlet weak var changeButtonOutlet: UIButton!
    
    func customizeView(){
        profilePictureImageView.layer.borderWidth = 1
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.black.cgColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.clipsToBounds = true
        
        changeButtonOutlet.layer.masksToBounds = false;
        changeButtonOutlet.layer.cornerRadius = changeButtonOutlet.frame.height/2;
    }
    
    //Picks the select image and set it to imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profilePictureImageView.image = pickedImage
            profilePictureImageView.layer.borderWidth = 1
            profilePictureImageView.layer.masksToBounds = false
            profilePictureImageView.layer.borderColor = UIColor.black.cgColor
            profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
            profilePictureImageView.clipsToBounds = true
            profilePhotos = UIImageJPEGRepresentation(pickedImage, 1) as NSData?
            fetchData()
        }
        
    }
    
    func fetchData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let fetchRequest:NSFetchRequest<SignUp> = SignUp.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email = %@", email)
            do{
                
                let users = try(context.fetch(fetchRequest))
                print(users.count)
                
                if users.count > 0{
                    users[0].profilePicture = profilePhotos
                }
            }catch let err{
                print(err)
            }
            delegate?.saveContext()
        }
    }
    
    func loadData(){
        usernameLabel.text = "\(firstName)"
        print(usernameLabel.text!)
        profilePictureImageView.image = profilePhoto
        profilePictureImageView.contentMode = .scaleAspectFill
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        customizeView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLoginVC", sender: self)
    }
    
    
    @IBAction func changePhoto(_ sender: UIButton) {
        print("Change Photo Button is Pressed");
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
        
    }
}

