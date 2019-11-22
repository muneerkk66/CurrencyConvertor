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
    
    //MARK: fetch the secondary currency from the list,We kept the list as order like primary,secondary,etc so on. So we will drop the first object then will take the first element from the dropped list.
    func getSecondaryCurrencyObject(_ currencyList:inout [CurrencyRate])->CurrencyRate? {
        return currencyList.dropFirst().first
    }
    //MARK: Default Currency Object, which is equal to Primary Currency
    func getPrimaryCurrencyObject()->CurrencyRate? {
        return CurrencyRate(code: AppConstants.defaultCurrencyCode, rate: AppConstants.defaultCurrencyValue, name: AppConstants.defaultCurrencyName)
    }
    //MARK: Update the Currency rate with reference of the input entry value.
    //MARK:Calculation is follow...........
    //MARK:METHOD - 1 :   1 MYR = 0.88 AED , 10 MYR = 10* 0.88 AED
    //MARK:METHOD - 2 :   1 AED = 1.4 MYR , 10 AED =  (1.4 AED / (0.88 AED) * 10 AED) MYR
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
