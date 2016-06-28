//
//  ThoughtTest.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
import CoreData
@testable import DayPlanner


class ThoughtTest: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        context = AppDelegate.sharedAppDelegate.managedObjectContext
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testBasicCreation() {
        let testText = "This is a test thought"
        let thought: Thought = Thought(on: context)
        thought.text = testText

        XCTAssertEqual(thought.text, testText)
    }

    func testDayCreation() {
        let day = Day(with: NSDate(), on: context)
        let testText = "This is a test thought"
        let thought: Thought = Thought(with: testText, on: day, on: context)
        XCTAssertEqual(thought.text, testText)
        XCTAssertEqual(thought.day, day)

        context.deleteObject(day)
    }
}
