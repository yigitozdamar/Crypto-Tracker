//
//  XMarkButton.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 8.09.2022.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        Button {
            dismiss()
            
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
