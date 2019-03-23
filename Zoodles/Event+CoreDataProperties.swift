//
//  Event+CoreDataProperties.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-16.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventName: String?
    @NSManaged public var eventStartTime: NSDate?
    @NSManaged public var eventEndTime: NSDate?
    @NSManaged public var userID: String?
    @NSManaged public var eventLocation: String?
    @NSManaged public var eventID: String?

}
