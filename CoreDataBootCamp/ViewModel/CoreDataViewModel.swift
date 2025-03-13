//
//  CoreDataViewModel.swift
//  CoreDataBootCamp
//
//  Created by Gina Saviano on 13/03/25.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    //here we create the container of the type NSPersistentContainer
    let persistentContainer: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = [] //where we're gonna save our fetch
    
    init() {
        persistentContainer = NSPersistentContainer(name: "FruitsContainer") ///here we are creating the instantiation for the container. BE CAREFUL!: the name handler MUST have the same name of the file `nameOfTheFile.xcdatamodeld`
        ///On the code above, we are:
        ///1. - loading all the contents inside the persistent container (so the Core Data stack)
        ///2. - we are handling errors. If there's an error connected to the loading of CoreData, this will give us the information we need to handle it
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print ("ERROR LOADING CORE DATA: \(error), \(description)")
            } else {
                print("Core Data loaded successfully!")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits () {
        let request = NSFetchRequest <FruitEntity> (entityName: "FruitEntity")
        
        do { //viewContext is what we have inside the container. Everything.
            savedEntities = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print ("Error fetching the data: \(error)")
        }
    }
    
    func addFruit(nameText: String) {
        let newFruit = FruitEntity(context: persistentContainer.viewContext)
        
        newFruit.name = nameText
        
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let entity = savedEntities[index]
        persistentContainer.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        
        do {
            try persistentContainer.viewContext.save()
            fetchFruits() //to save the data inside the variable
        } catch let error {
            print ("Error saving data: \(error)")
        }
        
    }
}

