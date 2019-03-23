//
//  CalendarViewController.swift
//  Zoodles
//
//  Created by Nancy Wu on 2019-03-19.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import EventKitUI
import JTAppleCalendar
import CoreData

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var eventArray: [EKEvent] = []
    
    var selectedDateEventArray: [EKEvent] = []
    
    var currentUser = ""
    
    let formatter = DateFormatter()
    let todaysDate = Date()
    var selectedDateString = ""
    

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    
    override func viewDidLoad() {
        
        selectedDateString = formatter.string(from: todaysDate)
        
        self.title = currentUser + "'s Selected Events"
        
        /*for event in eventArray {
            
            formatter.dateFormat = "yyyy MM dd"
            
            let eventsDateString = formatter.string(from: event.startDate)
            print(eventsDateString)
            
            if eventsDateString == formatter.string(from: todaysDate){
                selectedDateEventArray.append(event)
                
            }
        }*/
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        calendarView.scrollToDate(Date())
        calendarView.selectDates([Date()])
        setUpCalendarView()
        
        
        

        // Do any additional setup after loading the view.
    }
    func setUpCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //set labels
        calendarView.visibleDates { (visibleDates) in
            self.setUpViewsFromCalendar(from: visibleDates)
        }
        
    }
    
    func setUpViewsFromCalendar(from visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }
        formatter.dateFormat = "MMM"
        month.text = formatter.string(from: date)
            
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
    }
    
    
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
       
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
       

        if todaysDateString == monthDateString {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.black
            } else {
                validCell.dateLabel.textColor = UIColor.gray
            }
        }
    }
    
    func handleCellTextSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else  { return }
        
        let todaysDate = Date()
        if cellState.isSelected  {
            
            selectedDateString = formatter.string(from: cellState.date)
            
            for event in eventArray {
                formatter.dateFormat = "yyyy MM dd"
                
                let eventsDateString = formatter.string(from: event.startDate)
                print(eventsDateString)
                
                if eventsDateString == selectedDateString {
                    selectedDateEventArray.append(event)
                }
            }
            tableView.reloadData()
            
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
       
        
        /*let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Event")
        
        let predicateUser = NSPredicate(format: "userID = %@", currentUser)
        let predicateCurrentDate = NSPredicate(format: "eventStartTime = %@", todaysDate as NSDate)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateUser, predicateCurrentDate])
        
        fetchRequest.predicate = andPredicate
        
        var results = try! PersistenceService.context.fetch(fetchRequest) as! [NSManagedObject]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        print(results)
        
        for result in results {
           
            print(result.value(forKey: "eventName"))
                cell.textLabel?.text = result.value(forKey: "eventName") as! String
            cell.detailTextLabel?.text = result.value(forKey: "eventLocation") as! String
            
            
            
            result.value(forKey: "eventName")
        }*/
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        if indexPath.row < selectedDateEventArray.count {
        
        let startTimeString = dateFormatterPrint.string(from: selectedDateEventArray[indexPath.row].startDate)
        let endTimeString = dateFormatterPrint.string(from: selectedDateEventArray[indexPath.row].endDate)
            
            
        if indexPath.row == 0 {
            
                
        } else {
            
            
            let nextEventStart = (from: selectedDateEventArray[indexPath.row].startDate)
        }
        print(indexPath.row)
        

        print(selectedDateEventArray)
        
            cell.textLabel?.text = selectedDateEventArray[indexPath.row].title! + "Bus: "
            cell.detailTextLabel?.text = eventArray[indexPath.row].location! + " Time \(startTimeString) - \(endTimeString)"
        }
        
        
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 03 15")!
        let endDate = formatter.date(from: "2021 01 31")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        return parameters
        
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    //display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        sharedFunctionToConfigureCell(myCustomCell: cell, cellState: cellState, date: date)
        cell.dateLabel?.text =  cellState.text
        

        

        
        handleCellTextSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
        
    }

    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedDateEventArray = []
        handleCellTextSelected(view: cell, cellState: cellState)
        //handleCellTextColor(view: cell, cellState: cellState)
        

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedDateEventArray = []
        handleCellTextSelected(view: cell, cellState: cellState)
        //handleCellTextColor(view: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setUpViewsFromCalendar(from: visibleDates)
        
    }
    
}

