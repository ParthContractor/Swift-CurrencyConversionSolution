//
//  CurrencyConverterSDKTests.swift
//  CurrencyConverterSDKTests
//
//  Created by Parth on 09/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import XCTest
@testable import CurrencyConverterSDK

class CurrencyConverterSDKTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrencyCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        CurrencyConverterHandler.sharedInstance.getAvailableCurrencies(completionHandler: { currenyList  in
            XCTAssertNotEqual(currenyList.count, 0)
            exp.fulfill()
        })
        waitForExpectations(timeout: 15, handler: nil)
    }
}
