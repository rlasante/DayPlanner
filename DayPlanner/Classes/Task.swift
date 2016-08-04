//
//  Task.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject, PriorityData, SubContent {

    convenience init(on context: NSManagedObjectContext, on day: Day, with text: String, with priority: Priority = .low) {
        self.init(on: context, on: day.parentWrapper())
        self.text = text
        self.priority = priority
    }

}

protocol TaskFactory {}
extension TaskFactory {
    static func createTasks(on context: NSManagedObjectContext, on day: Day, texts: String ...) -> [Task] {
        return createTasks(on: context, on: day, texts: texts)
    }

    static func createTasks(on context: NSManagedObjectContext, on day: Day, texts: [String]) -> [Task] {
        var tasks: [Task] = []
        for text in texts {
            tasks.append(Task(on: context, on: day, with: text))
        }
        return tasks
    }
}

extension TaskFactory where Self: Day {
    func createTasks(texts: String ...) -> [Task] {
        return createTasks(texts)
    }

    func createTasks(texts: [String]) -> [Task] {
        return Self.createTasks(on: context, on: self, texts: texts)
    }
}
