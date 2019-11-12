//
//  CurrencyRateDisplayVC.swift
//  CCDemoApp1
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import CurrencyConverterSDK

class CurrencyRateDisplayVC: UIViewController {
    var currencyRates: [Currency]
    
    // MARK: - initilisers
    init(nibName:String, currencyRates: [Currency] = [Currency]()){
        self.currencyRates = currencyRates
        super.init(nibName: nibName, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var tableViewCurrencyRateDisplay: UITableView!

    // MARK: - initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        loadData()
    }
    
    func loadData(){
        showLoadingIndicator(onView: view)
        CurrencyConverterHandler.sharedInstance.getAvailableCurrencies(completionHandler: { currenyList  in
            let sortedArray = currenyList.sorted {
                $0.code < $1.code
            }
            self.currencyRates = sortedArray
            DispatchQueue.main.async {
                self.tableViewCurrencyRateDisplay.reloadData()
                self.removeLoadingIndicator()
            }
        })
    }
    
    func initialSetUp(){
        //estimated row height for dynamic cell before actual height gets calculated based on constraints
        tableViewCurrencyRateDisplay.rowHeight = UITableView.automaticDimension
        tableViewCurrencyRateDisplay.estimatedRowHeight = 80
        
        //tableview cell registeration
        tableViewCurrencyRateDisplay.register(UINib(nibName: "CurrencySelectionTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencySelectionTableViewCell.cellIdentifier)
        tableViewCurrencyRateDisplay.tableFooterView = UIView()
        
        //right bar button for refresh functionality
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshList))
        self.navigationItem.rightBarButtonItem  = refreshButton

        
        title = navigationTitle
    }
    
    @objc func refreshList(){
        loadData()
    }
}
