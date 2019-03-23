//
//  Location4+CoreDataProperties.swift
//  Zoodles
//
//  Created by Nancy Wu on 2019-03-23.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Location4 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location4> {
        return NSFetchRequest<Location4>(entityName: "Location4")
    }

    @NSManaged public var busID: String?
    @NSManaged public var time: String?
    @NSManaged public var direction: Bool
    @NSManaged public var busRouteID: String?

}
