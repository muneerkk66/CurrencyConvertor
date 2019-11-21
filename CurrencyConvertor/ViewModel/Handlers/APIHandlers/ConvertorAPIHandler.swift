//
//  ConvertorAPIHandler.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
class ConvertorAPIHandler: BaseAPIHandler {
    
    func getCurrencyDetails(_ onCompletion:@escaping ApiCompletionBlock) {
        var components = URLComponents(string: networkManager.baseURL + AppConstants.APIUrls.convertor.rawValue)
                
        let payLoad = URLQueryItem(name: AppConstants.APIUrlKeys.payload.rawValue, value: AppConstants.APIUrlPayLoad.currencyRate.rawValue)
        components?.queryItems = [payLoad]
        guard let urlpath = components?.string else {
            return
        }
        networkManager.getRequestPath(url: urlpath, parameters: nil) { [weak self](responseObject, errorObject) -> () in
        
            onCompletion(responseObject, errorObject)
        }
    }
}
