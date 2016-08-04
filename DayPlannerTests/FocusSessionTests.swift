//
//  FocusSessionTests.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/6/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
@testable import DayPlanner

class FocusSessionTests: XCTestCase {

    func testDayConstructor() {
        let day = Day(on: context, with: NSDate())
        let session = FocusSession(on: context, on: day)

        XCTAssertEqual(session.day, day)
    }

    func testThoughtFactory() {
        let day = Day(on: context, with: NSDate())
        let session = FocusSession(on: context, on: day)

        let thoughtsTexts = ["First", "Second", "Third"]
        let thoughts = session.createThoughts(thoughtsTexts)

        XCTAssertEqual(thoughts.count, 3)
        for thought in thoughts {
            XCTAssertTrue(thoughtsTexts.contains(thought.text))
            XCTAssertEqual(thought.session, session)
        }

        XCTAssertEqual(session.thoughts.count, 3)
        for thought in session.thoughts {
            XCTAssertTrue(thoughtsTexts.contains(thought.text))
            XCTAssertEqual(thought.session, session)
        }
    }

    func testGoalFactory() {
        let day = Day(on: context, with: NSDate())
        let session = FocusSession(on: context, on: day)

        let goalTexts = ["First", "Second", "Third"]
        let goals = session.createGoals(goalTexts)

        XCTAssertEqual(goals.count, 3)
        for goal in goals {
            XCTAssertTrue(goalTexts.contains(goal.text))
            XCTAssertEqual(goal.session, session)
        }

        XCTAssertEqual(session.goals.count, 3)
        for goal in session.goals {
            XCTAssertTrue(goalTexts.contains(goal.text))
            XCTAssertEqual(goal.session, session)
        }
    }
}
