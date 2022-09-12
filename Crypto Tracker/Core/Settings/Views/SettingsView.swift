//
//  SettingsView.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 12.09.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    let defaultUrl = URL(string: "https://www.google.com")!
    let linkedInUrl = URL(string: "https://www.linkedin.com/in/yigitozdamar129/")!
    let twitterUrl = URL(string: "https://twitter.com/yozdamar129")!
    let coingeckoUrl = URL(string: "https://www.coingecko.com")!
    let personelUrl = URL(string: "https://www.yigitozdamar.com")!
    
    var body: some View {
        NavigationView {
            List{
                cryptoTrackerSection
                coingeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .tint(Color.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(iconName: "xmark",dismiss: _dismiss)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var cryptoTrackerSection : some View {
        Section {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                Text("This App was made by Yigit Ozdamar. It uses MVVM Architecture, Combine and Core Data!")
                    .foregroundColor(Color.theme.accentColor)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link("Subscribe on Twitter", destination: twitterUrl)
            Link("Add to LinkedIn friends🥳", destination: linkedInUrl)
        } header: {
            Text("Crypto Tracker")
        }
    }
    
    private var coingeckoSection : some View {
        Section {
            VStack(alignment:.leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                Text("TThe cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .foregroundColor(Color.theme.accentColor)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link("Visit CoinGecko🥳", destination: coingeckoUrl)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection : some View {
        Section {
            VStack(alignment:.leading){
                Image("yigit")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                Text("This app was devoped by Yigit OZDAMAR. It uses SwiftUI and is written %100 in Swift. The project benefits from multi-threading, publishers/subscribers and data persistance. ")
                    .foregroundColor(Color.theme.accentColor)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link("Visit Yigit's Webpage🥳", destination: personelUrl)
        } header: {
            Text("Yigit Ozdamar")
        }
    }
    
    private var applicationSection : some View {
        Section {
            Link("Privacy Policy", destination: defaultUrl)
            Link("Terms of Service", destination: defaultUrl)
            Link("Company Website", destination: defaultUrl)
            Link("Learn More", destination: defaultUrl)
        } header: {
            Text("Application")
        }
    }
}
