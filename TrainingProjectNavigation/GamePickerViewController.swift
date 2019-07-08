//
//  GamePickerViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 13/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {
    
    
    //MARK: - Properties
    var games = [
    "Angry Birds", "Chess", "Spin the Bottle", "Texes Hold'em poker", "Russian Roulette",
    "Tic-Tac-Toe"
    ]
    var selectedGame: String? {
        didSet{
            if let selectedGame = selectedGame,
                let index = games.index(of : selectedGame){
                selectedGameIndex = index
            }
        }
    }
    
     var selectedGameIndex: Int?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = games[indexPath.row]
        
        if indexPath.row == selectedGameIndex {
            cell.accessoryType = .checkmark }
        else{
                    cell.accessoryType = .none
            }
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedGameIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedGame = games[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
  
   
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveSelectedGame",
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        let index = indexPath.row
        selectedGame = games[index]
    }
    
   */

}
