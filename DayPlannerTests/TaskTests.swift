//
//  GoalTests.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/2/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
@testable import DayPlanner

class TaskTests: XCTestCase {

    func testDayConstructor() {
        let day = Day(on: context, with: NSDate())
        let task = Task(on: context, on: day)

        XCTAssertEqual(task.day, day)
    }

    func testTaskText() {
        let text = "Hello"
        let task = Task(on: context)
        task.text = text

        XCTAssertEqual(task.text, text)
    }

    func testTaskDone() {
        let expectedStart = false
        let expectedDone = true

        let task = Task(on: context)
        XCTAssertEqual(task.done, expectedStart)

        task.done = true

        XCTAssertEqual(task.done, expectedDone)

    }

    func testDefaultTaskPriority() {
        let task = Task(on: context)

        XCTAssertEqual(task.priority, Priority.low)
    }

    func testChangingTaskPriority() {
        let expectedPriority: Priority = .extreme
        let task = Task(on: context)

        // Verify that the priority didn't start at extreme
        XCTAssertNotEqual(task.priority, expectedPriority)

        task.priority = expectedPriority
        XCTAssertEqual(task.priority, expectedPriority)
    }
    
}
