//
//  BusScheduleViewController.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-17.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import EventKit

class BusScheduleViewController: UIViewController {
    
    
    let busIDs: [String] = ["200","202","7","8","12","92"]
    
    let busNames: [String] = ["iXpress", "University", "Mainland", "University/Fairview", "Westmount", "University Loop"]
    
    let locationABusses: [String] = ["12", "8", "12", "8","12", "8", "202", "12","8", "12", "202", "8", "12", "8", "202","12", "8", "12", "8", "12", "202", "8", "12", "8","12", "8", "12", "202","8", "12", "8", "12","8", "12", "8", "202","12", "8", "12", "8", "202", "12", "8", "12", "8", "12", "202", "8", "12", "202","202","12", "8", "12", "8", "202", "12", "8", "12", "202"]
    let locationBBusses: [String] = ["12", "8", "12", "8","12", "8", "202", "12","8", "12", "202", "8", "12", "8", "202","12", "8", "12", "8", "12", "202", "8", "12", "8","12", "8", "12", "202","8", "12", "8", "12","8", "12", "8", "202","12", "8", "12", "8", "202", "12", "8", "12", "8", "12", "202", "8", "12", "202","202","12", "8", "12", "8", "202", "12", "8", "12", "202"]
    let locationCBusses: [String] = ["12", "8", "12", "8","12", "8", "202", "12","8", "12", "202", "8", "12", "8", "202","12", "8", "12", "8", "12", "202", "8", "12", "8","12", "8", "12", "202","8", "12", "8", "12","8", "12", "8", "202","12", "8", "12", "8", "202", "12", "8", "12", "8", "12", "202", "8", "12", "202","202","12", "8", "12", "8", "202", "12", "8", "12", "202"]
    let locationDBusses: [String] = ["12", "8", "12", "8","12", "8", "202", "12","8", "12", "202", "8", "12", "8", "202","12", "8", "12", "8", "12", "202", "8", "12", "8","12", "8", "12", "202","8", "12", "8", "12","8", "12", "8", "202","12", "8", "12", "8", "202", "12", "8", "12", "8", "12", "202", "8", "12", "202","202","12", "8", "12", "8", "202", "12", "8", "12", "202"]
    
    let locationABusRouteID: [String] = ["12a", "8a", "12b", "8b","12c", "8c", "202a", "12d","8d", "12e", "202", "8e", "12f", "8f", "202b","12g", "8g", "12h", "8h", "12i", "202c", "8i", "12j", "8j","12k", "8k", "12l", "202d","8l", "12m", "8a", "12a","8b", "12b", "8c", "202a","12c", "8d", "12d", "8e", "202b", "12e", "8f", "12f", "8g", "12g", "202c", "8h", "12h", "202d","202e","12i", "8i", "12j", "8j", "202f", "12k", "8k", "12l", "202g"]
    let locationBBusRouteID: [String] = ["12a", "8a", "12b", "8b","12c", "8c", "202a", "12d","8d", "12e", "202", "8e", "12f", "8f", "202b","12g", "8g", "12h", "8h", "12i", "202c", "8i", "12j", "8j","12k", "8k", "12l", "202d","8l", "12m", "8a", "12a","8b", "12b", "8c", "202a","12c", "8d", "12d", "8e", "202b", "12e", "8f", "12f", "8g", "12g", "202c", "8h", "12h", "202d","202e","12i", "8i", "12j", "8j", "202f", "12k", "8k", "12l", "202g"]
    let locationCBusRouteID: [String] = ["12a", "8a", "12b", "8b","12c", "8c", "202a", "12d","8d", "12e", "202", "8e", "12f", "8f", "202b","12g", "8g", "12h", "8h", "12i", "202c", "8i", "12j", "8j","12k", "8k", "12l", "202d","8l", "12m", "8a", "12a","8b", "12b", "8c", "202a","12c", "8d", "12d", "8e", "202b", "12e", "8f", "12f", "8g", "12g", "202c", "8h", "12h", "202d","202e","12i", "8i", "12j", "8j", "202f", "12k", "8k", "12l", "202g"]
    let locationDBusRouteID: [String] = ["12a", "8a", "12b", "8b","12c", "8c", "202a", "12d","8d", "12e", "202", "8e", "12f", "8f", "202b","12g", "8g", "12h", "8h", "12i", "202c", "8i", "12j", "8j","12k", "8k", "12l", "202d","8l", "12m", "8a", "12a","8b", "12b", "8c", "202a","12c", "8d", "12d", "8e", "202b", "12e", "8f", "12f", "8g", "12g", "202c", "8h", "12h", "202d","202e","12i", "8i", "12j", "8j", "202f", "12k", "8k", "12l", "202g"]
    
    
    let locationADirection: [Bool] = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    let locationBDirection: [Bool] = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    let locationCDirection: [Bool] = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    let locationDDirection: [Bool] = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    let locationATimes: [String] = ["6:00", "7:00", "7:30", "7:45", "8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30", "9:45", "10:00", "10:15", "10:30", "11:00", "11:30", "11:45", "12:00", "12:15", "12:30", "13:00", "13:30", "14:00", "15:00", "15:30", "16:00", "17:00", "18:00", "19:00", "6:00", "7:00", "7:30", "7:45", "8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30", "9:45", "10:00", "10:15", "10:30", "11:00", "11:30", "11:45", "12:00", "12:15", "12:30", "13:00", "13:30", "14:00", "15:00", "15:30", "16:00", "17:00", "18:00", "19:00"]
    
