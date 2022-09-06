//
//  HomeViewModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 5.09.2022.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        
        addSubscribers()
        
    }
    
    func addSubscribers(){
        
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
    
}
