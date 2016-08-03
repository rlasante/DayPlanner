//
//  Day+CoreDataProperties.swift
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

extension Day {
    @NSManaged var dayString: String

    @NSManaged var focusSessions: Set<FocusSession>
    @NSManaged var tasks: Set<Task>
    @NSManaged var thoughts: Set<Thought>
    @NSManaged var goals: Set<Goal>
    @NSManaged var retros: Set<Retro>
    
}
