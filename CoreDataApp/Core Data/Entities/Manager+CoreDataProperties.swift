//
//  Manager+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/31/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData


extension Manager {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manager> {
        return NSFetchRequest<Manager>(entityName: "Manager")
    }

    @NSManaged public var customer: String?
    @NSManaged public var headForDesigners: NSSet?
    @NSManaged public var headFordevelopers: NSSet?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for headForDesigners
extension Manager {

    @objc(addHeadForDesignersObject:)
    @NSManaged public func addToHeadForDesigners(_ value: Designer)

    @objc(removeHeadForDesignersObject:)
    @NSManaged public func removeFromHeadForDesigners(_ value: Designer)

    @objc(addHeadForDesigners:)
    @NSManaged public func addToHeadForDesigners(_ values: NSSet)

    @objc(removeHeadForDesigners:)
    @NSManaged public func removeFromHeadForDesigners(_ values: NSSet)

}

// MARK: Generated accessors for headFordevelopers
extension Manager {

    @objc(addHeadFordevelopersObject:)
    @NSManaged public func addToHeadFordevelopers(_ value: Developer)

    @objc(removeHeadFordevelopersObject:)
    @NSManaged public func removeFromHeadFordevelopers(_ value: Developer)

    @objc(addHeadFordevelopers:)
    @NSManaged public func addToHeadFordevelopers(_ values: NSSet)

    @objc(removeHeadFordevelopers:)
    @NSManaged public func removeFromHeadFordevelopers(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension Manager {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
