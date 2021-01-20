//
//  PokemonListTableViewCell.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import UIKit
let PokemonListTableViewCellIdentifier = "PokemonListIdentifier"

class PokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    func setupView(name:String){
        nameLabel.text = name
    }
    
}
