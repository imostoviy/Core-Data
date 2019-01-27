//
//  Employee+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var xp: Int32

}
