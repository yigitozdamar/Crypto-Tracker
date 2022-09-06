//
//  CoinImageService.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 6.09.2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image : UIImage? = nil
    
    private var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    
    init(coin:CoinModel) {
        self.coin = coin
        getCoinImage(urlString: coin.image)
    }
    
    private func getCoinImage(urlString : String){
        
        guard let url = URL(string:coin.image) else { return  }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
    
}
