//
//  BusSchedule+CoreDataProperties.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-17.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension BusSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusSchedule> {
        return NSFetchRequest<BusSchedule>(entityName: "BusSchedule")
    }

    @NSManaged public var busID: String?
    @NSManaged public var eventLocation: String?
    @NSManaged public var arrivalTime: String?
    @NSManaged public var newRelationship: Bus?

}
