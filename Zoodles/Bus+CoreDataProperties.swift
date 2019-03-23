//
//  Bus+CoreDataProperties.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-17.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Bus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bus> {
        return NSFetchRequest<Bus>(entityName: "Bus")
    }

    @NSManaged public var busID: String?
    @NSManaged public var busName: String?
    @NSManaged public var newRelationship: NSSet?

}

// MARK: Generated accessors for newRelationship
extension Bus {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: BusSchedule)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: BusSchedule)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}
