//
//  AppEnum.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 21/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
// MARK: CollectionViewCellIdentifier -
enum CollectionViewCellIdentifier: String {
    case menuCellID                    = "menuCellID"
}

// MARK: TableViewCellIdentifier -
enum TableViewCellIdentifier:String {
    case currencyCellID                = "currencyCellID"
}

// MARK: StoryboardIdentifier -
enum StoryboardIdentifier: String {
    case currencyListVCID             = "currencyListVCID"
    case convertorVCID                = "convertorVCID"
    
}
// MARK: Storyboard -
enum StoryboardName: String {
    
    case main                        = "Main"
}
