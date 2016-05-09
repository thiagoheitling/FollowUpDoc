//
//  ViewController.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-04-19.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit
import RealmSwift
import BEMSimpleLineGraph

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate {

    // MARK: Outlets
    @IBOutlet weak var painItemsTableView: UITableView!
    @IBOutlet weak var graphView: BEMSimpleLineGraphView!

    // MARK: Properties
    let painItems = try! Realm().objects(PainItem).sorted("date", ascending: false)
    let painItemsOnGraph = try! Realm().objects(PainItem).sorted("date", ascending: true)
    let cellIdentifier = "PainItemTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Follow Up Doc"
        self.navigationController?.navigationBarHidden = false
        
        graphView.delegate = self
        graphView.dataSource = self
        
        graphView.enableBezierCurve = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        painItemsTableView.reloadData()
        graphView.reloadGraph()
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
        
        // Fetches the appropriate pain item for the data source layout.
        let painItem = painItems[indexPath.row]
        
        cell.intensityLabel.text = "\(painItem.intensity)"
        cell.locationLabel.text = painItem.location
        
        // formating date
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatter.localizedFormat("MMMM dd, yyyy")
        formatter.timeZone = NSTimeZone(name: "US/Pacific")
        
        
        let dateString = formatter.stringFromDate(painItem.date)
        
        cell.dateLabel.text = dateString
        
        //retrieving image
        let image = UIImage.init(data: painItem.image!)
        cell.painLocationPhoto.image = image
        cell.painLocationPhoto.layer.cornerRadius = cell.painLocationPhoto.frame.size.width/2
        cell.painLocationPhoto.clipsToBounds = true
        
        return cell
    }
    
    @IBAction func unwindToMainVC(sender: UIStoryboardSegue) {
        
        if sender.sourceViewController is PainItemVC {
            
            if let selectedIndexPath = painItemsTableView.indexPathForSelectedRow {
                // Update an existing pain item
                painItemsTableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }
    
    // func to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // func to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let realm = try! Realm()
            try! realm.write{
                realm.delete(painItems[indexPath.row])
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            graphView.reloadGraph()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - BEMSimpleLineGraph Deletages
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        
        return painItemsOnGraph.count
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        
        return CGFloat(painItemsOnGraph[index].intensity)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetails" {
            
            let painItemVC = segue.destinationViewController as! PainItemVC
            
            // Get the cell that generated this segue.
            if let selectedItemCell = sender as? PainItemTableViewCell {
                let indexPath = painItemsTableView.indexPathForCell(selectedItemCell)!
                let selectedItem = painItems[indexPath.row]
                painItemVC.pain = selectedItem
            }
        }
        else if segue.identifier == "AddItem" {
            print("Start adding a new meal.")
        }
    }
}

