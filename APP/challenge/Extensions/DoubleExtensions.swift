//
//  DoubleExtensions.swift
//  challenge
//
//  Created by Wagner Sales on 30/07/24.
//

import Foundation

extension Double {
    var formatToBrazilianCurrency: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.currencySymbol = "R$"

        return numberFormatter.string(from: NSNumber(value: self))
    }
}
