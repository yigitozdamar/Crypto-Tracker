//
//  CoinRowView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 4.09.2022.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn : Bool
    
    var body: some View {
        HStack(spacing:0){
            leftColumn
            
            Spacer()
            
            if showHoldingColumn{
                centerColumn
            }
            
            rightColumn        }
        .font(.subheadline)
        .contentShape(RoundedRectangle(cornerRadius: 1))
    }
}

extension CoinRowView {
    
    private var leftColumn : some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.accentColor)
                .frame(minWidth:30)
            
            CoinImageView(coin: coin).frame(width: 30, height: 30)
            
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        
    }
}



struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
    }
}

