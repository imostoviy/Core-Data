//
//  Employee+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/24/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject {
    
    var fullName: String {
        get { return [name, surname].compactMap({ $0 }).joined(separator: " ") }
    }

}
