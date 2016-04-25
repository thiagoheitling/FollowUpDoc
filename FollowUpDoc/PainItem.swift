//
//  PainItem.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-04-24.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class PainItem: NSObject {
    
    // MARK: - Properties
    
    let location: String
    let intensity: NSInteger
    let aDescription: String?
    let image: UIImage?
    let date: String
    
    // MARK: Initialization
    
    init?(location: String, intensity: NSInteger, description: String, image: UIImage, date: String) {
        
        self.location = location
        self.intensity = intensity
        self.aDescription = description
        self.image = image
        self.date = date
        
        super.init()
        
        // Initialization should fail if there is no pain location or if the intensity is negative.
        if location.isEmpty || intensity < 0 {
            return nil
        }
    }
}
