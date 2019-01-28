//
//  Designer+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Designer)
public class Designer: Employee {
    
    //MARK: geting all data about designers from database

    class func fetchAll() -> [Designer] {
        let context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
        let request: NSFetchRequest<Designer> = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var designers: [Designer] = []
        do {
            designers = try context.fetch(request)
        } catch {
            debugPrint(error)
        }
        return designers
    }
    

}
