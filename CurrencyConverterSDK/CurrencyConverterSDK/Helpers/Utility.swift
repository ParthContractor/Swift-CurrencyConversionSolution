//
//  Utility.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

struct Utility{
    
    static func search(key:String, in dict:[String:Any], completion:((Any) -> ())) {
        if let foundValue = dict[key] {
            completion(foundValue)
        } else {
            dict.values.enumerated().forEach {
                if let innerDict = $0.element as? [String:Any] {
                    search(key: key, in: innerDict, completion: completion)
                }
            }
        }
    }
    
}
