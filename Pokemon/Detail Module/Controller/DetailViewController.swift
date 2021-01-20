//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.

import UIKit
let DetailViewControllerSegue = "PokemonDetailSegue"
private let kNoName = "No Name"

class DetailViewController: UIViewController {
    
    var type:Int = 1
    var titleStr:String?
    
    private var pokemonInfo:PokemonInfo?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerTableViewCell()
        fetchPokemonInfo(type:type)
        
    }
    
    private func registerTableViewCell(){
        
        tableView.register(UINib(nibName:"PokemonListTableViewCell", bundle:nil), forCellReuseIdentifier:PokemonListTableViewCellIdentifier)
    }
    private func setupView(){
        tableView.isHidden = true
        if let title = titleStr{
            self.navigationItem.title = title
        }
    }
    
}


extension DetailViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return pokemonInfo == nil ? 0 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        guard let obj = pokemonInfo else{
            return 0
        }
        
        if section == 0{
            return obj.abilities.count
        }else if section == 1{
            return obj.forms.count
        }else {
            return obj.moves.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:PokemonListTableViewCell = tableView.dequeueReusableCell(withIdentifier:PokemonListTableViewCellIdentifier, for:indexPath) as! PokemonListTableViewCell
        
        if indexPath.section == 0{
            let obj = pokemonInfo?.abilities[indexPath.row].ability
            cell.setupView(name:obj?.name ?? kNoName)
            
        }else if indexPath.section == 1{
            let obj = pokemonInfo?.forms[indexPath.row]
            cell.setupView(name:obj?.name ?? kNoName)
        }else if indexPath.section == 2{
            let obj = pokemonInfo?.moves[indexPath.row].move
            cell.setupView(name:obj?.name ?? kNoName)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = "Abilities"
        case 1:
            sectionName = "Forms"
        default:
            sectionName = "Moves"
        }
        return sectionName
    }
    
}

extension DetailViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

private extension DetailViewController{
    
    func fetchPokemonInfo(type:Int){
        startAnimation()
        ServiceProvider.fetchPokemonInfo(type:type, successCallback: { [weak self](success, response) in
            if let obj = response as? PokemonInfo{
                self?.pokemonInfo = obj
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopAnimation()
            }
            
        }) { [weak self](message) in
            DispatchQueue.main.async {
                self?.showAlert(message: message)
                self?.stopAnimation()
            }
        }
    }
    
}

private extension DetailViewController{
    func showAlert(message:String){
        
        let controller = UIAlertController.init(title:"", message:message, preferredStyle:.alert)
        let okAction = UIAlertAction.init(title:"Ok", style:.default) { (action) in
            controller.dismiss(animated:true, completion: nil)
        }
        controller.addAction(okAction)
        self.present(controller, animated:true, completion:nil)
    }
    func stopAnimation(){
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.startAnimating()
        tableView.isHidden = false
        
    }
    func startAnimation(){
        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
}
