//
//  Goal.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Goal: NSManagedObject, PriorityData, SubContent {

    convenience init(on context: NSManagedObjectContext, on parent: Parent, with text: String, with priority: Priority = .low) {
        self.init(on: context, on: parent)
        self.priority = priority
        self.text = text
    }

    convenience init(on context: NSManagedObjectContext, on parent: ParentConvertable, with text: String, with priority: Priority = .low) {
        self.init(on: context, on: parent.parentWrapper(), with: text, with: priority)
    }
    
}

protocol GoalFactory {}
extension GoalFactory {
    static func createGoals(on context: NSManagedObjectContext, on parent: Parent, texts: String ...) -> [Goal] {
        return createGoals(on: context, on: parent, texts: texts)
    }

    static func createGoals(on context: NSManagedObjectContext, on parent: Parent, texts: [String]) -> [Goal] {
        var goals: [Goal] = []
        for text in texts {
            goals.append(Goal(on: context, on: parent, with: text))
        }
        return goals
    }
}

extension GoalFactory where Self: ContextAware {
    func createGoals(on parent: Parent, texts: String ...) -> [Goal] {
        return createGoals(on: parent, texts: texts)
    }

    func createGoals(on parent: Parent, texts: [String]) -> [Goal] {
        return Self.createGoals(on: context, on: parent, texts: texts)
    }
}

extension GoalFactory where Self: ParentConvertable {
    func createGoals(on context: NSManagedObjectContext, texts: String ...) -> [Goal] {
        return createGoals(on: context, texts: texts)
    }

    func createGoals(on context: NSManagedObjectContext, texts: [String]) -> [Goal] {
        return Self.createGoals(on: context, on: self.parentWrapper(), texts: texts)
    }
}

extension GoalFactory where Self: ContextAware, Self: ParentConvertable {
    func createGoals(texts: String ...) -> [Goal] {
        return createGoals(texts)
    }

    func createGoals(texts: [String]) -> [Goal] {
        return Self.createGoals(on: context, on: self.parentWrapper(), texts: texts)
    }
}
