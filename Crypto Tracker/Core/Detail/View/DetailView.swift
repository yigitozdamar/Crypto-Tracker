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
    @State private var showFullDescription : Bool = false
    
    private let colums : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coin: CoinModel) {
        _detailVm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            
            VStack {
                ChartView(coin: detailVm.coin)
                    .padding(.vertical)
                VStack(spacing:20){
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewContent
                    additionalTitle
                    Divider()
                    additionalContent
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(detailVm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
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
    
    private var navigationBarTrailingItems : some View {
        HStack {
            Text(detailVm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: detailVm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
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
    
    private var descriptionSection : some View {
        ZStack{
            if let coinDescription = detailVm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Read Less" : "Read More")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.vertical,4)
                    }
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                
                

            }
        }
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
    
    private var websiteSection : some View {
        VStack(alignment: .leading, spacing: 10){
            if let webString = detailVm.websiteURL, let webUrl = URL(string: webString) {
                Link("Website", destination: webUrl)
            }
            if let redditUrl = detailVm.redditURL, let redditUrl = URL(string: redditUrl){
                Link("Reddit", destination: redditUrl)
            }
        }
        .font(.footnote)
        .foregroundColor(Color.blue)
        .frame(maxWidth:.infinity,alignment: .leading)
        
    }
    
}
