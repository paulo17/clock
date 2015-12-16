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
    lazy var friends = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
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
    
    // Mark: - Searchbar delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            searchUser(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // todo send back friends array to event friend
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
