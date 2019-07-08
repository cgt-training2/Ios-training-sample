//
//  DashViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 24/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit
import FMDB

class ScrollViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var databasePath = String()
    var contactDB : FMDatabase!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 245, height: 500)
        
        // Database File
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("Database.db").path
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            if (contactDB.open()) {
                let sql_stmt = "create table UserDetail (email text primary key, firstname text not null, lastname text not null, password text not null, confirmpassword text not null, contactNo integer not null)"
                if (contactDB.executeStatements(sql_stmt)) {
                    print("Database Created")
                }else{
                    print("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        }
        print(databasePath)
    }
        
    
        // Do any additional setup after loading the view.
    
        // Try to find next responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email {
            firstName.becomeFirstResponder()
        }else if textField == firstName {
            lastName.becomeFirstResponder()
        }else if textField == lastName {
            password.becomeFirstResponder()
        }else if textField == password {
            confirmPassword.becomeFirstResponder()
        }else if textField == confirmPassword {
            contact.becomeFirstResponder()
        }else{
            contact.resignFirstResponder()
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARKS: Action
    
    @IBAction func registerButton(_ sender: UIButton) {
        //getting vaules from textFields
        let r_email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let r_fstName = firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let r_lstName = lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let r_password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let r_cnfPassword = confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let r_contact = contact.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //validating that values are not empty
        
        if(r_email?.isEmpty)!{
            email.layer.borderColor = UIColor.red.cgColor
            email.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "Email", message:
                "Email field is empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
           return
        }else {
            email.layer.borderColor = UIColor.green.cgColor
            email.layer.borderWidth = 1.0
        }
        if (r_fstName?.isEmpty)!{
              firstName.layer.borderColor = UIColor.red.cgColor
            firstName.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "First Name", message:
                "Ente the firstname", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }else {
            firstName.layer.borderColor = UIColor.green.cgColor
            firstName.layer.borderWidth = 1.0
        }
        
        if(r_lstName?.isEmpty)!{
            lastName.layer.borderColor = UIColor.red.cgColor
            lastName.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "Last Name", message:
                "Ente the lastname", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else {
            lastName.layer.borderColor = UIColor.green.cgColor
            lastName.layer.borderWidth = 1.0
            
        }
        if(r_password?.isEmpty)!{
            password.layer.borderColor = UIColor.red.cgColor
              password.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "Password", message:
                "Password Field cannot be empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else {
            password.layer.borderColor = UIColor.green.cgColor
            password.layer.borderWidth = 1.0
        }
        
        if(r_cnfPassword?.isEmpty)!{
            confirmPassword.layer.borderColor = UIColor.red.cgColor
            confirmPassword.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "Confrim Password", message:
                "Confirm Password Field cannot be empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
           
        } else {
            confirmPassword.layer.borderColor = UIColor.green.cgColor
            confirmPassword.layer.borderWidth = 1.0
        }
        
        if(r_contact?.isEmpty)!{
            contact.layer.borderColor = UIColor.red.cgColor
            contact.layer.borderWidth = 1.0
            let alertController = UIAlertController(title: "Contact", message:
                "Enter the Mobile No.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        } else{
            confirmPassword.layer.borderColor = UIColor.green.cgColor
            confirmPassword.layer.borderWidth = 1.0
        }
        
        if (isPasswordValid(password: r_password!)) == false{
            let alertController = UIAlertController(title: "Error", message:
                "Invalid Password \n Password must of min 8 characters and one letter is Capital follwed by one numerical value and a special character", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            password.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(r_password != r_cnfPassword){
            let alertController = UIAlertController(title: "Error", message:
                "Enter same Password and Confirm Password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if (isValidEmail(userEmail: r_email!)) == false {
            let alertController = UIAlertController(title: "Error", message:
                "Enter the valid email address", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            email.layer.borderColor = UIColor.red.cgColor
            return
        }
        if(isContactNoValid(contact: r_contact!)) == false{
            let alertController = UIAlertController(title: "Error", message:
                "Enter the valid mobile no.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
            return
            
        }
       // the insert query
        
        let contactDB = FMDatabase(path: databasePath as String)
        if (contactDB.open()) {
            let queryString = "INSERT INTO UserDetail (email, firstname, lastname, password, confirmpassword, contactNo) VALUES ('\(String(describing: email.text!))','\(String(describing: firstName.text!))', '\(String(describing: lastName.text!))', '\(String(describing: password.text!))', '\(String(describing: confirmPassword.text!))','\(String(describing: contact.text!))' );"

            if contactDB.executeStatements(queryString) {
                print("Data Inserted")

            }else{
                print("Failed to insert initial data into the database.")
            }

            contactDB.close()
        }else {
            print(contactDB.lastError(), contactDB.lastErrorMessage())
        }
        
        //emptying the textFields
        email.text = ""
        firstName.text = ""
        lastName.text = ""
        password.text = ""
        contact.text = ""
        confirmPassword.text = ""
        print("Data Sucessfully inserted")
        let alert = UIAlertController(title: "", message:
            "Data Successfully Inserted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alert, animated: true, completion: nil)
        
        confirmPassword.layer.borderColor = UIColor.black.cgColor
        email.layer.borderColor = UIColor.black.cgColor
        password.layer.borderColor = UIColor.black.cgColor
        firstName.layer.borderColor = UIColor.black.cgColor
        lastName.layer.borderColor = UIColor.black.cgColor
        contact.layer.borderColor = UIColor.black.cgColor
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
    func isContactNoValid(contact : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "[0-9]{10}")
        return passwordTest.evaluate(with: contact)
    }
}

