//
//  CoinModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 4.09.2022.
//

import Foundation

// CoinGecko API
/*
 
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 
 JSON RESPONSE
 
 {
     "id": "mx-token",
     "symbol": "mx",
     "name": "MX",
     "image": "https://assets.coingecko.com/coins/images/8545/large/TII1YIdv_400x400.png?1559180170",
     "current_price": 0.976303,
     "market_cap": 97594830,
     "market_cap_rank": 252,
     "fully_diluted_valuation": null,
     "total_volume": 86860,
     "high_24h": 0.991309,
     "low_24h": 0.973521,
     "price_change_24h": -0.01093874139827744,
     "price_change_percentage_24h": -1.10801,
     "market_cap_change_24h": -1278078.1231650114,
     "market_cap_change_percentage_24h": -1.29265,
     "circulating_supply": 99999999.9997,
     "total_supply": 443857130,
     "max_supply": null,
     "ath": 3.7,
     "ath_change_percentage": -73.61591,
     "ath_date": "2021-12-02T00:59:40.216Z",
     "atl": 0.04218457,
     "atl_change_percentage": 2213.51957,
     "atl_date": "2019-11-25T05:59:45.392Z",
     "roi": null,
     "last_updated": "2022-09-04T18:44:43.168Z",
     "sparkline_in_7d": {
       "price": [
         1.0023048131742045,
         1.0009237235657897,
       ]
     },
     "price_change_percentage_24h_in_currency": -1.1080101689290736
   }
 
 */

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct CoinModel : Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings : Double?
    
    
    enum CodingKeys: String, CodingKey {
            case id, symbol, name, image
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case marketCapChange24H = "market_cap_change_24h"
            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
            case circulatingSupply = "circulating_supply"
            case totalSupply = "total_supply"
            case maxSupply = "max_supply"
            case ath
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case atl
            case atlChangePercentage = "atl_change_percentage"
            case atlDate = "atl_date"
            case lastUpdated = "last_updated"
            case sparklineIn7D = "sparkline_in_7d"
            case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
            case currentHoldings
        }
    
    func updateHolding(amount:Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChange24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: athChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank : Int{
        return Int(marketCapRank ?? 0)
    }
    
}

// MARK: - SparklineIn7D
struct SparklineIn7D : Codable {
    let price: [Double]?
}
