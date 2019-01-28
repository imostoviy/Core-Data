//
//  Developer+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Developer)
public class Developer: Employee {
    
    //MARK: Get all Developers from database
    
    class func fetchAll() -> [Developer] {
        let context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
        let request: NSFetchRequest<Developer> = fetchRequest()
        var developers: [Developer] = []
        
        do {
            developers = try context.fetch(request)
        } catch {
            debugPrint(error)
        }
        return developers
    }

}
