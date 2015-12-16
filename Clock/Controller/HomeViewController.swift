//
//  HomeViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    
    lazy var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventSynchroniser.getUserEvent { (events, error) -> () in
            if let e = events {
                
                self.events += e
                self.eventTableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Tableview Datasource & Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EventTableViewCell.identifier, forIndexPath: indexPath) as! EventTableViewCell
        
        cell.addressLabel.text = events[indexPath.row].address
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let dateString = dateFormatter.stringFromDate(events[indexPath.row].date)
        
        cell.dateLabel.text = dateString
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EventDetail" {
            
            if let indexPath = eventTableView.indexPathForSelectedRow {
                let event = events[indexPath.row]
                let eventDetailViewController = segue.destinationViewController as! EventDetailViewController
                eventDetailViewController.event = event
            }
            
        }
    }
    
}
