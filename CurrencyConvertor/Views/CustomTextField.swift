//
//  TextField.swift
//  CurrencyConvertor
//
//  Created by Muneer KK on 20/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import UIKit
 //MARK: - Custom textfield is used to customize the textfield values we have added two ibinspectable for updating the left padding & right passing. The value is customizable from interface element
@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

}
