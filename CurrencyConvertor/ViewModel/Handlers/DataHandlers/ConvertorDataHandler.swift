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
    func getCountryFlag(from code:String)->String? {
        return code.lowercased()
    }
    func getSecondaryCurrencyObject(_ currencyList:[CurrencyRate])->CurrencyRate? {
        guard let secondObj =  currencyList.dropFirst().first else{
            return nil
        }
        return secondObj
    }
    func getPrimaryCurrencyObject(_ currencyList:[CurrencyRate])->CurrencyRate? {
        currencyList.filter{$0.code == AppConstants.de}
        return secondObj
    }
}
