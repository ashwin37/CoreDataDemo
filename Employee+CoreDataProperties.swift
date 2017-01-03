//
//  Employee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Rakesh Viparla on 10/7/16.
//  Copyright © 2016 adroit37. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Employee {

    @NSManaged var name: String?
    @NSManaged var age: String?
    @NSManaged var location: String?

}
