//
//  ServiceProvider.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import UIKit

class ServiceProvider: NSObject {
    
    class func fetchPokemonInfo(type:Int,successCallback: @escaping successCallback,failureCallback: @escaping failureCallback){
        
        ApiManager.fetchPokemonInfo(type:type, successCallback: { (success,response) in
            successCallback(success,response)
        }) { (message) in
            failureCallback(message)
        }
        
    }
    
}


