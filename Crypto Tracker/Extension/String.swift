//
//  String.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 12.09.2022.
//

import Foundation

extension String {
    
    var removingHTMLOccurances : String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
