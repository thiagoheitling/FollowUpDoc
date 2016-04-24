//
//  ViewController.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-04-19.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var painItemsTableView: UITableView!
    
    // MARK: Properties
    var painItems = [PainItem]()
    let cellIdentifier = "PainItemTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Follow Up Doc"
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "logo"), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 0, 35, 35)
        let leftBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return painItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PainItemTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let painItem = painItems[indexPath.row]
        
        cell.intensityLabel.text = "\(painItem.intensity)"
        cell.locationLabel.text = painItem.location
        
        
        return cell
    }
    
    @IBAction func unwindToMainVC(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? PainItemVC, pain = sourceViewController.pain {
            
            if let selectedIndexPath = painItemsTableView.indexPathForSelectedRow {
                // Update an existing pain item
                painItems[selectedIndexPath.row] = pain
                painItemsTableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new meal
                let newIndexPath = NSIndexPath(forRow: painItems.count, inSection: 0)
                painItems.append(pain)
                painItemsTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // add here the method to save the pain items on core
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}

