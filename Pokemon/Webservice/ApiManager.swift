//
//  ApiManager.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import Foundation


class ApiManager: NSObject {
    
    
    class func fetchPokemonInfo(type:Int,successCallback: @escaping successCallback,failureCallback: @escaping failureCallback){
        
        let pathStr = [String(type)]
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchPokemonInfo, forHeaderType:.basic, queryString:[:], apiType:.firstVersion, paths:pathStr)
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, enableCache:false, requestObj:nil, successCallBack: { (success,response) in
            
            if let dict = response as? [String:Any]{
                let modelData = Parser.decode(data:dict, type:PokemonInfo.self)
                successCallback(success,modelData)
                return
            }
            successCallback(success,[] as AnyObject)
            
        }, failureCallback: { (message) in
            failureCallback(message)
        })
    }
}

