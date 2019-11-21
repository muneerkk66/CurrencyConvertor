//
//  ConvertorInputView.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 20/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
class CurrencyView:  UIView {
    @IBOutlet var titleLabel: PaddingLabel!
    @IBOutlet var countryTitle: UILabel!
    @IBOutlet var countryImageView: UIImageView!
    
    func setCurrency(_ currency:CurrencyRate){
        self.titleLabel.text = String(currency.rate.roundTo(places: AppConstants.currencyDecimal))
        self.countryTitle.text = currency.code
        guard let img = UIImage(named:currency.imageString ?? "") else {
             return
        }
        self.countryImageView.image = img
    }
}

