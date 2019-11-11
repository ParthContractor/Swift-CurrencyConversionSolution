//
//  JSONModels.swift
//  CurrencyConverterSDK
//
//  Created by Parth on 09/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

struct TitleKey: CodingKey {
    let stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}

extension Decoder {
    func currentTitle() throws -> String {
        guard let titleKey = codingPath.last as? TitleKey else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath,
                                                    debugDescription: "Not in titled container"))
        }
        return titleKey.stringValue
    }
}

extension Decoder {
    func decodeTitledElements<Element: Decodable>(_ type: Element.Type) throws -> [Element] {
        let titles = try container(keyedBy: TitleKey.self)
        return try titles.allKeys.map { title in
            return try titles.decode(Element.self, forKey: title)
        }
    }
}

struct Product: Decodable {
    
    let inner: [InnerItem]!
    
    struct InnerItem: Decodable {
        let title: String
        let productId: String
        let rate: Rate?
        
        enum CodingKeys: String, CodingKey {
            case productId = "ProductId"
            case rate = "Rates"
        }
        
        init(from decoder: Decoder) throws {
            self.title = try decoder.currentTitle()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.productId = try container.decodeIfPresent(String.self, forKey: .productId) ?? ""
            self.rate = try container.decodeIfPresent(Rate.self, forKey: .rate)
        }
    }
    
    init(from decoder: Decoder) throws {
        self.inner = try? decoder.decodeTitledElements(InnerItem.self)
    }
}

struct Rate: Decodable {
    
    let inner: [InnerItem]!
    
    struct InnerItem: Decodable {
        let title: String
        let currencyName: String
        let currencyCode: String
        let country: String
        let buyTT: String
        let sellTT: String
        let LASTUPDATED: String
        
        enum CodingKeys: String, CodingKey {
            case currencyName, currencyCode, country, buyTT, sellTT, LASTUPDATED
        }
        
        init(from decoder: Decoder) throws {
            self.title = try decoder.currentTitle()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName) ?? ""
            self.currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
            self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
            self.buyTT = try container.decodeIfPresent(String.self, forKey: .buyTT) ?? ""
            self.sellTT = try container.decodeIfPresent(String.self, forKey: .sellTT) ?? ""
            self.LASTUPDATED = try container.decodeIfPresent(String.self, forKey: .LASTUPDATED) ?? ""
        }
    }
    
    init(from decoder: Decoder) throws {
        self.inner = try? decoder.decodeTitledElements(InnerItem.self)
    }
}

struct Containers: Decodable {
    let product: Product
    
    enum CodingKeys: String, CodingKey {
        case products = "Products"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.product = try container.decodeIfPresent(Product.self, forKey: .products)!
    }
}
