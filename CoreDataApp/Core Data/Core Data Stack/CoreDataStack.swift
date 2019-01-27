//
//  CoreDataStack.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/24/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    private(set) lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataApp")
        container.loadPersistentStores(completionHandler: { (persistentStoreDescription, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            debugPrint(persistentStoreDescription)
            container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        })
        return container
    }()
}
