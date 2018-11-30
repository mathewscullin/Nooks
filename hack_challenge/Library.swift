//
//  Library.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation


struct Location: Codable {
    var coordinates : [Float]
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
    var nooks : [Nook]
    var services : Services
    var cafe : Cafe
}

class Library: Codable {
    
    var name : String
    var image_url : String
    var times: [String]
    var information: Information
    var isOpen : Bool
    var isClosing : Bool
    var location: Location
    var isFavorite: Bool
    
    init(name: String, image_url : String, times : [String], information: Information, location : Location) {
        self.name = name
        self.image_url = image_url
        self.times = times
        self.information = information
        self.location = location
        isOpen = false
        isClosing = false
        isFavorite = false
    }
    
    func isOpen(time: String) -> Bool {
        let currDate = Date()
        let hour = Calendar.current.component(.hour, from: currDate)
        var opening = time.components(separatedBy: ":")
        var end = time.components(separatedBy: " ")
        var closing = end[4].components(separatedBy: ":")
        if(hour >= Int(opening[0]) ?? 0 && hour < 12 + (Int(closing[0]) ?? 24)) {
            return true
        }
        return false
    }
    
    func isClosing(time: String) -> Bool {
        let currDate = Date()
        let hour = Calendar.current.component(.hour, from: currDate)
        var end = time.components(separatedBy: " ")
        var closing = end[4].components(separatedBy: ":")
        if( (Int(closing[0]) ?? 0) - hour <= 1) {
            return true
        }
        return false
    }
}

struct libraryResponse: Codable {
    var libraries: [Library]
}
