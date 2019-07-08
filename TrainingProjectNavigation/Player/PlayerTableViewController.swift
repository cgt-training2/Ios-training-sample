//
//  PlayerTableViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 13/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //MARK: - Properties
    var players = SampleData.generatePlayersData()

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.revealViewController()?.rearViewRevealWidth = 240
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        
       // Configure the cell...
        let player = players[indexPath.row]
       cell.player = player
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelToPlayerTableViewController(_segue: UIStoryboardSegue){
        
    }
    @IBAction func savePlayerDetail(_segue: UIStoryboardSegue ){
        guard let playerDetailsViewController = _segue.source as? PlayerDetailTableViewController, let player = playerDetailsViewController.player else{
            return
        }
   
        // add the new player to the players array
        players.append(player)
        
        //Update the TabelView
        let indexPath = IndexPath(row: players.count - 1,section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    @IBAction func backtoTask(_segue: UIStoryboardSegue){
        if _segue.identifier == "backToHome"{
            let destination = rowSelectedTableViewController()
            self.navigationController?.pushViewController(destination, animated: true)
        }
        
    }

}
