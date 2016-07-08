//
//  FocusSession.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class FocusSession: NSManagedObject, SubContent, ThoughtFactory, GoalFactory {

}

extension FocusSession: ParentConvertable {
    func parentWrapper() -> Parent {
        return .focusSession(session: self)
    }
}

protocol OnFocusSession {
    var session: FocusSession { get set }
}

protocol OnOptionalFocusSession {
    var session: FocusSession? { get set }
}
