//
//  Location2+CoreDataProperties.swift
//  Zoodles
//
//  Created by Nancy Wu on 2019-03-23.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Location2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location2> {
        return NSFetchRequest<Location2>(entityName: "Location2")
    }

    @NSManaged public var busID: String?
    @NSManaged public var time: String?
    @NSManaged public var direction: Bool
    @NSManaged public var busRouteID: String?

}
