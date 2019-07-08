//
//  postViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 03/07/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit
import Alamofire

class postViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let parameters = [
            "email": "vaibhavsharma.jecrc@gmail.com",
            "password": "Sameer1@"
        ]

        Alamofire.request("https://angular7-shopping-cart.herokuapp.com/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print(response.result.value!)
        }
//        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
