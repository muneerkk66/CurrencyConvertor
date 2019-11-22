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
    
    //MARK: - Lazy loading the Menu options
    lazy var menuTitles: [String] = {
        [unowned self] in
        return AppConstants.menuOptions
    }()
    //MARK: - Lazy loading the Menu Images
    lazy var menuImages: [String] = {
        [unowned self] in
        return AppConstants.menuOptionImages
    }()
    
    //MARK: - Fetch Currency From API
    func fetchCurrencyDetails(onCompletion:@escaping VMDataCompletionBlock){
        apiHandler.getCurrencyDetails() { (responseObject, errorObject) -> () in
            onCompletion(responseObject, errorObject)
        }
    }
   //MARK: - Get Secondary Currency Details
    func getSecondaryCurrencyObject(_ currencyList:inout [CurrencyRate])->CurrencyRate? {
        dataHandler.getSecondaryCurrencyObject(&currencyList)
    }
    //MARK: - Get Primary Currency Details
    func getPrimaryCurrencyObject()->CurrencyRate? {
        dataHandler.getPrimaryCurrencyObject()
    }
    //MARK: - Update all curency list
    func updateCurrencyListWithReference(_ currency:CurrencyRate,currencylist:[CurrencyRate])->[CurrencyRate] {
        dataHandler.updateCurrencyListWithReference(currency,currencylist)
    }
    
    
       
}
