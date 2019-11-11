//
//  CurrencyConverterHandler.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 09/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit

@objc final public class CurrencyConverterHandler: NSObject {

@objc public static let sharedInstance = CurrencyConverterHandler()
    private override init() {
    }

    public func getAvailableCurrencies(completionHandler: @escaping (_ currencyList:[Currency]) -> Void){
        CurrencyAPIManager.shared.getCurrencyData(completionHandler:{ arrayData,error  in
            if let _ = error{
                completionHandler([Currency]())
            }
            
            if let data = arrayData{
                let containers = try? JSONDecoder().decode(Containers.self, from: data)
                if let product = containers?.product {
                    completionHandler(self.convertDataToCurrencyList(product))
                }
                else{
                    completionHandler([Currency]())
                }
            }
        })
    }
    
    private func convertDataToCurrencyList(_ product: Product) -> [Currency] {
        var currencyList = [Currency]()
        for productInnerItem in product.inner {
            if productInnerItem.title.count != 0, productInnerItem.productId.count != 0, let rate = productInnerItem.rate, rate.inner.count != 0, let code = rate.inner?.first?.currencyCode, let name = rate.inner?.first?.currencyName, let country = rate.inner?.first?.country, let buyRate = rate.inner?.first?.buyTT, let sellRate = rate.inner?.first?.sellTT, let lastUpdated = rate.inner?.first?.LASTUPDATED {
                currencyList.append(Currency(currencyID: productInnerItem.productId, code: code, name: name, country: country, buyRate: buyRate, sellRate: sellRate, lastUpdated: lastUpdated))
            }
        }
        return currencyList
    }
}
