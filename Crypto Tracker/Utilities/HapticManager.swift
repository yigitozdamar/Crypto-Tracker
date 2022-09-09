//
//  HapticManager.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 9.09.2022.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type : UINotificationFeedbackGenerator.FeedbackType){
        
        generator.notificationOccurred(type)
    }
    
}
