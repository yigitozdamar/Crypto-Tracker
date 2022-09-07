//
//  HomeViewModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 5.09.2022.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics : [StatisticModel] = [
        StatisticModel(title: "Title1", value: "Value"),
        StatisticModel(title: "Title2", value: "value2", percentageChange: 1),
        StatisticModel(title: "Title3", value: "value3"),
        StatisticModel(title: "Title4", value: "value4", percentageChange: -7)
        ]
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    @Published var searchText : String = ""
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        
        addSubscribers()
        
    }
    
    func addSubscribers(){
        
        // After searchtext updates, we don't need that.Because allcoins already updates at searchtext
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellable)
        
        
        //update allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
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
    
}
