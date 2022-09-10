//
//  HomeViewModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 5.09.2022.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics : [StatisticModel] = []
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var isLoading : Bool = false
    @Published var sortOption : SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService  = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        
        addSubscribers()
        
    }
    
    enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    func addSubscribers(){
        
        //update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        // updade porfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPorfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        //update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(marketGlobalData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellable)
        
        
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func mapAllCoinsToPorfolioCoins(allCoins : [CoinModel], portfolioEntities : [PortfolioEntity] )-> [CoinModel]{
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entitiy = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHolding(amount: entitiy.amount)
            }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterAndSortCoins(text:String, coins:[CoinModel],sort:SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        //sort coins
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort:SortOption, coins : inout [CoinModel]){
        switch sort {
            case .rank,.holdings:
                coins.sort(by: {$0.rank < $1.rank})
            case .rankReversed,.holdingsReversed:
                coins.sort(by: {$0.rank > $1.rank})
            case .price:
                coins.sort(by: {$0.currentPrice > $1.currentPrice})
            case .priceReversed:
                coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins : [CoinModel]) -> [CoinModel]{
        //will only sort by holdings or reversedHolding if needed
        switch sortOption {
            case .holdings:
                return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
            case .holdingsReversed:
                return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
            default:
                return coins
        }
    }
    
    private func filterCoins(text:String, coins:[CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else{
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        return filteredCoins
    }
    
    private func marketGlobalData (marketDataModel: MarketDataModel?, portfolioCoins : [CoinModel]) -> [StatisticModel] {
        
        var stats : [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value:data.marketCap , percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "Total Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

         // The same with below
//        let portfolioValue = portfolioCoins.map { (coin) in
//            return coin.currentHoldings
//        }
        
        let portfolioValue = portfolioCoins.map({$0.currentHoldingsValue}).reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentageChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentageChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith6Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
        marketCap,
        volume,
        btcDominance,
        portfolio
        ])
        
        return stats
        
    }
    
}
