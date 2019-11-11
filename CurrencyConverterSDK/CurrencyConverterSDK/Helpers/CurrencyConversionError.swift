//
//  CurrencyConversionError.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

public enum CurrencyConversionError: Error {
    case buyRateUnavailable
    case sellRateUnavailable
    case currencyNotFound
    case unknown
}
