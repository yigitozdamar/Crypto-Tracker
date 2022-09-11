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
    
    @StateObject private var detailVm : DetailViewModel
    private let colums : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coin: CoinModel) {
        _detailVm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("")
                    .frame(height:150)
                
                overviewTitle
                Divider()
                overviewContent
                additionalTitle
                Divider()
                additionalContent
                
            }
            .padding()
        }
        .navigationTitle(detailVm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    private var overviewTitle : some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle : some View {
        
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewContent : some View {
        LazyVGrid(columns: colums,
                  alignment: .leading,
                  spacing: CGFloat(30),
                  pinnedViews: []) {
            ForEach(detailVm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalContent : some View {
        LazyVGrid(columns: colums,
                  alignment: .leading,
                  spacing: CGFloat(30),
                  pinnedViews: []) {
            ForEach(detailVm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
}
