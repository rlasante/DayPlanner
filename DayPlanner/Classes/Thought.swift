//
//  Thought.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import Foundation
import CoreData


class Thought: NSManagedObject, SubContent {

    convenience init(on context: NSManagedObjectContext, on parent: Parent, with text: String) {
        self.init(on: context, on: parent)
        self.text = text
    }

    convenience init(on context: NSManagedObjectContext, on parent: ParentConvertable, with text: String) {
        self.init(on: context, on: parent.parentWrapper(), with: text)
    }
}

protocol ThoughtFactory {}
extension ThoughtFactory {
    static func createThoughts(on context: NSManagedObjectContext, on parent: Parent, texts: String ...) -> [Thought] {
        return createThoughts(on: context, on: parent, texts: texts)
    }

    static func createThoughts(on context: NSManagedObjectContext, on parent: Parent, texts: [String]) -> [Thought] {
        var thoughts: [Thought] = []
        for text in texts {
            thoughts.append(Thought(on: context, on: parent, with: text))
        }
        return thoughts
    }
}

extension ThoughtFactory where Self: ContextAware {
    func createThoughts(on parent: Parent, texts: String ...) -> [Thought] {
        return createThoughts(on: parent, texts: texts)
    }

    func createThoughts(on parent: Parent, texts: [String]) -> [Thought] {
        return Self.createThoughts(on: context, on: parent, texts: texts)
    }
}

extension ThoughtFactory where Self: ParentConvertable {
    func createThoughts(on context: NSManagedObjectContext, texts: String ...) -> [Thought] {
        return createThoughts(on: context, texts: texts)
    }

    func createThoughts(on context: NSManagedObjectContext, texts: [String]) -> [Thought] {
        return Self.createThoughts(on: context, on: self.parentWrapper(), texts: texts)
    }
}

extension ThoughtFactory where Self: ParentConvertable, Self: ContextAware {
    func createThoughts(texts: String ...) -> [Thought] {
        return createThoughts(on: context, texts: texts)
    }

    func createThoughts(texts: [String]) -> [Thought] {
        return Self.createThoughts(on: context, on: self.parentWrapper(), texts: texts)
    }
}
