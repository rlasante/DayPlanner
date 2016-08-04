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

    let defaultText = "This is a test thought"

    func testBasicCreation() {
        let thought: Thought = Thought(on: context)
        thought.text = defaultText

        XCTAssertEqual(thought.text, defaultText)
    }

    func testDayCreation() {
        let day = Day(on: context, with: NSDate())
        let thought: Thought = Thought(on: context, on: day, with: defaultText)
        XCTAssertEqual(thought.text, defaultText)
        XCTAssertEqual(thought.day, day)
        XCTAssertNil(thought.retro)
        XCTAssertNil(thought.session)

        context.deleteObject(day)
    }

    func testSessionCreation() {
        let session = FocusSession(on: context)
        let thought = Thought(on: context, on: session, with: defaultText)
        XCTAssertEqual(thought.text, defaultText)
        XCTAssertEqual(thought.session, session)
        XCTAssertNil(thought.retro)
        XCTAssertNil(thought.day)

        context.deleteObject(session)
    }
}
