//
//  PlayerDetailTableViewController.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 13/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import UIKit

class PlayerDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit PlayerDetailsViewController")
    }

    //MARK : Properties
    var player: Player?
    
   
    
    var game : String = "Chess" {
        didSet {
            detailLabel.text = game
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = false

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavePlayerDetail", let playerName = nameTextField.text {
            player = Player(name: playerName, game: game, rating: 1)
        }
        if segue.identifier == "PickGame",
            let gamePickerViewController = segue.destination as? GamePickerViewController {
            gamePickerViewController.selectedGame = game
        }
    }
    @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue ) {
        if let gamePickerViewController = segue.source as? GamePickerViewController,
            let selectedGame = gamePickerViewController.selectedGame {
            game = selectedGame
        }
    }
}
