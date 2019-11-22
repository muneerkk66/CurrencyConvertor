//
//  ConvertorDataHandler.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
class ConvertorDataHandler: NSObject {
    func getSecondaryCurrencyObject(_ currencyList:inout [CurrencyRate])->CurrencyRate? {
        return currencyList.dropFirst().first
    }
    func getPrimaryCurrencyObject()->CurrencyRate? {
         
        return CurrencyRate(code: AppConstants.defaultCurrencyCode, rate: AppConstants.defaultCurrencyValue, name: AppConstants.defaultCurrencyName)
    }
    func updateCurrencyListWithReference(_ currency:CurrencyRate,_ currencylist:[CurrencyRate])->[CurrencyRate] {
            
            let baseCurrency = currencylist.filter{$0.code == currency.code}.first
            return currencylist.map{
                var obj = $0
                if obj.code == currency.code {
                    obj.rate = currency.rate
                }else{
                    if currency.code == AppConstants.defaultCurrencyCode {
                         obj.rate = currency.rate * obj.rate
                    }else{
                        
                        obj.rate =  obj.rate / (baseCurrency!.rate) * currency.rate
                    }
                }
                return obj
        }
        
        
    }
}
