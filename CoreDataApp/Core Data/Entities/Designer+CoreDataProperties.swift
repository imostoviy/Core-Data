//
//  Designer+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/31/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData


extension Designer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Designer> {
        return NSFetchRequest<Designer>(entityName: "Designer")
    }

    @NSManaged public var boss: Manager?
    @NSManaged public var mainTask: NSSet?

}

// MARK: Generated accessors for mainTask
extension Designer {

    @objc(addMainTaskObject:)
    @NSManaged public func addToMainTask(_ value: Task)

    @objc(removeMainTaskObject:)
    @NSManaged public func removeFromMainTask(_ value: Task)

    @objc(addMainTask:)
    @NSManaged public func addToMainTask(_ values: NSSet)

    @objc(removeMainTask:)
    @NSManaged public func removeFromMainTask(_ values: NSSet)

}
