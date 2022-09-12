//
//  DetailViewModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 11.09.2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []
    @Published var coinDescription : String? = nil
    @Published var websiteURL : String? = nil
    @Published var redditURL : String? = nil
    
    @Published var coin : CoinModel
    private let coinDetailDataService : CoinDetailDataService
    private var canccellables = Set<AnyCancellable>()
    
    init(coin :CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedarrays) in
                
                self?.overviewStatistics = returnedarrays.overview
                self?.additionalStatistics = returnedarrays.additional
            }
            .store(in: &canccellables)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &canccellables)
        
    }
    
    private func mapDataToStatistics (coinDetailModel: CoinDetailModel?, coinModel : CoinModel) -> (overview : [StatisticModel], additional : [StatisticModel] ) {
        //Overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChangePercentage = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Value", value: price, percentageChange: priceChangePercentage)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChangePercentage)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray : [StatisticModel] = [
        priceStat,marketCapStat,rankStat,volumeStat
        ]
        
        //Additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let priceChangePercentage2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: priceChangePercentage2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapChangePercentage2)
        
        let blokTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blokTimeString = blokTime == 0 ? "n/a" : "\(blokTime)"
        let blokTimeStat = StatisticModel(title: "Blok Time", value: blokTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray : [StatisticModel] = [
        highStat,lowStat,priceChangeStat,marketCapChangeStat,blokTimeStat,hashingStat
        ]
        
        return (overviewArray,additionalArray)
    }
}
