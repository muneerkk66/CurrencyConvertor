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
    var shouldSaveCookies:Bool = false
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
    
    /// csrft token that has to be sent on each post request
//    var csrftToken:String{
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: ORConstants.csrfToken)
//        }
//        get {
//            /// Returns previously assigned csrf token
//            return UserDefaults.standard.object(forKey: ORConstants.csrfToken) as? String ?? ""
//        }
//    }
    

    
  
    
    
    /// Validate the status code
    fileprivate func validateStatusCode(with statusCode:Int? = nil) -> Bool {
        if let status = statusCode {
            if(status == StatusCode.invalidSession.rawValue || status == StatusCode.olderAppVersion.rawValue || status == StatusCode.serviceUnavailable.rawValue || status == StatusCode.notAvailable.rawValue) {
                return false
            }
        }
        return true
    }
    
    
    /**
     - Method to return the request header
     - PUT, POST and DOWNLOAD require csrft token as a part of header fields
     */
    
    
//    fileprivate func requestHeader(with csrftToken:String? = nil) -> [String:String] {
//        var  headers = [ORAPIConstants.acceptLanguage:CountryInfoVM.getDeviceLanguage()]
//        if let token = csrftToken {
//            headers [  "X-CSRFToken" ] =  token
//        }
//        if let sessionID =  UserDefaults.standard.value(forKey: ORConstants.sessionToken) {
//            headers [ORAPIConstants.sessionid] = sessionID as? String
//        }
//        // Added new header for versioning
//        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//            headers [ORAPIConstants.accept] =  "application/json;version=" + version
//        }
//        // Added new header for versioning
//        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//            headers [ORAPIConstants.accept] =  "application/json;version=" + version
//        }
//
//        // Added Device information
//            headers [ORAPIConstants.deviceModel] = UIDevice.current.name
//
//        return headers
//    }
    
}


extension APICalls {
    /**
     Makes a GET Request
     
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
                       // weakSelf.handleInvalidStatusCodes(response: response)
                    }
                } else {
                    // Check for errorCode 53 added to handle error in iOS 12 on calling Api immeadiately after app enters foreground
                    if let error = response.error as NSError?, error.code == weakSelf.connectionAbortErrorCode {
                        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers:nil).responseJSON { [weak self] (response) -> Void in
                            guard let weakSelf = self else {
                                return
                            }
                            
                            if let statusCode = response.response?.statusCode {
                               
                            } else {
                                completionBlock(nil, response.error as NSError? )
                            }
                        }
                    } else {
                        completionBlock(nil, response.error as NSError? )
                    }
                }
        }
    }

    
//    private func checkForValidStatusCode(statusCode: Int, response: DataResponse<Any>, completionBlock: ApiCompletionBlock) {
//        if validateStatusCode(with: statusCode) == true {
//            switch (response.result){
//            case .success(_):
//                /* to check versonError in result*/
//                checkForVersionErrorBannerMessage(response: response)
//                saveCookies()
//                completionBlock(response.result.value as AnyObject?, nil)
//            case .failure(let error):
//                completionBlock(nil, error as NSError? )
//            }
//        } else {
//            handleInvalidStatusCodes(response: response)
//        }
//    }
//
//
//    class func createGenericError() -> NSError {
//        let statusMessage = ORConstants.genericErrorMessage
//        let  error = NSError(domain: "", code: 1, userInfo:[NSLocalizedDescriptionKey: statusMessage,NSLocalizedFailureReasonErrorKey: statusMessage])
//        return error
//    }

    
}


