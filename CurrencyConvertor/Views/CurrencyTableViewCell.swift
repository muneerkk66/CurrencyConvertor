//
//  CurrencyTableViewCell.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 21/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
@IBOutlet var currencyView: CurrencyView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ currency:CurrencyRate){
        currencyView.setCurrency(currency)
    }

}
