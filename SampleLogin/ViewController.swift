//
//  ViewController.swift
//  SampleLogin
//
//  Created by Appinventiv on 28/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import GoogleSignIn
import Google

class ViewController: UIViewController, GIDSignInUIDelegate{

    let imagePicker = UIImagePickerController()
   
    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image picker controller
        imagePicker.delegate = self
        
        
        pickedImageView.center = CGPoint(x: self.view.frame.width/2, y: 570)
        
        
        imagePickerButton.center = CGPoint(x: self.view.frame.width/2 , y: 470)
        imagePickerButton.backgroundColor = .black
        imagePickerButton.addTarget(self, action: #selector(addImage(_:)), for: .touchUpInside)
        
       
        //FB sign in and access app events
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton)
        
        if FBSDKAccessToken.current() == nil{
            print("Login To Account")
        }else
            {
                print("Already Logged In")
        }
        
        let likeButton = FBSDKLikeControl()
        likeButton.objectID = "https://www.facebook.com/SarcasmDX/"
        likeButton.center = CGPoint(x: self.view.frame.width/2, y: 250)
        self.view.addSubview(likeButton)
      
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://www.facebook.com/SarcasmDX/")
        
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = content
        shareButton.center = CGPoint(x: self.view.frame.width/2, y: 300)
        self.view.addSubview(shareButton)
        
        
        //google sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        let googgleSignInButton = GIDSignInButton()
        googgleSignInButton.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 + 50)
        self.view.addSubview(googgleSignInButton)
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func addImage(_ sender: UIButton){
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            pickedImageView.contentMode = .scaleAspectFill
            pickedImageView.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
    }
}

