//
//  ApiManager.swift
//   TrueWeight Task
//
//  Created by Suresh Kumar Linganathan on 30/12/20.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import Foundation


class ApiManager: NSObject {
    
    
    class func fetchOrderCourses(idValue:Int,type:String,successCallback: @escaping successCallback,failureCallback: @escaping failureCallback){
        
        let queryString = ["type":type]
        let pathStr = [String(idValue)]
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchAllCourses, forHeaderType:.basic, queryString:queryString, apiType:.firstVersion, paths:pathStr)
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, enableCache:false, requestObj:nil, successCallBack: { (success,response) in
            
            if let arr = response as? [[String:Any]]{
                let modelData = Parser.decode(data:arr, type:[CourseInfo].self)
                successCallback(success,modelData)
                return
            }
            successCallback(success,[] as AnyObject)
            
        }, failureCallback: { (message) in
            failureCallback(message)
        })
    }
}

