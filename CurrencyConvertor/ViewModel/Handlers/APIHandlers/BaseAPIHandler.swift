//
//  BaseAPIHandler.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit

class BaseAPIHandler: NSObject {

    internal typealias ApiCompletionBlock = (_ responseObject : AnyObject?, _ errorObject : NSError?) -> ()
    internal var networkManager : NetworkManager = NetworkManager()

    //MARK: - initializers
    override init(){
    }

}
