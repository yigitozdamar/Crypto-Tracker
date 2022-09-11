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
    
    @StateObject var detailVm : DetailViewModel
    
    init(coin: CoinModel) {
        _detailVm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View : \(String(describing: coin.name))")
    }
    
    var body: some View {
        Text("Hello")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
