//
//  Constants.swift
//  CCDemoApp1
//
//  Created by Parth on 12/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit
import CurrencyConverterSDK

let navigationTitle = "MoneyTap forex"

extension UIFont {
    struct ThemeFont {
        static let currencyRatesListFont = UIFont.boldSystemFont(ofSize: 19.0)
    }
}

extension UIColor {
    struct ThemeColor {
        static let navigationBarTintColor = UIColor.yellow
        static let navigationTintColor = UIColor.orange
        static let currencyRatesListColor = UIColor.green
    }
}

extension Currency: CustomStringConvertible {
    public var description: String {
        return ("\(code) (\(country))---\("SellRate:") \(sellRate)")
    }
}

