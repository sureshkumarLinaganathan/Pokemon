//
//  WebService.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import Foundation

typealias successCallback = (Bool,AnyObject) -> Void
typealias failureCallback = (String)->Void

class WebService {
    
    class func initiateServiceCall(headers: [String: String]?, withMethod method :HttpMethod, urlStr: String, enableCache : Bool = false, requestObj : Data?, successCallBack : @escaping successCallback, failureCallback: @escaping failureCallback) -> URLSessionDataTask? {
        
        let request = constructRequest(headers:headers, requestData:requestObj, withMethod:method, urlStr:urlStr)
        return WebService.makeServiceCall(request:request, successCallBack: { (success,response) in
            successCallBack(success,response)
        }) { (errorMsg) in
            failureCallback(errorMsg)
        }
    }
}

private extension WebService{
    
    class private func constructRequest (headers: [String: String]?, requestData: Data?, withMethod method : HttpMethod,urlStr: String, enableCache : Bool = false) -> URLRequest {
        var urlStr = urlStr.replacingOccurrences(of: " ", with: "%20", options: .caseInsensitive, range: nil)
        urlStr = urlStr.replacingOccurrences(of: "#", with: "%23", options: .caseInsensitive, range: nil)
        urlStr = urlStr.replacingOccurrences(of: "\t", with: "%20", options: .caseInsensitive, range: nil)
        var request: URLRequest!
        let url:URL = URL.init(string:urlStr)!
        request = URLRequest.init(url:url)
        request.httpMethod = method.rawValue
        
        if (method == .post || method == .put || method == .delete), let data = requestData {
            request.httpBody = data
        }
        
        request.allHTTPHeaderFields = headers
        return request
    }
}

private extension WebService{
    
    class private func makeServiceCall(request : URLRequest,successCallBack : @escaping successCallback,failureCallback : @escaping failureCallback) -> URLSessionDataTask? {
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            let tempResponse = response as? HTTPURLResponse
            let statusCode = String.init(format: "%d", tempResponse?.statusCode ?? 0)
            if statusCode == "200" {
                do{
                    let dict = try JSONSerialization.jsonObject(with:data!, options:[])
                    if let responseObject = dict as? [String:Any]{
                        successCallBack(true,responseObject as AnyObject)
                    }
                }catch{
                    
                }
            }else if data != nil{
                do{
                    let dict = try JSONSerialization.jsonObject(with:data!, options:[])
                    
                    if  let dictObj = dict as? [String:Any], let errorMsg = dictObj["message"] as? String {
                        failureCallback(errorMsg)
                    }else if let dictObj = dict as? [String:Any], let responseDict = dictObj["response"] as? [String:Any],let errorMsg = responseDict["message"] as? String{
                        failureCallback(errorMsg)
                    }
                    
                }catch{
                    
                    failureCallback(error.localizedDescription)
                }
                
            }else{
                failureCallback(error?.localizedDescription ?? "")
            }
            
        })
        dataTask.resume()
        return dataTask
    }
}












