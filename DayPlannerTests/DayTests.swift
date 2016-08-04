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

    func testDayFetch() {
        do {
            context.deleteObject(self.day)
            self.day = nil
            guard let date = NSDate().dayDateComponents().date else { XCTFail("Failed to create the today date"); return }
            let invalidDay = try context.executeFetchRequest(Day.fetchRequest(for: date)).first as? Day
            XCTAssertNil(invalidDay, "The day hasn't been created so the fetch should fail")
            let _ = Day(on: context, with: date)
            let day = try context.executeFetchRequest(Day.fetchRequest(for: date)).first as? Day
            XCTAssertNotNil(day)
            XCTAssertEqual(day?.date, date)
        } catch {
            XCTFail("Failed to get request")
        }
    }

    func testDeleteGoals() {
        guard let goal = day.createGoals("Test").first else {
            XCTFail("Failed to create a goal")
            return
        }
        XCTAssertEqual(day.goals.count, 1)

        day.goals.remove(goal)
        context.deleteObject(goal)
        XCTAssertEqual(day.goals.count, 0)
    }

}