    let locationBTimes: [String] = ["6:05", "7:05", "7:35", "7:50", "8:05", "8:15", "8:35", "8:50", "9:05", "9:20", "9:35", "9:50", "10:05", "10:20", "10:35", "11:05", "11:35", "11:50", "12:05", "12:20", "12:35", "13:05", "13:35", "14:05", "15:05", "15:35", "16:05", "17:05", "18:05", "19:05", "5:55", "6:55", "7:25", "7:40", "7:55", "8:05", "8:25", "8:40", "8:55", "9:05", "9:25", "9:40", "9:55", "10:05", "10:25", "10:55", "11:25", "11:40", "11:55", "12:05", "12:25", "12:55", "13:25", "13:55", "14:55", "15:25", "15:55", "16:55", "17:55", "18:55"]
    
    let locationCTimes: [String] = ["6:10", "7:10", "7:40", "7:55", "8:10", "8:20", "8:40", "8:55", "9:10", "9:25", "9:40", "9:55", "10:10", "10:25", "10:40", "11:10", "11:40", "11:55", "12:10", "12:25", "12:40", "13:10", "13:40", "14:10", "15:10", "15:40", "16:10", "17:10", "18:10", "19:10", "5:50", "6:50", "7:20", "7:35", "7:50", "8:00", "8:20", "8:35", "8:50", "9:00", "9:20", "9:35", "9:50", "10:00", "10:20", "10:50", "11:20", "11:35", "11:50", "12:00", "12:20", "12:50", "13:20", "13:50", "14:50", "15:20", "15:50", "16:50", "17:50", "18:50"]
    
    let locationDTimes: [String] = ["6:15", "7:15", "7:45", "8:00", "8:15", "8:25", "8:45", "9:00", "9:15", "9:30", "9:45", "10:00", "10:15", "10:30", "10:45", "11:15", "11:45", "12:00", "12:15", "12:30", "12:45", "13:15", "13:45", "14:15", "15:15", "15:45", "16:15", "17:15", "18:15", "19:15", "5:45", "6:45", "7:15", "7:30", "7:45", "7:55", "8:15", "8:30", "8:45", "8:55", "9:15", "9:30", "9:45", "9:55", "10:15", "10:45", "11:15", "11:30", "11:45", "11:55", "12:15", "12:45", "13:15", "13:45", "14:45", "15:15", "15:45", "16:45", "17:45", "18:45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Location1")
        //fetchRequest1.predicate = NSPredicate(format: "BusID = %@", "")
        
        //Create Batch Delete Request
       let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        
        do {
            try PersistenceService.context.execute(batchDeleteRequest)
    
            
        } catch {
            print(error)
        }*/
        let l1 = Location1(context: PersistenceService.context)
        let fetchLocationRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Location4")
        
        let data1 = try! PersistenceService.context.fetch(fetchLocationRequest1)
        
        print(data1.count)
        
        if data1.count == 0 {
            //insert into db
            for i in 0..<locationABusses.count {
                let busRoute = Location4(context: PersistenceService.context)
                busRoute.busID = locationDBusses[i]
                busRoute.busRouteID = locationDBusRouteID[i]
                busRoute.direction = locationDDirection[i]
                busRoute.time = locationDTimes[i]
                print(locationCBusRouteID[i])
                PersistenceService.saveContext()
            }
            
        } else {
            print("none")
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Location2")
            
            //let res = try! PersistenceService.context.fetch(fetchRequest)
            
            do {
                let result = try PersistenceService.context.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "Location1"))
                }
                
            } catch {
                
                print("Failed")
            }
        }
        
        let bus = Bus(context: PersistenceService.context)
        let fetchRequesta: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Bus")
        
        let data = try! PersistenceService.context.fetch(fetchRequesta)
        
        
        if data.count == 0 {
            //insert into db
            for i in 0..<busIDs.count {
                let busRoute = Bus(context: PersistenceService.context)
                busRoute.busID = busIDs[i]
                busRoute.busName = busNames[i]
                print("\(busNames[i])")
                PersistenceService.saveContext()
            }
            
        } else {
            print("none")
             let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Bus")
            
            //let res = try! PersistenceService.context.fetch(fetchRequest)
            
            do {
                let result = try PersistenceService.context.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "BusID"))
                }
                
            } catch {
                
                print("Failed")
            }
        }
    }
}

