//
//  ExerciseDetailVC.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-05-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class ExerciseDetailVC: UIViewController {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseTargetAreasLabel: UILabel!
    @IBOutlet weak var exerciseInstructionsLabel: UILabel!
    @IBOutlet weak var exerciseStateLabel: UILabel!
    
    var exerciseSelected = Exercise()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
        
        exerciseNameLabel.text = exerciseSelected.name
        exerciseTargetAreasLabel.text = exerciseSelected.targetAreas
        exerciseInstructionsLabel.text = exerciseSelected.instructions
        
        if exerciseSelected.isCompleted == true {
            exerciseStateLabel.text = "Finished"
            exerciseStateLabel.textColor = UIColor.greenColor()
        } else {
            exerciseStateLabel.text = "Unfinished"
            exerciseStateLabel.textColor = UIColor.grayColor()
        }
    }
    
    // Actions
    @IBAction func letsDoThisButtonPressed(sender: AnyObject) {
        
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "letsDoThis" {
        
            let exercisingDVC = segue.destinationViewController as! ExercisingViewController
            exercisingDVC.exerciseDoing = exerciseSelected
            exercisingDVC.title = "\(exerciseSelected.name)"
        }
    }
}
