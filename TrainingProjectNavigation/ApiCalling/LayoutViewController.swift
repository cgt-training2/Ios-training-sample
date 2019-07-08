//
//  LayoutViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 17/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit

class LayoutViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       flagg()
        
    }
    func flagg()
    {
        topView.backgroundColor = UIColor.blue
        
        middleView.removeFromSuperview()
    
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
