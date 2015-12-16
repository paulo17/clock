//
//  EventFriendViewController.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class EventFriendViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SearchFriendDelegate {
    
    @IBOutlet weak var friendCollection: UICollectionView!
    
    var name: String!
    var date: NSDate!
    var address: String!
    var coordonate: (lat: Double, long: Double)!
    var loose: String!
    
    lazy var users = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getFriends(value: [PFUser], sender: AnyObject) {
        users += value
        friendCollection.reloadData()
    }
    
    // MARK: - Action methods

    @IBAction func addEvent(sender: AnyObject) {
        
        if let address = self.address, let location = self.coordonate {
            
            let event = Event(name: name, date: date, address: address, lat: location.lat, long: location.long, loose: loose)
            
            let PFEvent = EventSynchroniser.saveObject(event)
            event.PFobject = PFEvent
            
            let guests = Guest.instanciateGuests(PFEvent, users: self.users)
            GuestSynchroniser.saveObjects(guests)
            
            // redirect to home view controller
            if let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeViewNav") {
                redirect(from: self, to: homeViewController)
            }
        }
    }
    
    // MARK: - CollectionView DataSource & Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FriendCollectionViewCell.identifier, forIndexPath: indexPath) as! FriendCollectionViewCell
        
        let user = users[indexPath.row]
    
        var shortName = "\(indexPath.row)" // TODO: use username
        
        if let firstname = user["firstname"] as? String, let lastname = user["lastname"] as? String {
            shortName = "\(firstname.characters.first)\(lastname.characters.first)"
        }
    
        cell.shortNameLabel.text = shortName
        cell.viewWrapper.layer.cornerRadius = 30
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchFriend" {
            let searchFriendViewController = segue.destinationViewController as! SearchFriendViewController
            searchFriendViewController.delegate = self
        }
    }
}
