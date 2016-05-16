//
//  Exercise.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-05-09.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class Exercise: NSObject {

    var name = String()
//    let bodyPart = BodyPart()
    var isCompleted = Bool()
    var descriptive = String()
    var targetAreas = String()
    var instructions = String()
    var eSets = Int()
    var eSetsTobeDone = Int()
    
    func letsDoIt(sets:Int) {
        if eSets < eSetsTobeDone {
            eSets += 1
        } else {
            isCompleted = true
        }
    }
}
