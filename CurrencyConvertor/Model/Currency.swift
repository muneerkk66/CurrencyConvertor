//
//  CurrencyConvertor.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import UIKit
import Foundation
struct ConvertorResponse:Codable {
    var payload:ResponsePayLoad
}
struct ResponsePayLoad:Codable {
    var rates:[CurrencyRate]
}
struct CurrencyRate:Codable {
    var code:String
    var rate:Double
    var name:String
    var imageString:String?
    
    enum CodingKeys: String, CodingKey {
         case code = "toccy"
         case rate = "rate"
         case name = "ccyname"
         case imageString = "imageString"
    }
}

