//
//  rowSelectedTableViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 14/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit

class rowSelectedTableViewController: UITableViewController {
    
    var chooseRow = ["TabTask", "View Design", "Api Call","LogOut"]
   

    
    override func viewDidLoad() {
        super.viewDidLoad()

                // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
   

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chooseRow.count
    }
 
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier:chooseRow[indexPath.row] , sender: self )
    }
  

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        if(indexPath.row == 4){
            cell.layer.backgroundColor = UIColor.red.cgColor
        }
        
//         Configure the cell...
            cell.textLabel?.text = chooseRow[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Get the new view controller using segue.destination.
        if segue.identifier == "ShowTask1"{
            let destination = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! UITabBarController
            navigationController?.present(destination, animated: true, completion: nil)
     
        // Pass the selected object to the new view controller.
    }
    }

    

}
