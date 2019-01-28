//
//  Task+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/24/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    class func fetchAll() -> [Task] {
        let context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
        let request: NSFetchRequest = fetchRequest()
        var tasks: [Task] = []
        
        do {
            tasks = try context.fetch(request)
        } catch {
            debugPrint(error)
        }
        return tasks
    }

}
