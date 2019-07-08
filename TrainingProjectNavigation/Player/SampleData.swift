//
//  SampleData.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 13/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import Foundation

final class SampleData {
    
    static func generatePlayersData() ->[Player]{
        return [
            Player(name: "Bill Evans", game: "Spin  the Bottle", rating : 4),
            Player(name: "Oscar Peterson", game: "tic-tac-toe", rating: 5),
            Player(name: "Dave Bruckek", game: "Texas Hold 'em Poker ", rating: 2)
            
        ]
    }
}
