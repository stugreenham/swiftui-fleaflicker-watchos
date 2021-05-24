//
//  Function.swift
//  Fleaflicker Watch WatchKit Extension
//
//  Created by Stu Greenham on 24/05/2021.
//

import SwiftUI


//: MARK: - FORMAT ROSTER TITLES
func getGroupTitle(groupName: String) -> String {
    var groupTitle: String
    if groupName == "START" {
        groupTitle = "Starters"
    } else if groupName == "TAXI" {
        groupTitle = "Taxi"
    } else {
        groupTitle = "Bench"
    }
    return groupTitle
}
