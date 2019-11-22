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
    var currencyUpdatedRateList = [CurrencyRate]()
    var currencyBaseRateList = [CurrencyRate]()
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
   
    func getSecondaryCurrencyObject(_ currencyList:inout [CurrencyRate])->CurrencyRate? {
        dataHandler.getSecondaryCurrencyObject(&currencyList)
    }
    func getPrimaryCurrencyObject()->CurrencyRate? {
        dataHandler.getPrimaryCurrencyObject()
    }
    func updateCurrencyListWithReference(_ currency:CurrencyRate,currencylist:[CurrencyRate])->[CurrencyRate] {
        dataHandler.updateCurrencyListWithReference(currency,currencylist)
    }
    
    
       
}
