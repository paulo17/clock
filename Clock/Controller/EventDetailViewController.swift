//
//  EventDetailViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class EventDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var looseLabel: UILabel!
    @IBOutlet weak var completeDate: UILabel!
    
    var event: Event!
    lazy var users = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = event.name {
            navigationItem.title = name
        } else {
            navigationItem.title = "Evenement sans nom"
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        let dateString = dateFormatter.stringFromDate(event.date)
        
        dateFormatter.dateFormat = "d m y"
        let fullDate = dateFormatter.stringFromDate(event.date)
        
        
        dateLabel.text = dateString
        addressLabel.text = event.address
        completeDate.text = fullDate
        
    }
    
    // MARK: - UICollectionView DataSource & Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FriendCollectionViewCell.identifier, forIndexPath: indexPath) as! FriendCollectionViewCell
        
        return cell
    }
    
}
