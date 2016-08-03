//
//  GoalTests.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/2/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
@testable import DayPlanner

class GoalTests: XCTestCase {

    func testDayConstructor() {
        let day = Day(on: context, with: NSDate())
        let goal = Goal(on: context, on: day)

        XCTAssertEqual(goal.day, day)
    }

    func testSessionConstructor() {
        let session = FocusSession(on: context)
        let goal = Goal(on: context, on: session)
        XCTAssertEqual(goal.session, session)
    }

    func testGoalConstructor() {
        let goalText = "Hello Goal"
        let day = Day(on: context, with: NSDate())
        let goal = Goal(on: context, on:day, with: goalText)

        XCTAssertEqual(goal.day, day)
        XCTAssertEqual(goal.text, goalText)
        XCTAssertEqual(goal.priority, Priority.low)
    }

    func testGoalConstructorWithPriority() {
        let goalText = "Hello Goal"
        let priority = Priority.extreme
        let day = Day(on: context, with: NSDate())
        let goal = Goal(on: context, on:day, with: goalText, with: priority)

        XCTAssertEqual(goal.day, day)
        XCTAssertEqual(goal.text, goalText)
        XCTAssertEqual(goal.priority, priority)
    }

    func testGoalText() {
        let text = "Hello"
        let goal = Goal(on: context)
        goal.text = text

        XCTAssertEqual(goal.text, text)
    }

    func testDefaultGoalPriority() {
        let goal = Goal(on: context)

        XCTAssertEqual(goal.priority, Priority.low)
    }

    func testChangingGoalPriority() {
        let expectedPriority: Priority = .extreme
        let goal = Goal(on: context)

        // Verify that the priority didn't start at extreme
        XCTAssertNotEqual(goal.priority, expectedPriority)

        goal.priority = expectedPriority
        XCTAssertEqual(goal.priority, expectedPriority)
    }

    func testDateFetchRequest() {
        do {
            let date = NSDate()
            let day = Day(on: context, with: date)
            let expectedGoals = day.createGoals("Test1", "Test2", "Test3")

            let fetchedObjects = try context.executeFetchRequest(Goal.fetchRequest(for:date))
            guard let fetchedGoals = fetchedObjects as? [Goal] else {
                XCTFail("No goals were fetched")
                return
            }
            XCTAssertEqual(fetchedGoals.count, expectedGoals.count)

            for goal in fetchedGoals {
                XCTAssertTrue(expectedGoals.contains(goal))
            }

        } catch {
            XCTFail("Failed to fetch the goals")
        }
    }

}
