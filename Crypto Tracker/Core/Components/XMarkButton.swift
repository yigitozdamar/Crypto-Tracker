//
//  XMarkButton.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 8.09.2022.
//

import SwiftUI

struct XMarkButton: View {
    
    @State var iconName : String = "xmark"
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        Button {
            dismiss()
            
        } label: {
            Image(systemName: iconName)
                .font(.headline)
        }

    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
