//
//  NSDate+Planner.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/17/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit

extension NSDate {

    func dayDateComponents() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: self)
        components.calendar = NSCalendar.currentCalendar()
        return components
    }

    func dayDateString() -> String {
        let components = dayDateComponents()
        return "\(components.month)-\(components.day)-\(components.year)"
    }

    convenience init?(withDayString dayString: String) {
        guard let date = NSDateComponents(withDayString: dayString)?.date else {
            return nil
        }
        self.init(timeInterval: 0, sinceDate: date)
    }
}

extension NSDateComponents {

    convenience init?(withDayString dayString: String) {
        let stringComponents = dayString.characters.split("-").map(String.init)
        guard stringComponents.count == 3 else {
            return nil
        }
        guard let month = Int(stringComponents[0]),
            let day = Int(stringComponents[1]),
            let year = Int(stringComponents[2]) else {
                return nil
        }

        self.init()
        self.calendar = NSCalendar.currentCalendar()

        self.day = day
        self.month = month
        self.year = year
    }

}
