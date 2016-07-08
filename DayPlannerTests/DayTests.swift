//
//  DayTests.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/7/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
@testable import DayPlanner

class DayTests: XCTestCase {

    var day: Day!

    override func setUp() {
        day = Day(on: context, with: NSDate())
    }

    func testSessionCreator() {
        let session = day.createFocusSession()
        XCTAssertEqual(day.focusSessions.first, session)
        XCTAssertEqual(session.day, day)
    }

    func testRetroCreator() {
        let retro = day.createRetro()
        XCTAssertEqual(day.retros.first, retro)
        XCTAssertEqual(retro.day, day)
    }

    func testTaskCreator() {
        let task = day.createTasks("Task").first
        XCTAssertEqual(day.tasks.first, task)
        XCTAssertEqual(task?.day, day)
    }

    func testThoughtCreator() {
        let thought = day.createThoughts("Thought").first
        XCTAssertEqual(day.thoughts.first, thought)
        XCTAssertEqual(thought?.day, day)
    }

    func testGoalCreator() {
        let goal = day.createGoals("Goal").first
        XCTAssertEqual(day.goals.first, goal)
        XCTAssertEqual(goal?.day, day)
    }

}
