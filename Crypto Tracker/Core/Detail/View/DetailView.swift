//
//  DetailView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 10.09.2022.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin : CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing Detail View : \(String(describing: coin.name))")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
