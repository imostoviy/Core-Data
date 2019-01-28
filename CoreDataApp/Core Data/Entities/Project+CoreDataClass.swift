//
//  Project+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/24/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {
    
    //MARK: Getting data about projects
    
    class func fetchAll() -> [Project] {
        let context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
        let request: NSFetchRequest<Project> = fetchRequest()
        var projects: [Project] = []
        
        do {
            projects = try context.fetch(request)
        } catch {
            debugPrint(request)
        }
        return projects
    }
}
