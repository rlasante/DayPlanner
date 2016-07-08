//
//  Day.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Day: NSManagedObject, TaskFactory, ThoughtFactory, GoalFactory {

    convenience init(on context: NSManagedObjectContext, with date: NSDate) {
        self.init(on: context)
        self.date = date
    }

    func createFocusSession() -> FocusSession {
        return FocusSession(on: context, on: self)
    }

    func createRetro() -> Retro {
        return Retro(on: context, on: self)
    }
}

extension Day: ParentConvertable {
    func parentWrapper() -> Parent {
        return .day(day: self)
    }
}

// MARK: - OnDay Protocols
protocol OnDay {
    var day: Day { get set }
}

protocol OnOptionalDay {
    var day: Day? { get set }
}
