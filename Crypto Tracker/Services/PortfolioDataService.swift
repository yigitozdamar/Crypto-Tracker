//
//  PortfolioDataService.swift
//  Crypto Tracker
//
//  Created by Yigit Ozdamar on 9.09.2022.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data Error Occured. \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
        
    }
    
    //MARK: Public
    
    func updatePortfolio(coin:CoinModel, amount :Double) {
        
        //check if coin is in already portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: Private
    private func getPortfolio(){
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        
        do {
            try savedEntities = container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching entities. \(error.localizedDescription)")
        }
    }
    
    private func add(coin:CoinModel, amount:Double){
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity:PortfolioEntity,amount : Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
}
