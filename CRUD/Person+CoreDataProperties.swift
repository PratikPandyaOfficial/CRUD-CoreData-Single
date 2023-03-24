//
//  Person+CoreDataProperties.swift
//  CRUD
//
//  Created by Pratik Pandya on 25/03/23.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64

}

extension Person : Identifiable {

}
