//
//  MarketDataModel.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 7.09.2022.
//

import Foundation


// JSON RESPONSE 
/*
 
 url : https://api.coingecko.com/api/v3/global
 
 JSON RESPONSE :
 
 {
   "data": {
     "active_cryptocurrencies": 12907,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 567,
     "total_market_cap": {
       "btc": 52767827.45349225,
       "eth": 639071830.8555676,
       "ltc": 17996455199.005966,
       "bch": 8738674700.546688,
       "bnb": 3727216182.7247934,
       "eos": 612208299312.2305,
       "xrp": 3045634946800.414,
       "xlm": 9829114795885.482,
       "link": 144936740444.28595,
       "dot": 139738121920.4785,
       "yfi": 107018353.18392916,
       "usd": 1002236367629.9307,
       "aed": 3681314401941.507,
       "ars": 141122808251962.47,
       "aud": 1482280527342.7456,
       "bdt": 95274097472634.6,
       "bhd": 377866162032.9402,
       "bmd": 1002236367629.9307,
       "brl": 5260336796906.094,
       "cad": 1316394372718.107,
       "chf": 979394398575.2812,
       "clp": 888181868993647.8,
       "cny": 6981678760546.879,
       "czk": 24629915638341.793,
       "dkk": 7455204374924.63,
       "eur": 1002570112340.3527,
       "gbp": 870271905104.1003,
       "hkd": 7867430206349.034,
       "huf": 396617571505185.4,
       "idr": 14921495488547986,
       "ils": 3438041568426.6895,
       "inr": 79840456193518.83,
       "jpy": 144261067563020.22,
       "krw": 1379130194015033.2,
       "kwd": 310034804671.74646,
       "lkr": 360943727694564.6,
       "mmk": 2105507092045234.5,
       "mxn": 20026074731560.684,
       "myr": 4512068127069.957,
       "ngn": 427062938610790.56,
       "nok": 10022774593210.05,
       "nzd": 1652404137329.7178,
       "php": 57155035457252.29,
       "pkr": 225153637749978.3,
       "pln": 4725971426067.744,
       "rub": 61286744860442.9,
       "sar": 3766317074989.3037,
       "sek": 10727813801801.191,
       "sgd": 1408130069683.6448,
       "thb": 36552562563831.266,
       "try": 18267561825517.277,
       "twd": 30933552431332.35,
       "uah": 37021167197643.95,
       "vef": 100353927490.78508,
       "vnd": 23582621730332296,
       "zar": 17307683975728.828,
       "xdr": 743711501072.5261,
       "xag": 54379230588.86433,
       "xau": 583732527.5987008,
       "bits": 52767827453492.25,
       "sats": 5276782745349225
     },
     "total_volume": {
       "btc": 4414190.24804059,
       "eth": 53460314.35625071,
       "ltc": 1505458550.6437047,
       "bch": 731016881.0332427,
       "bnb": 311793039.8143386,
       "eos": 51213097734.13296,
       "xrp": 254776683635.63196,
       "xlm": 822235532003.0847,
       "link": 12124401877.561398,
       "dot": 11689521529.089607,
       "yfi": 8952412.744341623,
       "usd": 83840139223.52367,
       "aed": 307953215381.9255,
       "ars": 11805354778173.414,
       "aud": 123997302227.83281,
       "bdt": 7969969813997.699,
       "bhd": 31609660810.47063,
       "bmd": 83840139223.52367,
       "brl": 440043270888.4477,
       "cad": 110120417744.11182,
       "chf": 81929338610.4807,
       "clp": 74299131379886.94,
       "cny": 584038793844.9897,
       "czk": 2060367816292.112,
       "dkk": 623650660583.7892,
       "eur": 83868057989.8852,
       "gbp": 72800908091.96252,
       "hkd": 658134612887.2605,
       "huf": 33178273596402.613,
       "idr": 1248228760787669.2,
       "ils": 287602698388.1992,
       "inr": 6678898490546.41,
       "jpy": 12067879773330.797,
       "krw": 115368461181484.39,
       "kwd": 25935360187.822548,
       "lkr": 30194047391566.82,
       "mmk": 176132111580259.5,
       "mxn": 1675242435639.3867,
       "myr": 377448306784.30426,
       "ngn": 35725121724535.734,
       "nok": 838435766692.3196,
       "nzd": 138228662820.1904,
       "php": 4781193623409.639,
       "pkr": 18834790819136.562,
       "pln": 395341972338.2242,
       "rub": 5126823758957.214,
       "sar": 315063949109.89014,
       "sek": 897414454071.3335,
       "sgd": 117794389527.38039,
       "thb": 3057733717621.1367,
       "try": 1528137449599.326,
       "twd": 2587686324588.3496,
       "uah": 3096933929276.3486,
       "vef": 8394913140.451434,
       "vnd": 1972758475929514,
       "zar": 1447840730019.9426,
       "xdr": 62213742991.094246,
       "xag": 4548989051.574631,
       "xau": 48831012.28795691,
       "bits": 4414190248040.591,
       "sats": 441419024804059.06
     },
     "market_cap_percentage": {
       "btc": 36.279979136979534,
       "eth": 18.842887523765373,
       "usdt": 6.755770865628592,
       "usdc": 5.173399588685003,
       "bnb": 4.382765117572494,
       "busd": 1.9735950325900582,
       "xrp": 1.632816941028331,
       "ada": 1.591595968107672,
       "sol": 1.122574424906039,
       "dot": 0.8212754233355151
     },
     "market_cap_change_percentage_24h_usd": -0.6007610004970273,
     "updated_at": 1662573793
   }
 }
 
 */

// MARK: - GlobalData
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?
    
    enum CodingKeys: String, CodingKey {
            case totalMarketCap = "total_market_cap"
            case totalVolume = "total_volume"
            case marketCapPercentage = "market_cap_percentage"
            case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        }
    
    var marketCap : String {
        
        // We shorthened the fuction with below
        
//        if let item == totalMarketCap.first(where: { (key,value) -> Bool in
//            return key == "usd"
//        }){
//            return "\(item.value)"
//        }
        
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume : String{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
}
