//
//  Location3+CoreDataProperties.swift
//  Zoodles
//
//  Created by Nancy Wu on 2019-03-23.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Location3 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location3> {
        return NSFetchRequest<Location3>(entityName: "Location3")
    }

    @NSManaged public var busID: String?
    @NSManaged public var time: String?
    @NSManaged public var direction: Bool
    @NSManaged public var busRouteID: String?

}
