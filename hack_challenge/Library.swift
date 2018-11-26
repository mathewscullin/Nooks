//
//  Library.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation

class Library {
    
    var name : String
    var image : String
    var state : Bool
    var hours : String
    var location: String
    var isFavorite: Bool
    
    init(name : String, image: String, state: Bool, hours: String, location: String, favorite: Bool) {
        self.name = name
        self.image = image
        self.state = state
        self.hours = hours
        isFavorite = favorite
        self.location = location
    }
}
