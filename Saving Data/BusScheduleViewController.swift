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
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Bus")
        fetchRequest1.predicate = NSPredicate(format: "BusID = %@", "")
        
        //Create Batch Delete Request
       /*let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        
        do {
            try PersistenceService.context.execute(batchDeleteRequest)
    
            
        } catch {
            print(error)
        }*/
        
        let bus = Bus(context: PersistenceService.context)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Bus")
        
        let data = try! PersistenceService.context.fetch(fetchRequest)
        
        
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
        
        // Do any additional setup after loading the view, typically from a nib.
    
}

