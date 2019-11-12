//
//  CurrencyRateDisplayVC_Extension.swift
//  CCDemoApp1
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit

extension CurrencyRateDisplayVC: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview delegate/datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRates.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         cell.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionTableViewCell.cellIdentifier) as! CurrencySelectionTableViewCell
        cell.currencyLabel.text = currencyRates[indexPath.row].description
        cell.accessibilityIdentifier = currencyRates[indexPath.row].currencyID
        return cell
    }
}
