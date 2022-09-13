//
//  LaunchView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 13.09.2022.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var launchText : [String] = "Loading your portfolio....".map{ String($0)}
    @State private var showLaunchText : Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var counter : Int = 0
    @State private var loops : Int = 0
    @Binding var showLaunchView : Bool
    
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack{
                if showLaunchText{
//                    Text(launchText)
//                        .font(.headline)
//                        .fontWeight(.heavy)
//                        .foregroundColor(Color.launch.accent)
//                        .transition(AnyTransition.scale.animation(.easeInOut))
                    HStack(spacing:0){
                        ForEach(launchText.indices) { index in
                            Text(launchText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    
                }
          
            }
            .offset(y:70)
        }
        .onAppear{
            showLaunchText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                
                let lastIndex = launchText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                }else{
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView( showLaunchView: .constant(true))
    }
}
