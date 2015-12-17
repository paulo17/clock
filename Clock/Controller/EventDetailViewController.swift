//
//  EventDetailViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse
import AFDateHelper
import CoreLocation

class EventDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var looseLabel: UILabel!
    @IBOutlet weak var completeDate: UILabel!
    
    @IBOutlet weak var friendCollection: UICollectionView!
    @IBOutlet weak var checkinButton: UIButton!
    
    var event: Event! {
        didSet {
            if let name = event.name {
                navigationItem.title = name.capitalizedString
            } else {
                navigationItem.title = "Evenement sans nom"
            }
        }
    }
    
    lazy var users = [PFUser]()
    lazy var userCoordonnate = CLLocationCoordinate2D()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // set date label
        dateLabel.text = event.date.toString(format: .Custom("HH:mm"))
        addressLabel.text = event.address
        completeDate.text = event.date.toString(format: .ISO8601(ISO8601Format.Date))
        checkinButton.layer.cornerRadius = 5
        looseLabel.text = event.loose
        
        // get guests list
        getGuests()
        
        // check user checkin
        checkCheckin { (status) -> Void in
            if status {
                self.checkinButton.enabled = false
                self.checkinButton.backgroundColor = UIColorFromRGBA("ffffff", alpha: 0.5)
            } else {
                self.checkinButton.enabled = true
                self.checkinButton.backgroundColor = UIColorFromRGBA("ffffff", alpha: 1)
            }
        }
    }
    
    // MARK: - CoreLocation
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        self.userCoordonnate = userLocation.coordinate
    }
    
    // MARK: - Functions
    
    func getGuests() {
        
        if let PFEvent = event.PFobject {
            
            GuestSynchroniser.getGuestsByEvent(PFEvent) { (fetchedUsers, error) -> Void in
                if error == nil {
                    if let users = fetchedUsers {
                        
                        for user in users {
                            user.fetchIfNeededInBackgroundWithBlock({ (pfuser, error) -> Void in
                                if pfuser != nil {
                                    self.users.append(user)
                                    self.friendCollection.reloadData()
                                }
                            })
                        }
                        
                    }
                }
            }
            
        }
    }
    
    func checkCheckin(completionHandler: (status: Bool) -> Void) {
        if let currentUser = PFUser.currentUser() {
            
            if let PFEvent = event.PFobject {
                
                CheckinSynchroniser.getUserEventCheckin(currentUser, event: PFEvent, completionHandler: { (checkin, error) -> Void in
                    if checkin == nil {
                        completionHandler(status: false)
                    } else {
                        completionHandler(status: true)
                    }
                })
                
            }
        }
    }
    
    // MARK: - Action methods
    
    @IBAction func checkinAction(sender: AnyObject) {
        
        if let currentUser = PFUser.currentUser() {
            
            if let PFEvent = event.PFobject {
                
                CheckinSynchroniser.getUserEventCheckin(currentUser, event: PFEvent, completionHandler: { (checkin, error) -> Void in
                    if checkin == nil {
                        
                        var coordonate = (lat: 0.0, long: 0.0)
                        
                        if CLLocationManager.locationServicesEnabled() {
                            coordonate.lat = self.userCoordonnate.latitude
                            coordonate.long = self.userCoordonnate.longitude
                        }
                        
                        let checkin = Checkin(coordonate: coordonate, status: true)
                        CheckinSynchroniser.saveObject(checkin, event: PFEvent)
                        
                        self.checkinButton.enabled = false
                        self.checkinButton.backgroundColor = UIColorFromRGBA("ffffff", alpha: 0.5)
                    }
                })
                
            }
        }
        
    }
    
    // MARK: - UICollectionView DataSource & Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FriendCollectionViewCell.identifier, forIndexPath: indexPath) as! FriendCollectionViewCell
        
        if let username = users[indexPath.row].username {
            cell.shortNameLabel.text = username
        }
        
        return cell
    }
    
}
