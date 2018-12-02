//
//  Library.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation


struct Location: Codable {
    var coordinates : [Double]
    var campus : String
}

struct Nook : Codable {
    var roomName : String
    var loudnessLevel : String
}
struct Services : Codable{
    var Electronic : [String]
    var Resources : [String]
}
struct Cafe : Codable {
    var name : String
    var time : String
    var brb : Bool
}


struct Information : Codable {
    //var nooks : [Nook]
    var services : Services
    var cafe : Cafe
}

class Library: Codable {
    
    var name : String
    var image_url : String
    var times: [String]
    var information: Information
    var isOpen : Bool = false
    var isClosing : Bool = false
    var location: Location
    var isFavorite: Bool = false
    
    init(name: String, image_url : String, times : [String], information: Information, location : Location) {
        self.name = name
        self.image_url = image_url
        self.times = times
        self.information = information
        self.location = location
        self.isOpen = getIsOpen(time: times[0])
        self.isClosing = getIsClosing(time: times[0])
        isFavorite = false
    }
    
    enum CodingKeys: String, CodingKey {
        case name , image_url , times, information , location
    }
}

struct LibraryResponse: Codable {
    var libraries: [Library]
}
struct finalLibraryResponse: Codable {
    var data: LibraryResponse
}


