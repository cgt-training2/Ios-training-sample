//
//  RegisterViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 05/07/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    var login = LoginViewController()
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var confirmPasswordtextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let urlString = "http://192.168.100.137:3000/api/register1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize =  CGSize(width: 245, height: 300)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
        
        circularImage(image : profileImage)
    }
    func circularImage(image : UIImageView){
        image.layer.borderWidth = 2
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        image.clipsToBounds = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
           userNameTextField.becomeFirstResponder()
        }else if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            confirmPasswordtextField.becomeFirstResponder()
        }
        else{
            confirmPasswordtextField.resignFirstResponder()
        }
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        profileImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoGallery(_ sender: UITapGestureRecognizer) {
       
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    // MARKS : Post Method for registration
    
    func performRegistrationRequest(){
        
        let image = profileImage.image
        let imageData = image!.pngData()
        
        
        let parameters = [
            "email" : emailTextField.text!.lowercased(),
            "username" : userNameTextField.text!,
            "password" : passwordTextField.text!
            ] as [String : Any]
        
//         let headers = [
//            "token" : "x-token"
//        ]
    
      
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(imageData!, withName: "profile",fileName:"image.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in parameters{
                    multipartFormData.append((String(describing: value).data(using: .utf8))!, withName: key)
                }
                
            }, usingThreshold:UInt64.init(),
               to:urlString, method: .post, headers: nil , encodingCompletion: { result in
                        print(result)
                switch result {
                case .success(let upload, _, _):
                print("the status code is :")
                upload.uploadProgress(closure: { (progress) in
                    print("Something")
                })
                upload.responseJSON{ response in
                    print("the reponse code is \(String(describing: response.response?.statusCode))")
                     print("the response is : \(response)")
                    }
                    break
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    break

                }
                
            })
}
    // MARK : Register Button Action
    
    @IBAction func registerButton(_ sender: Any) {
        
         activityIndicatior.startAnimating()
        if ((emailTextField.text?.isEmpty)!) {
            showAlert(message: "Email cannot be Empty")
            return
        }
        
        if ((userNameTextField.text?.isEmpty)!) {
            showAlert(message: "Username field is Empty")
            return
        }
        
        if ((passwordTextField.text?.isEmpty)!) {
            showAlert(message: "Password field is Empty")
            return
        }
        
        if ((confirmPasswordtextField.text?.isEmpty)!) {
            showAlert(message: "Confirm Password field is Empty")
            return
        }
        
        if(passwordTextField.text != confirmPasswordtextField.text){
            showAlert(message: "Password and Confirm Password must be same")
            return
        }
        
        if (login.isValidEmail(userEmail: emailTextField.text!)) == false {
            showAlert(message: "Enter the valid email address")
            return
        }
        
        if (login.isPasswordValid(password: passwordTextField.text!)) == false{
            showAlert(message: "Invalid Password \n Password must of min 8 characters and one letter is Capital follwed by one numerical value and a special character")
            return
        }
        // register request
        performRegistrationRequest()
    }
    
    func showAlert(message : String){
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        self.activityIndicatior.stopAnimating()
    }
}
