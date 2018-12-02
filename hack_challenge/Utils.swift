//
//  Utils.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 12/2/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation

func getIsOpen(time: String) -> Bool{
    let currDate = Date()
    let hour = Calendar.current.component(.hour, from: currDate)
    var opening = time.components(separatedBy: ":")
    var end = time.components(separatedBy: " ")
    var closing = Int(end[3].components(separatedBy: ":")[0])
    
    if(end[4] == "PM" && closing ?? 0 < 12) {
        closing! += 12
    }
    // "10:00 AM - 7:00 AM"
    if(hour >= Int(opening[0]) ?? 0) { //&& hour < 12 + (Int(closing[0]) ?? 24)) {
        print(opening[0])
        print(closing)
        print(hour)
        print(end[3].components(separatedBy: ":"))
        return true
    }
    return false
}

func getIsClosing(time: String) -> Bool {
    let currDate = Date()
    let hour = Calendar.current.component(.hour, from: currDate)
    var end = time.components(separatedBy: " ")
    var closing = end[4].components(separatedBy: ":")
    if( (Int(closing[0]) ?? 0) - hour <= 1) {
        return true
    }
    return false
}
