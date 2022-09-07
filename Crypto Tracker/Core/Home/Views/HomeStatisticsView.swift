//
//  HomeStatisticsView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 7.09.2022.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @EnvironmentObject var vm : HomeViewModel
    
    @Binding var showPortfolio : Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticsView(showPortfolio: .constant(true))
            .environmentObject(dev.homeVM)
    }
}
