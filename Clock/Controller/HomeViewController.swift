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
                
                // TODO: Refresh data in table view
                print(self.events.count)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func userLogout(sender: AnyObject) {
        PFUser.logOut()
        if let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") {
            loginView.modalTransitionStyle = .FlipHorizontal
            presentViewController(loginView, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EventTableViewCell.identifier, forIndexPath: indexPath) as! EventTableViewCell
        
        return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
