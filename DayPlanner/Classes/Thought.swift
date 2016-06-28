//
//  Thought.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Thought: NSManagedObject {



    convenience init(with text: String, on day: Day, on context: NSManagedObjectContext) {
        self.init(with: text, on: context)
        self.day = day
    }

    convenience init(with text: String, in retro: Retro, on context: NSManagedObjectContext) {
        self.init(with: text, on: context)
        self.retro = retro
    }

    convenience init(with text: String, during focusSession: FocusSession, on context: NSManagedObjectContext) {
        self.init(with: text, on: context)
        self.session = focusSession
    }

    private convenience init(with text: String, on context: NSManagedObjectContext) {
        self.init(on: context)
        self.text = text
    }

// Insert code here to add functionality to your managed object subclass

}
