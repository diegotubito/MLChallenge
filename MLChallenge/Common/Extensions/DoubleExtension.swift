//
//  DoubleExtension.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

extension Double {
    func currencyFormat(decimal: Int, symbol: (String)? = nil) -> String {
        let numberFormatter = NumberFormatter()
        if symbol != nil {
            numberFormatter.currencySymbol = symbol
        }
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let formatoFinal = numberFormatter.string(from: NSNumber(value: self))!
        
        return String(formatoFinal)
    }
}


