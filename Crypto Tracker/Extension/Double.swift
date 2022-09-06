//
//  Double.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 4.09.2022.
//

import Foundation

extension Double {
    
    ///Converts a double into a Currency with 2 decimals
    ///```
    ///Convert 1234.56 to $1,234.56
    ///```
    private var currencyFormatter2 : NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current
        //formatter.currencyCode = "TRY"
        //formatter.currencySymbol = "TL"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    
    ///Converts a double into a String Currency with 2 decimals
    ///```
    ///Convert 1234.56 to "$1,234.56"
    ///```
    func asCurrencyWith6Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    ///Converts a double into a String representation
    ///```
    ///Convert 1.2345 to "1.23"
    ///```
    func asNumberString()-> String {
        return String(format: "%.2f", self)
    }
    
    ///Converts a double into a  string representation with percent symbol
    ///```
    ///Convert 1.2345 to "1.23%"
    ///```
    func asPercentString()-> String{
        return asNumberString() + "%"
    }
    
}
