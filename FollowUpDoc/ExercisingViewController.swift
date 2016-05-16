//
//  ExercisingViewController.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-05-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class ExercisingViewController: UIViewController {

    
    @IBOutlet weak var counterLabel: UILabel!
    
    var exerciseDoing = Exercise()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated:true)
        
        counterLabel.text = "\(exerciseDoing.eSetsTobeDone)"
        exerciseDoing.eSets = exerciseDoing.eSetsTobeDone
        
        counterLabel.layer.cornerRadius = counterLabel.frame.width / 2
        counterLabel.clipsToBounds = true
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(orientationChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
    
    }
    
    // Actions
    
    func orientationChange()
    {
        
        if UIDevice.currentDevice().orientation == .FaceUp {
            
            if exerciseDoing.eSets > 1 {
                exerciseDoing.eSets = exerciseDoing.eSets - 1
                counterLabel.text = "\(exerciseDoing.eSets)"
                //print("faceUp")
            } else {
                exerciseDoing.isCompleted = true
                counterLabel.text = "FINISHED"
                counterLabel.font = counterLabel.font.fontWithSize(40)
            }

        }
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            //print("landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            //print("Portrait")
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    

}
