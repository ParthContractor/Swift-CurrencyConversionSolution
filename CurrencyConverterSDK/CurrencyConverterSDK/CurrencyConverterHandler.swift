//
//  CurrencyConverterHandler.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 09/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit

/// CurrencyConverterHandler is a singleton on which various APIs required for currency conversion are exposed.
@objc final public class CurrencyConverterHandler: NSObject {

@objc public static let sharedInstance = CurrencyConverterHandler()
    private override init() {
    }
    
    /// "getAvailableCurrencies"  is useful to fetch all required data for forex functionality to work. This returns array of custom model  'Currency'. All required data including Currency name, country name, currency code, sell/buy rate and last updated timing is available in shot.
    /// - Parameter completionHandler: This is Async API and the completition handler provides required result i.e   [Currency]-array of all available currency.
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
    
    /// "getBuyRateFor"  is helper method to fetch buy rate and lastupdatedtime for given currency through AUD. This returns either buy rate or error.
    /// - Parameter completionHandler: This is Async API which expects currency code and the completition handler provides required result i.e   BuyRate or  CurrencyConversionError for given currency code.
    public func getBuyRateFor(currencyCode:String, completionHandler: @escaping (_ buyRate:BuyRate?, _ error: CurrencyConversionError?) -> Void){
        
        CurrencyConverterHandler.sharedInstance.getAvailableCurrencies(completionHandler: { currenyList  in
            if currenyList.count == 0 {
                completionHandler(nil, CurrencyConversionError.currencyNotFound)
            }
            
            if let objCurrency = currenyList.first(where: { $0.code == currencyCode}) {
                if objCurrency.buyRate.count == 0 || objCurrency.buyRate == notAvailable {
                    completionHandler(nil, CurrencyConversionError.buyRateUnavailable)
                }
                else{
                    let objBuyRate = self.convertToBuyRate(objCurrency)
                    completionHandler(objBuyRate, nil)
                }
            }
            else{
                completionHandler(nil, CurrencyConversionError.currencyNotFound)
            }
        })
    }
    
    /// "getSellRateFor"  is helper method to fetch sell rate and lastupdatedtime for given currency through AUD. This returns either sell rate or error.
       /// - Parameter completionHandler: This is Async API which expects currency code and the completition handler provides required result i.e   SellRate or  CurrencyConversionError for given currency code.
       public func getSellRateFor(currencyCode:String, completionHandler: @escaping (_ sellRate:SellRate?, _ error: CurrencyConversionError?) -> Void){
           CurrencyConverterHandler.sharedInstance.getAvailableCurrencies(completionHandler: { currenyList  in
               if currenyList.count == 0 {
                   completionHandler(nil, CurrencyConversionError.currencyNotFound)
               }
               
               if let objCurrency = currenyList.first(where: { $0.code == currencyCode  }) {
                   if objCurrency.sellRate.count == 0 || objCurrency.sellRate == notAvailable {
                       completionHandler(nil, CurrencyConversionError.sellRateUnavailable)
                   }
                   else{
                       let objSellRate = self.convertToSellRate(objCurrency)
                       completionHandler(objSellRate, nil)
                   }
               }
               else{
                   completionHandler(nil, CurrencyConversionError.currencyNotFound)
               }
           })
       }
    
    private func convertToBuyRate(_ objCurrency: Currency) -> BuyRate {
        if objCurrency.lastUpdated.count != 0, objCurrency.lastUpdated != notAvailable {
            return BuyRate(buyRate: objCurrency.buyRate, lastUpdated: objCurrency.lastUpdated)
        }
        else{
            return BuyRate(buyRate: objCurrency.buyRate, lastUpdated: nil)
        }
    }
    
    private func convertToSellRate(_ objCurrency: Currency) -> SellRate {
          if objCurrency.lastUpdated.count != 0, objCurrency.lastUpdated != notAvailable {
              return SellRate(sellRate: objCurrency.sellRate, lastUpdated: objCurrency.lastUpdated)
          }
          else{
              return SellRate(sellRate: objCurrency.sellRate, lastUpdated: nil)
          }
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
