//
//  Priority.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation

enum Priority: String {
    case low = "low"
    case medium = "medium"
    case high = "high"
    case extreme = "extreme"

    init?(stringValue: String) {
        self.init(rawValue: stringValue)
    }

    var stringValue: String {
        get {
            return self.rawValue
        }
    }
}

@objc protocol PriorityData {
    var priorityString: String { get set }
}

extension PriorityData {
    var priority: Priority {
        get {
            return Priority(stringValue: self.priorityString) ?? .low
        } set {
            priorityString = newValue.stringValue
        }
    }
}