//
//  ContextAware.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

protocol ContextAware {
    var context: NSManagedObjectContext! { get set }
    mutating func prepare(with context: NSManagedObjectContext)
}

extension ContextAware {
    mutating func prepare(with context: NSManagedObjectContext) {
        self.context = context
    }
}

extension ContextAware where Self: UIViewController {
    func viewDidLoad() {
        assert(context != nil, "You must make sure that the context is set before viewDidLoad")
    }
}
