//
//  Shoulder.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-05-09.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class Shoulder: BodyPart {

    var exercises = [Exercise]()
    var shoulderPress = Exercise()
    var armCircles = Exercise()
    var bandPullApart = Exercise()
    var frontRaise = Exercise()
    var lateralRaise = Exercise()
    
    override init() {
        super.init()
        
        initialiseExercises()
    }
    
    func initialiseExercises() -> [Exercise]{
        
        shoulderPress.descriptive = "text"
        shoulderPress.eSets = 0
        shoulderPress.eSetsTobeDone = 5
        shoulderPress.instructions = "text"
        shoulderPress.isCompleted = false
        shoulderPress.name = "Shoulder Press"
        shoulderPress.targetAreas = "Shoulders"
        exercises.append(shoulderPress)
        
        armCircles.descriptive = "text"
        armCircles.eSets = 0
        armCircles.eSetsTobeDone = 3
        armCircles.instructions = "text"
        armCircles.isCompleted = false
        armCircles.name = "Arm Cirlces"
        armCircles.targetAreas = "Shoulders"
        exercises.append(armCircles)

        bandPullApart.descriptive = "text"
        bandPullApart.eSets = 0
        bandPullApart.eSetsTobeDone = 5
        bandPullApart.instructions = "text"
        bandPullApart.isCompleted = false
        bandPullApart.name = "Band Pull Apart"
        bandPullApart.targetAreas = "Shoulders"
        exercises.append(bandPullApart)
        
        frontRaise.descriptive = "text"
        frontRaise.eSets = 0
        frontRaise.eSetsTobeDone = 3
        frontRaise.instructions = "text"
        frontRaise.isCompleted = false
        frontRaise.name = "Front Raise"
        frontRaise.targetAreas = "Shoulders"
        exercises.append(frontRaise)
        
        lateralRaise.descriptive = "text"
        lateralRaise.eSets = 0
        lateralRaise.eSetsTobeDone = 10
        lateralRaise.instructions = "1. Raise upper arms to sides until elbows are shoulder height.\n2. Maintain elbows' height above or equal to wrists.\n3. Lower and repeat."
        lateralRaise.isCompleted = false
        lateralRaise.name = "Lateral Raise"
        lateralRaise.targetAreas = "Shoulders"
        exercises.append(lateralRaise)
        
        return exercises
    }
}

