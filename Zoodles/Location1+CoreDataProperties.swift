//
//  Location1+CoreDataProperties.swift
//  Zoodles
//
//  Created by Nancy Wu on 2019-03-23.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Location1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location1> {
        return NSFetchRequest<Location1>(entityName: "Location1")
    }

    @NSManaged public var busRouteID: String?
    @NSManaged public var busID: String?
    @NSManaged public var time: String?
    @NSManaged public var direction: Bool

}
