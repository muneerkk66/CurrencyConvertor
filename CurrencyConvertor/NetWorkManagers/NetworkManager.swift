//
//  NetworkManager.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import UIKit
import Alamofire

private typealias APICalls = NetworkManager

class NetworkManager: NSObject {
    
    var baseURL = AppConstants.baseURL
    internal typealias ApiCompletionBlock = (_ responseObject : AnyObject?, _ errorObject : NSError?) -> ()
    
    // MARK: Constants
    let connectionAbortErrorCode = 53
    
    /// Enum to handle invalid status codes
    enum StatusCode: Int{
        case invalidSession = 403
        case olderAppVersion = 405
        case serviceUnavailable = 503
        case notAvailable = 470
    }

    /// Validate the status code
    fileprivate func validateStatusCode(with statusCode:Int? = nil) -> Bool {
        if let status = statusCode {
            if(status == StatusCode.invalidSession.rawValue || status == StatusCode.olderAppVersion.rawValue || status == StatusCode.serviceUnavailable.rawValue || status == StatusCode.notAvailable.rawValue) {
                return false
            }
        }
        return true
    }
    
}


extension APICalls {
    //MARK:- Makes a GET Request
    /**
     - Parameter url: The url to fetch the data
     - Parameter parameters: The JSON data that has to be sent
     - Parameter completionBlock: Block that says whether the request was successful or failure
     
     */
       func getRequestPath(url:String, parameters:[String:AnyObject]?, completionBlock:@escaping ApiCompletionBlock) {
     
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers:nil)
            .responseJSON { [weak self] (response) -> Void in
                
                guard let weakSelf = self else {
                    return
                }
                
                if let statusCode = response.response?.statusCode {
                    if weakSelf.validateStatusCode(with: statusCode) == true {
                        switch (response.result){
                        case .success(_):
                            /* to check versonError in result*/
                            completionBlock(response.data as AnyObject?, nil)
                        case .failure(let error):
                            completionBlock(nil, error as NSError? )
                        }
                    }
                        
                    else{
                       // Show Error Alert
                    }
                } else {
                        completionBlock(nil, response.error as NSError? )
                }
        }
    }

    
}


