//
//  ConvertorVM.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
class ConvertorVM :BaseVM {
    var apiHandler:ConvertorAPIHandler = ConvertorAPIHandler()
    var dataHandler:ConvertorDataHandler = ConvertorDataHandler()
    var currencyRateList = [CurrencyRate]()
    lazy var menuTitles: [String] = {
        [unowned self] in
        return AppConstants.menuOptions
    }()
    lazy var menuImages: [String] = {
        [unowned self] in
        return AppConstants.menuOptionImages
    }()
    
    func fetchCurrencyDetails(onCompletion:@escaping VMDataCompletionBlock){
        
        apiHandler.getCurrencyDetails() { (responseObject, errorObject) -> () in
            onCompletion(responseObject, errorObject)
        }
    }
    func getCountryFlagImage(from code:String)->String? {
        dataHandler.getCountryFlag(from: code)
    }
    func getSecondaryCurrencyObject(_ currencyList:[CurrencyRate])->CurrencyRate? {
        dataHandler.getSecondaryCurrencyObject(currencyList)
    }
    
    
       
}
