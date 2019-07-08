//
//  LoginViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 26/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit
import FMDB
let appDel = UIApplication.shared.delegate as! AppDelegate
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var email : String?
    var password : String?
    
    @IBOutlet weak var textFieldEmail: UITextField!
    var databasePath = String()
    var contactDB : FMDatabase!
     var userlist = [UserDetails]()
     let url = "https://angular7-shopping-cart.herokuapp.com/api/login"
    
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("Bhavesh.rathi@yahoo.com", forKey: "email")
        UserDefaults.standard.set("Bhave@123",forKey: "password" )

         self.email = UserDefaults.standard.string(forKey: "email")
        self.password = UserDefaults.standard.string(forKey: "password")
         print(email!)
        print(password!)
    
       
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
//        let filemgr = FileManager.default
//        let dirPaths = filemgr.urls(for: .documentDirectory,
//                                    in: .userDomainMask)
//        
//        databasePath = dirPaths[0].appendingPathComponent("Database.db").path
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        }else{
            textFieldPassword.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterView") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        activityIndicator.startAnimating()
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let redViewController = storyBoard.instantiateViewController(withIdentifier: "SideView") as! SWRevealViewController
//        (appDel.window?.rootViewController as! UINavigationController).setViewControllers([redViewController], animated: false)
        
        
        if ((textFieldEmail.text?.isEmpty)!) {
            showAlert(message: "Email cannot be Empty")
            return
        }
        
        if ((textFieldPassword.text?.isEmpty)!) {
            showAlert(message: "Password field is Empty")
             return
        }
        
        if (isValidEmail(userEmail: textFieldEmail.text!)) == false {
           showAlert(message: "Enter the valid email address")
            return
        }

        if (isPasswordValid(password: textFieldPassword.text!)) == false{
            showAlert(message: "Invalid Password \n Password must of min 8 characters and one letter is Capital follwed by one numerical value and a special character")
            return
        }
//
//        let contactDB = FMDatabase(path: databasePath as String)
//        if (contactDB.open()) {
//            let selectQuery = "SELECT email, password FROM UserDetail;"
//
//            do{
//                let results: FMResultSet? = contactDB.executeQuery(selectQuery, withArgumentsIn: [])
//
//            while results!.next() {
//                let getEmail = results?.string(forColumn: "email")!
//                let getPassword = results?.string(forColumn: "password")!
//                print(getEmail!)
//                print(getPassword!)
//
//                if ((getEmail == textFieldEmail.text!) && (getPassword == textFieldPassword.text!)){
//                        print("login sucessful")
//                        let alertController = UIAlertController(title: "Login", message: "Login Sucessfull", preferredStyle: .alert)
//                        alertController.addAction(UIAlertAction(title: "Done", style: .default))
//                        self.present(alertController, animated: true, completion: nil)
//                                textFieldEmail.text = ""
////                                textFieldPassword.text = ""

//                    return
//                        }else{
//        let alert = UIAlertController(title: "Error", message: "Either email or password does't match", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
//        self.present(alert, animated: true, completion: nil)
//
//                    }
//                }
//            }
//        }
      
        performRequest()
    }
    
    
    func isValidEmail(userEmail : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: userEmail)
    }
    
    func isPasswordValid(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func performRequest() {
        let parameters = [
            "email": "\(textFieldEmail.text!.lowercased())",
            "password" : "\(textFieldPassword.text!)"
        ]
        print(parameters)
       
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            print(response.result.value!)
        
        self.activityIndicator.stopAnimating()
        if let resultJSON = response.result.value{
    
            let jsonObj: Dictionary = resultJSON as! Dictionary<String, Any>
            let success: Int = jsonObj["success"] as! Int
            let message:String = jsonObj["message"] as! String

            if (success == 1) {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let redViewController = storyBoard.instantiateViewController(withIdentifier: "SideView") as! SWRevealViewController
                            (appDel.window?.rootViewController as! UINavigationController).setViewControllers([redViewController], animated: false)
                return
                
        } else if (message == "Authentication failed. Wrong password.") {
                self.showAlert(message: "Incorrect Password")
                return
                
            } else if (message == "Authentication failed. User not found.") {
                self.showAlert(message: "Email does not exist")
                return
                }
            }
        }
        
    }
    func showAlert(message : String){
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        self.activityIndicator.stopAnimating()
    }
}
        

