//
//  XCTestCase+Extensions.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/28/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
import CoreData
@testable import DayPlanner

extension XCTestCase: ContextAware {

    var context: NSManagedObjectContext! {
        get {
            return AppDelegate.sharedAppDelegate.managedObjectContext
        }
    }

}
