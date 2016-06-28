//
//  Day.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Day: NSManagedObject {

    convenience init(with date: NSDate, on context: NSManagedObjectContext) {
        self.init(on: context)
        self.date = date
    }

}
