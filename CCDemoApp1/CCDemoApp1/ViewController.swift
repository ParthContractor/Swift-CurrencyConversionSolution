//
//  ViewController.swift
//  CCDemoApp1
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import CurrencyConverterSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CurrencyConverterHandler.sharedInstance.getAvailableCurrencies(completionHandler: { currenyList  in
            print("currency list")
        })

    }


}

