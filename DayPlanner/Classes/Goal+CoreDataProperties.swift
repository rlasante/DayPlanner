//
//  Goal+CoreDataProperties.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Goal: OnOptionalDay, OnOptionalFocusSession {
    @NSManaged var day: Day?
    @NSManaged var session: FocusSession?

    @NSManaged var text: String
    @NSManaged var priorityString: String
    @NSManaged var creationDate: NSDate
}
