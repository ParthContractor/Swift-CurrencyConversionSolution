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

let navigationTitle = "Western forex"

extension UIFont {
    struct ThemeFont {
        static let currencyRatesListFont = UIFont.systemFont(ofSize: 25)
    }
}
extension UIColor {
    struct ThemeColor {
        static let navigationBarTintColor = UIColor.orange
        static let navigationTintColor = UIColor.yellow
        static let currencyRatesListColor = UIColor.red
    }
}

extension Currency: CustomStringConvertible {
    public var description: String {
        return ("\(code) ---\("SellRate:") \(sellRate) and \("BuyRate:") \(buyRate) \n LastUpdated: \(lastUpdated)")
    }
}
