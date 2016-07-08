//
//  Factory.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/6/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import CoreData

protocol Factory {
    associatedtype ParameterType
    associatedtype ReturnType

    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: [ParameterType]) -> [ReturnType]
}

extension Factory {

    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: ParameterType ...) -> [ReturnType] {
        return Self.create(on: context, on: parent, with: params)
    }

    static func create(on context: NSManagedObjectContext, on parentConvertable: ParentConvertable, with params: ParameterType...) -> [ReturnType] {
        return Self.create(on: context, on: parentConvertable, with: params)
    }

    static func create(on context: NSManagedObjectContext, on parentConvertable: ParentConvertable, with params: [ParameterType]) -> [ReturnType] {
        return Self.create(on: context, on: parentConvertable.parentWrapper(), with: params)
    }
}

extension Factory where Self: ContextAware {
    func create(on parent: Parent, with params: ParameterType ...) -> [ReturnType] {
        return create(on: parent, with: params)
    }

    func create(on parent: ParentConvertable, with params: ParameterType...) -> [ReturnType] {
        return create(on: parent.parentWrapper(), with: params)
    }

    func create(on parent: ParentConvertable, with params: [ParameterType]) -> [ReturnType] {
        return create(on: parent.parentWrapper(), with: params)
    }

    func create(on parent: Parent, with params: [ParameterType]) -> [ReturnType] {
        return Self.create(on: context, on: parent, with: params)
    }
}

extension Factory where Self: ParentConvertable {
    func create(on context: NSManagedObjectContext, with params: ParameterType ...) -> [ReturnType] {
        return create(on: context, with: params)
    }

    func create(on context: NSManagedObjectContext, with params: [ParameterType]) -> [ReturnType] {
        return Self.create(on: context, on: self.parentWrapper(), with: params)
    }
}

extension Factory where Self: ContextAware, Self: ParentConvertable {
    func create(with params: ParameterType ...) -> [ReturnType] {
        return create(with: params)
    }

    func create(with params: [ParameterType]) -> [ReturnType] {
        return Self.create(on: context, on: self.parentWrapper(), with: params)
    }
}

protocol ThoughtsFactory: Factory {
    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: [String]) -> [Thought]
}
extension ThoughtsFactory {
    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: [String]) -> [Thought] {
        var thoughts: [Thought] = []
        for text in params {
            thoughts.append(Thought(on: context, on: parent, with: text))
        }
        return thoughts
    }
}

protocol GoalsFactory: Factory {
    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: [String]) -> [Goal]
}
extension GoalsFactory {
    static func create(on context: NSManagedObjectContext, on parent: Parent, with params: [String]) -> [Goal] {
        var goals: [Goal] = []
        for text in params {
            goals.append(Goal(on: context, on: parent, with: text))
        }
        return goals
    }
}
