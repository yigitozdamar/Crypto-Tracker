//
//  UIApplication.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 7.09.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditting(){
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
