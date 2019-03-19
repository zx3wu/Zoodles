//
//  SelectedEventsViewController.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-16.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import EventKitUI

class SelectedEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var eventArray: [EKEvent] = []
    
    var currentUser = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.title = currentUser + "'s Selected Events"
        
        print(eventArray)

       
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = eventArray[indexPath.row].title! + "  \(eventArray[indexPath.row].startDate!) - \(eventArray[indexPath.row].endDate!)"
        cell.detailTextLabel?.text = eventArray[indexPath.row].location
        
        
        
        return cell
    }
    
}

