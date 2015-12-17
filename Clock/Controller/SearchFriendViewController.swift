//
//  SearchFriendViewController.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

protocol SearchFriendDelegate: class {
    func getFriends(value: [PFUser], sender: AnyObject)
}

class SearchFriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    lazy var users = [PFUser]()
    lazy var friends = [PFUser]()
    
    weak var delegate: SearchFriendDelegate?
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        
        // fetch all user by default
        UserSynchroniser.getAllUser { (users, error) -> Void in
            if error == nil {
                if let users = users {
                    self.refreshUsersData(users: users)
                }
            }
        }
    }
    
    // MARK: - Function
    
    func searchUser(username: String) {
        UserSynchroniser.getUserByName(username) { (fetchedUsers, error) -> () in
            if error == nil {
                if let users = fetchedUsers {
                    self.refreshUsersData(users: users)
                }
            }
        }
    }
    
    func refreshUsersData(users fetchedUser: [PFUser]) {
        self.users = [PFUser]()
        self.users += fetchedUser
        self.usersTableView.reloadData()
    }
    
    // MARK: - Table View data source & Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UserTableViewCell.identifier, forIndexPath: indexPath) as! UserTableViewCell
        
        cell.usernameLabel.text = users[indexPath.row].username
        cell.accessoryType = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        cell.toggleAccessor()
        
        if !friends.contains(user) {
            friends.append(user)
        } else {
            friends.removeObject(user)
        }
    }
    
    // MARK: - Searchbar delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            searchUser(searchText)
        }
    }
    
    // MARK: - Action methods
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func validateAction(sender: AnyObject) {
        delegate?.getFriends(self.friends, sender: sender)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
