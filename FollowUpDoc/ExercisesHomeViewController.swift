//
//  ExercisesHomeViewController.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-05-09.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class ExercisesHomeViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var BodyPartsTableView: UITableView!
    
    // MARK: Properties
    //var bodyParts: [BodyPart]
    let shoulder = Shoulder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Exercises"
        self.navigationController?.navigationBarHidden = false
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let shoulderExercises = shoulder.exercises
        return shoulderExercises.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let shoulderExercises = shoulder.exercises
        let exercise = shoulderExercises[indexPath.row]
        cell.textLabel?.text = exercise.name
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showExerciseDetails" {
            
            let exerciseDVC = segue.destinationViewController as! ExerciseDetailVC
            let indexPath: NSIndexPath = BodyPartsTableView.indexPathForSelectedRow!
            let shoulderExercises = shoulder.exercises
            let exercise = shoulderExercises[indexPath.row]
            exerciseDVC.exerciseSelected = exercise
            
            exerciseDVC.title = "\(exercise.name)"
        }
        
    }
}
