//
//  RetroTests.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/28/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
import CoreData
@testable import DayPlanner

class RetroTests: XCTestCase {

    func testRetroDayConstructor() {
        let day = Day(on: context, with: NSDate())
        let retro = Retro(on: context, on: day)
        XCTAssertEqual(retro.day, day)
    }

    func testAddThoughts() {
        let thoughts = [Thought(on: context), Thought(on: context)]
        let retro = Retro(on: context)

        for thought in thoughts {
            retro.thoughts.insert(thought)
        }

        for thought in thoughts {
            XCTAssertTrue(retro.thoughts.contains(thought))
        }

        for thought in thoughts {
            XCTAssertEqual(thought.retro, retro)
        }
    }

    func testRetroThoughtsFactory() {
        let thoughtTexts = ["Test 1", "Hello", "This worked"]
        let retro = Retro(on: context)
        retro.createThoughts(thoughtTexts)

        XCTAssertEqual(retro.thoughts.count, 3)
        for thought in retro.thoughts {
            XCTAssertTrue(thoughtTexts.contains(thought.text))
        }
    }

    func testThoughtsReferenceGetsUpdated() {
        let retro = Retro(on: context)

        let expectedThoughts = retro.createThoughts("Hello", "Hi", "Hey")

        XCTAssertEqual(retro.thoughts.count, 3)
        for thought in expectedThoughts {
            XCTAssertTrue(retro.thoughts.contains(thought))
        }
    }

}
