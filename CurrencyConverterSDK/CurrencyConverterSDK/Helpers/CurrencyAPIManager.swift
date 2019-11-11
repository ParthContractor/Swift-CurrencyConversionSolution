//
//  CurrencyAPIManager.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 09/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

final class CurrencyAPIManager{
    static let shared = CurrencyAPIManager()
    
    private init(){}
        
    func getCurrencyData(completionHandler: @escaping (_ data:Data?,_ error:Error?) -> Void){
        
        guard let url = URL(string: str_API_URL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(nil,error)
            }
            
            guard let jsonData = data else { return }
            
            do {
                let resultJson = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:AnyObject]
                if let dictionary = resultJson {
                     Utility.search(key: fxPortFolioKey, in: dictionary, completion: {
                        let jsonData = try? JSONSerialization.data(withJSONObject: $0, options: [])
                        completionHandler(jsonData,nil)
                    })
                }
            } catch {
                completionHandler(nil,error)
            }
            
            }.resume()
    }
    
}
