//
//  Manager+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Manager)
public class Manager: Employee {
    
    //MARK: Geting all data about managers from database
    
    class func fetchAll() -> [Manager] {
        let context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
        let request: NSFetchRequest<Manager> = fetchRequest()
        var managers: [Manager] = []
        
        do {
            managers = try context.fetch(request)
        } catch {
            debugPrint(error)
        }
        return managers
    }

}
