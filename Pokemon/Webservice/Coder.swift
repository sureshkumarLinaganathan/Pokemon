//
//  Extensions.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import UIKit

extension URLRequest {
    
    init(withurlString urlString : String, enableCache : Bool = false) {
        let url = URL.init(string: urlString)!
        self.init(url: url, cachePolicy: enableCache ? .returnCacheDataElseLoad : .useProtocolCachePolicy, timeoutInterval: 180.0)
    }
}

class Parser{
    
    class func decode <T: Codable> (data: Any, type: T.Type) -> AnyObject{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject:data , options: .prettyPrinted)
            let decodeObj  = try JSONDecoder().decode(type.self, from: jsonData)
            return decodeObj as AnyObject
        }catch {
            print(error.localizedDescription)
            return [] as AnyObject
        }
    }
    
}


