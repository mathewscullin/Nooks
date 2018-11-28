//
//  Library.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation
import MapKit

public enum Area : String {
    case north = "North"
    case central = "Central"
    case west = "West"
    case agquad = "AG Quad"
    case engquad = "Engineering Quad"
    case ctown = "College Town"
    case unkown = ""
}
struct Location {
    var place : Area
    var coordinates : CLLocationCoordinate2D
}

class Library {
    
    var name : String
    var image : String
    var isOpen : Bool
    var isClosing : Bool
    var hours : String
    var location: Location
    var nooks: String
    var services: String
    
    init(name : String, image: String, isOpen: Bool, isClosing: Bool, hours: String, location: Location, nooks: String, services : String) {
        self.name = name
        self.image = image
        self.isOpen = isOpen
        self.isClosing = isClosing
        self.hours = hours
        self.location = location
        self.nooks = nooks
        self.services = services
    }
}
