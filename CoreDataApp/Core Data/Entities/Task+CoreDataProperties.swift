//
//  Task+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var status: String?
    @NSManaged public var taskName: String?
    @NSManaged public var project: Project?
    @NSManaged public var manager: Manager?
    @NSManaged public var developers: NSSet?
    @NSManaged public var designers: NSSet?

}

// MARK: Generated accessors for developers
extension Task {

    @objc(addDevelopersObject:)
    @NSManaged public func addToDevelopers(_ value: Developer)

    @objc(removeDevelopersObject:)
    @NSManaged public func removeFromDevelopers(_ value: Developer)

    @objc(addDevelopers:)
    @NSManaged public func addToDevelopers(_ values: NSSet)

    @objc(removeDevelopers:)
    @NSManaged public func removeFromDevelopers(_ values: NSSet)

}

// MARK: Generated accessors for designers
extension Task {

    @objc(addDesignersObject:)
    @NSManaged public func addToDesigners(_ value: Designer)

    @objc(removeDesignersObject:)
    @NSManaged public func removeFromDesigners(_ value: Designer)

    @objc(addDesigners:)
    @NSManaged public func addToDesigners(_ values: NSSet)

    @objc(removeDesigners:)
    @NSManaged public func removeFromDesigners(_ values: NSSet)

}
