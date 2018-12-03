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
    
    if(time == "Closed") {
        return false
    }
    if(time == "24 Hours") {
        return true
    }
    let opening = Int(time.components(separatedBy: ":")[0])
    let end = time.components(separatedBy: " ")
    let closing = Int(end[3].components(separatedBy: ":")[0])
    
    if let realOpening = opening, let realClosing = closing {
        if(end[1] == "PM" && realOpening != 12){
            if(end[4] == "PM" && realClosing < 12) {
                return hour >= realOpening + 12 && hour < realClosing + 12
            }
            if(hour > 12){
                return hour >= realOpening + 12 && hour < realClosing + 24
            }
            return hour >= realOpening + 12 && hour < realClosing
        }
        if(end[4] == "PM" && realClosing < 12) {
            return hour >= realOpening && hour < realClosing + 12
        }
        if(hour >= 12){
            return hour >= realOpening  && hour < realClosing + 24
        }
        if(realClosing == 12) {
            if(hour < 12) {
                return hour + 12 >= realOpening && hour  < realClosing - 12
            }
            return hour + 12 >= realOpening && hour  < realClosing
        }
        return hour < realClosing
    }

    return false
}

func getIsClosing(time: String) -> Bool {
    let currDate = Date()
    let hour = Calendar.current.component(.hour, from: currDate)
    if(time == "Closed" || time == "24 Hours") {
        return false
    }
    var end = time.components(separatedBy: " ")
    let closing = Int(end[3].components(separatedBy: ":")[0])
    if let realClosing = closing {
        if(end[4] == "AM" && realClosing == 12 &&  hour >= 12) {
            return (realClosing + 12) - hour <= 1
        }
        if(end[4] == "AM" && hour >= 12) {
            print(realClosing + 24)
            return (realClosing + 24) - hour <= 1
        }
        if(end[4] == "PM" && realClosing < 12) {
        return (realClosing + 12) - hour <= 1
        }
        print(hour)
        print(realClosing)
        return realClosing - hour <= 1
    }
    return false
}
