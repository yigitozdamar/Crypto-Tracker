//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 4.09.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio : Bool = false //animate right
    @State private var showPortfolioView : Bool = false // new sheet
    
    var body: some View {
        ZStack{
            //background layer
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            //content layer
            VStack{
                
                homeHeader
                
                HomeStatisticsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
               
                if !showPortfolio{
                    allCoinsList
                        .transition(.move(edge: .leading))
                        .refreshable {
                            vm.reloadData()
                        }
                }else if showPortfolio{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
                
                
            }
        }
    }
}


extension HomeView {
    
    private var homeHeader : some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background( CircleButtonAnimationView(animate: $showPortfolio))
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            Spacer()
            Text(showPortfolio ? "Show Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList : some View {
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList : some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles : some View {
        HStack{
            HStack(spacing:4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }

            }
            Spacer()
            if showPortfolio{
                HStack(spacing:4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }

                }
            }
            HStack(spacing:4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .price) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }

            }
            
            Button {
                withAnimation(.linear(duration: 2.0)){
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.homeVM)
        
    }
}
