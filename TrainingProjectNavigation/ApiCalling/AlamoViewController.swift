//
//  AlamoViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 01/07/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class AlamoViewController: UITableViewController {
 
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var tableViewData: UITableView!
    
    var weatherResponse = [WeatherResponse]()
    var dayResults = [String]()
    var tempResults = [Int]()
    var conditionsResults = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.target = self.revealViewController()
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.revealViewController()?.rearViewRevealWidth = 240
        
        
         let url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        

        Alamofire.request(url).responseObject { (response: DataResponse<WeatherResponse>) in

            let weatherResponse = response.result.value
            

            if let responseResult = weatherResponse?.threeDayForecast {
                for forecast in responseResult {
                    print(forecast.day!)
                    print(forecast.temperature!)
                    print("\(forecast.conditions!)\n")
                    self.dayResults.append(forecast.day!)
                    self.tempResults.append(forecast.temperature!)
                    self.conditionsResults.append(forecast.conditions!)
                    
                }
            }
            self.tableViewData.reloadData()
        }
        
//        Alamofire.request(url).responseJSON{response in
//
//            if let result = response.result.value {
//                print(result)
//            }
//        }
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Table Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! WeatherTableViewCell
        cell.dayLabel.text = self.dayResults[indexPath.row]
        cell.tempLabel.text = "\(self.tempResults[indexPath.row])"
        cell.conditionLabel.text = self.conditionsResults[indexPath.row]
        return cell
    }
}
