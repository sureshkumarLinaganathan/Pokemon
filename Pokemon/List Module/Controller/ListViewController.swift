//
//  ViewController.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
   private var pokemonName = ["Bulbasaur","Ivysaur","Venusaur","Charmander","Charmeleon"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        
    }
    
    private func registerTableViewCell(){
        
        tableView.register(UINib(nibName:"PokemonListTableViewCell", bundle:nil), forCellReuseIdentifier:PokemonListTableViewCellIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController, let type = sender as? Int{
            controller.type = type
            controller.titleStr = pokemonName[type-1]
        }
    }
    
}


extension ListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
      return pokemonName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:PokemonListTableViewCell = tableView.dequeueReusableCell(withIdentifier:PokemonListTableViewCellIdentifier, for:indexPath) as! PokemonListTableViewCell
        cell.setupView(name:pokemonName[indexPath.row])
        return cell
    }
}

extension ListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier:DetailViewControllerSegue, sender:indexPath.row+1)
    }
}

