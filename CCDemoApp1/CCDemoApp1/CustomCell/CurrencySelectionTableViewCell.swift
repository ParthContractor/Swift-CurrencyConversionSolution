//
//  CurrencySelectionTableViewCell.swift
//  CCDemoApp1
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class CurrencySelectionTableViewCell: UITableViewCell {

    static let cellIdentifier = "CurrencySelectionTableViewCellId"
    @IBOutlet var currencyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        decorateCurrencyLabel()
    }
    
    var currencyLabelFont = UIFont.ThemeFont.currencyRatesListFont {
        didSet {
            currencyLabel.font = currencyLabelFont
        }
    }

    private func decorateCurrencyLabel()  {
        currencyLabel.adjustsFontSizeToFitWidth = false
        currencyLabel.font = currencyLabelFont
        currencyLabel.textColor = UIColor.ThemeColor.currencyRatesListColor
    }
}
