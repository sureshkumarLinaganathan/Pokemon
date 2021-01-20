//
//  ServiceProvider.swift
//   TrueWeight Task
//
//  Created by Suresh Kumar Linganathan on 30/12/20.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import UIKit

class ServiceProvider: NSObject {
    
    class func fetchOrderCourses(idValue:Int,type:String,successCallback: @escaping successCallback,failureCallback: @escaping failureCallback){
        
        ApiManager.fetchOrderCourses(idValue:idValue, type:type, successCallback: { (success,response) in
            successCallback(success,response)
        }) { (message) in
            failureCallback(message)
        }
        
    }
    
}


