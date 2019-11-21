//
//  AppConstants.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
class AppConstants: NSObject {
     enum BaseURL:String {
           case production = "https://lieservices.luluone.com:9443"                                //
          // case test         = "https://lieservices.luluone.com:9443"                           // Staging
     }
    enum APIUrls:String {
        case convertor = "/liveccyrates"
    }
    enum APIUrlKeys:String {
        case payload = "payload"
    }
    enum APIUrlPayLoad:String {
        case currencyRate = "{\"activityType\":\"rates.get\",\"aglcid\":458998,\"instype\":\"LR\"}"
    }
     static let baseURL                      =  BaseURL.production.rawValue
    
    
    static let screenHeight        = UIScreen.main.bounds.size.height
    static let screenWidth         = UIScreen.main.bounds.size.width
    static let currencyDecimal     = 5
    static let menuOptions = ["Send Money","Receipients","My Transfers","Live Chat","Promotions","My Account"]
    static let menuOptionImages = ["send","receipients","transfer","chat","promotions","accounts"]
   
}
