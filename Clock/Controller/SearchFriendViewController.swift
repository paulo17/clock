//
//  SearchFriendViewController.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class SearchFriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    lazy var users = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark: - Function
    
    func searchUser(username: String) {
        UserSynchroniser.getUserByName(username) { (fetchedUsers, error) -> () in
            if error == nil {
                if let users = fetchedUsers {

                    self.users = [PFUser]()
                    self.users += users
                    self.usersTableView.reloadData()
                    
                }
            }
        }
    }
    
    // Mark: - Table View data source & Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UserTableViewCell.identifier, forIndexPath: indexPath) as! UserTableViewCell
        
        cell.usernameLabel.text = users[indexPath.row].username
        
        return cell
    }
    
    // Mark: - Searchbar delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            searchUser(searchText)
        }
    }
    
    // Mark: - Action methods
    
    @IBAction func cancelSearch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
