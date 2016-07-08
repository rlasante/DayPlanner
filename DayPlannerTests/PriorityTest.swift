//
//  PriorityTest.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 6/27/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import XCTest
@testable import DayPlanner

class PriorityTest: XCTestCase {

    func testInvalidString() {
        XCTAssertNil(Priority(stringValue: "This is not a priority"))
    }

    func testPriorityParsingLow() {
        XCTAssertEqual(Priority(stringValue: "low"), .low)
    }

    func testPriorityParsingMedium() {
        XCTAssertEqual(Priority(stringValue: "medium"), .medium)
    }

    func testPriorityParsingHigh() {
        XCTAssertEqual(Priority(stringValue: "high"), .high)
    }

    func testPriorityParsingExtreme() {
        XCTAssertEqual(Priority(stringValue: "extreme"), .extreme)
    }

    func testAllPriorityParsing() {
        let priorities: [Priority] = [.low, .medium, .high, .extreme]
        for priority in priorities {
            switch(priority) {
            case .low:
                fallthrough
            case .medium:
                fallthrough
            case .high:
                fallthrough
            case .extreme:
                print("Successfully compiled because we have a test for each")
            }
        }
    }
}