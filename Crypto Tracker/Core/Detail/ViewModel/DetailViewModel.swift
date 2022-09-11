//
//  DetailViewModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 11.09.2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService : CoinDetailDataService
    private var canccellables = Set<AnyCancellable>()
    
    init(coin :CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        coinDetailDataService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("RECIEVED: \(returnedCoinDetails)")
            }
            .store(in: &canccellables)
        
    }
}
