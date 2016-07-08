//
//  SubContent.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/2/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import CoreData

protocol SubContent {
    var parent: Parent { get }
}

enum Parent {
    case day(day: Day)
    case focusSession(session: FocusSession)
    case retro(retro: Retro)
}

protocol ParentConvertable {
    func parentWrapper() -> Parent
}

extension SubContent where Self: NSManagedObject, Self: OnDay {
    var parent: Parent {
        get {
            return .day(day: self.day)
        }
    }

    init(on context: NSManagedObjectContext, on parent: Parent) {
        self.init(on: context)
        switch (parent) {
        case .day(let day):
            self.day = day
        default:
            assertionFailure("This object's parent can only be a Day")
        }
    }

    init(on context: NSManagedObjectContext, on parent: ParentConvertable) {
        self.init(on: context, on: parent.parentWrapper())
    }
}

extension SubContent where Self: NSManagedObject, Self: OnRetro {
    var parent: Parent {
        get {
            return .retro(retro: self.retro)
        }
    }

    init(on context: NSManagedObjectContext, on parent: Parent) {
        self.init(on: context)
        switch (parent) {
        case .retro(let retro):
            self.retro = retro
        default:
            assertionFailure("This object's parent can only be a Retro")
        }
    }

    init(on context: NSManagedObjectContext, on parent: ParentConvertable) {
        self.init(on: context, on: parent.parentWrapper())
    }
}

extension SubContent where Self: NSManagedObject, Self: OnFocusSession {
    var parent: Parent {
        get {
            return .focusSession(session: self.session)
        }
    }

    init(on context: NSManagedObjectContext, on parent: Parent) {
        self.init(on: context)
        switch (parent) {
        case .focusSession(let session):
            self.session = session
        default:
            assertionFailure("This object's parent can only be a FocusSession")
        }
    }

    init(on context: NSManagedObjectContext, on parent: ParentConvertable) {
        self.init(on: context, on: parent.parentWrapper())
    }
}

extension SubContent where Self: NSManagedObject, Self: OnOptionalDay, Self: OnOptionalFocusSession {
    var parent: Parent {
        get {
            if let day = self.day {
                return .day(day: day)
            } else if let session = self.session {
                return .focusSession(session: session)
            }
            assertionFailure("There must be a day, retro or focusSession on this object")
            abort()
        }
    }

    init(on context: NSManagedObjectContext, on parent: Parent) {
        self.init(on: context)
        switch (parent) {
        case .day(let day):
            self.day = day
        case .focusSession(let session):
            self.session = session
        default:
            assertionFailure("This object's parent Must be a Day, Retro, or FocusSession")
        }
    }

    init(on context: NSManagedObjectContext, on parent: ParentConvertable) {
        self.init(on: context, on: parent.parentWrapper())
    }
}

extension SubContent where Self: NSManagedObject, Self: OnOptionalDay, Self: OnOptionalRetro, Self: OnOptionalFocusSession {
    var parent: Parent {
        get {
            if let day = self.day {
                return .day(day: day)
            } else if let retro = self.retro {
                return .retro(retro: retro)
            } else if let session = self.session {
                return .focusSession(session: session)
            }
            assertionFailure("There must be a day, retro or focusSession on this object")
            abort()
        }
    }

    init(on context: NSManagedObjectContext, on parent: Parent) {
        self.init(on: context)
        switch (parent) {
        case .day(let day):
            self.day = day
        case .retro(let retro):
            self.retro = retro
        case .focusSession(let session):
            self.session = session
        default:
            assertionFailure("This object's parent Must be a Day, Retro, or FocusSession")
        }
    }

    init(on context: NSManagedObjectContext, on parent: ParentConvertable) {
        self.init(on: context, on: parent.parentWrapper())
    }
}
