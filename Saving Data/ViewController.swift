//
//  ViewController.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-16.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import UIKit
import CoreData
import EventKit
import EventKitUI

class ViewController: UIViewController, EKEventEditViewDelegate , UITableViewDataSource, UITableViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    struct EventOption {
        let event : EKEvent
        var enabled : Bool
        
        init(_ event : EKEvent, _ enabled : Bool) {
            self.event = event
            self.enabled = enabled
        }
    }
    var currentUser = ""
    
    var people = [Person]()
    
    private var datePicker: UIDatePicker?
    
    var dateInterval: NSDate = NSDate(timeIntervalSinceNow: +1*24*3600 + 3600*3600)
    
    lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
        
    }()
    
     let eventStore = EKEventStore()
    
    var eventArray: [EventOption] = [EventOption]()
    
    var selectedEventArray: [EKEvent] = []
    
    @IBOutlet weak var pickDate: UITextField!
    
    @IBAction func nextButton(_ sender: Any) {
        selectedEventArray = []
        for eventName in eventArray {
            if eventName.enabled == true {
                print("before \(eventName.event.title)")
                selectedEventArray.append(eventName.event)
                
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Event")
                fetchRequest.predicate = NSPredicate(format: "userID = %@", currentUser)
                
                //delete all instances with userID
                /*let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try
                        PersistenceService.context.execute(deleteRequest)
                    print("events deleted")
                    //myPersistentStoreCoordinator.executeRequest(deleteRequest, withContext: PersistenceService.context)
                } catch let error as NSError {
                    // TODO: handle the error
                }
                */
                
    
                if !isExist(id: eventName.event.eventIdentifier ?? "") {
                    print("id is \(eventName.event.eventIdentifier)")
                    let event = Event(context: PersistenceService.context)
                    
                    event.eventName = eventName.event.title
                    event.eventID = eventName.event.eventIdentifier
                    event.userID = currentUser
                    event.eventStartTime = eventName.event.startDate as! NSDate
                    event.eventEndTime = eventName.event.endDate as! NSDate
                    PersistenceService.saveContext()
                    print("saved event")
                    
                }
                
                
            }
            /*let selectedEventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectedEvents")
            self.present(selectedEventsViewController!, animated: true, completion: nil)*/
        }
    }
    
    func isExist(id: String) -> Bool {
        print(id)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        fetchRequest.predicate = NSPredicate(format: "eventID = %@",id)
        
        let res = try! PersistenceService.context.fetch(fetchRequest)
        print(res.count)
        return res.count > 0 ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ShowSelectedEventsViewController":
       guard let viewController = segue.destination as? SelectedEventsViewController else { return }
            viewController.eventArray = self.selectedEventArray
            viewController.currentUser = currentUser
            print("array \(selectedEventArray) + \(currentUser) ")
        default: break
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        print("current \(currentUser)")
        self.title = currentUser + "'s Events"
        
        super.viewDidLoad()
        tableView.refreshControl = refreshController
        tableView.delegate = self
        tableView.dataSource = self

        
        let eventStore = EKEventStore()
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            readEvent(store: eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            // 3
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        self!.readEvent(store: eventStore)
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case default")
        }
        
        
        let fetchRequest: NSFetchRequest<Person> =  Person.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        } catch {}
        
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        
        pickDate.inputView = datePicker
    }
    
  
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        
        datePicker.minimumDate = today
        
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        pickDate.text = dateFormatter.string(from: datePicker.date)
        dateInterval = datePicker.date.addingTimeInterval(1*24*3600) as NSDate
        
        
        requestData()
        view.endEditing(true)
    }
    
    
    @objc func requestData() {
        eventArray = []
        
        readEvent(store: eventStore)
        
        tableView.reloadData()
        
        refreshController.endRefreshing()
    }
    
    func readEvent(store: EKEventStore) {
        // 1
        
        
        
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            //if calendar.title == "US Holidays" || calendar.title == "Calendar" {
                let now = NSDate(timeIntervalSinceNow: 0)
                
                let predicate = store.predicateForEvents(withStart: now as Date, end: dateInterval as Date, calendars: [calendar])
                
                var events = store.events(matching: predicate)
        
                for event in events {
                    eventArray.append(EventOption(event, false))
                    print(event.title)
                    //createEvent()
                    //save(event: event)
                    
                    /*newEvent.setValue(event.eventIdentifier, forKey: "eventID")
                     newEvent.setValue(event.startDate, forKey: "password")
                     newEvent.setValue(event.endDate, forKey: "eventStartTime")
                     newEvent.setValue(event.startDate, forKey: "eventEndTime")
                     newEvent.setValue(event.location, forKey: "eventLocation")
                     newEvent.setValue(event.title, forKey: "eventName")
                     newEvent.setValue(currentUserID, forKey: "userID")
                     
                     do {
                     try context.save()
                     } catch {
                     print("Failed saving")
                     }*/
                    
                    //updateDataBase(with: event)
                    //let context: NSManagedObjectContext = AppDelegate.
                    
               // }
            
            /*let startDate = Date()
             // 2 hours
             let endDate = startDate.addingTimeInterval(2 * 60 * 60)
             
             // 4
             let event = EKEvent(eventStore: store)
             event.calendar = calendar
             
             event.title = "New Meeting"
             event.startDate = startDate
             event.endDate = endDate
             
             // 5
             do {
             try store.save(event, span: .thisEvent)
             }
             catch {
             print("Error saving event in calendar")             }*/
            
          
            }
            
            
        }
    }
    func addEvent() {
        
    }


    @IBAction func onPlusTapped() {
        /*let alert = UIAlertController(title: "add person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "age"
            textField.keyboardType = .numberPad
            
        }
        let action = UIAlertAction(title: "post", style: .default) { (_) in
            let name = alert.textFields!.first!.text
            let age = alert.textFields!.last!.text
            
            let person = Person(context: PersistenceService.context)
            person.username = name
            person.password = age
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
            
        }
            
        alert.addAction(action)
            present(alert, animated: true, completion: nil )*/
        
        let event = EKEvent(eventStore: eventStore)
        
        let controller = EKEventEditViewController()
        controller.event = event
        controller.eventStore = eventStore
        
        controller.editViewDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let checkedBoxes = eventArray[(indexPath as NSIndexPath).row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = eventArray[indexPath.row].event.title
        cell.detailTextLabel?.text = eventArray[indexPath.row].event.location
        
        cell.accessoryType = checkedBoxes.enabled ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            print("selected \(indexPath.row )")
            
        }
        
        let index = (indexPath as NSIndexPath).row
        eventArray[index].enabled = !eventArray[index].enabled
        print(eventArray[index].enabled)
        
        
    }
    
}
