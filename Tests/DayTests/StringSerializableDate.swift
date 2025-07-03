//
//  DayTests.swift
//  DayTests
//
//  Created by Alexander Kirsch on 11/22/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import XCTest
import Day

class DayTests: XCTestCase {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDayFromString() {
        let correctResultDate = formatter.date(from: "2018.11.04 00:00")
        let dayString = Day("2018.11.04")!.rawValue
        let dateString = Date.date(fromSerializedDay: "2018.11.04")
        
        XCTAssertEqual(correctResultDate, dayString)
        XCTAssertEqual(correctResultDate, dateString)
    }
    
    func testDayTimeFromString() {
        let correctResultDate = formatter.date(from: "2018.11.04 11:10")
        let dayString = Date.date(fromSerializedDateAndTimeString: "2018.11.04.11.10")
        
        XCTAssertEqual(correctResultDate, dayString)
    }
    
    func testDayString() {
        let date = formatter.date(from: "2018.11.04 11:10")!
        let stringFromDay = Day(date).serializedDayString
        let stringFromDate = date.serializedDayString
        
        XCTAssertEqual(stringFromDay, "2018.11.04")
        XCTAssertEqual(stringFromDate, "2018.11.04")
    }

    func testStringFromDayTime() {
        let date = formatter.date(from: "2018.11.04 11:10")!
        let string = date.serializedDayAndTimeString
        XCTAssertEqual(string, "2018.11.04.11.10")
    }

    func testDayStringInitFail() {
        let failedValue = Day("2018+11+04")
        XCTAssertNil(failedValue)
    }

    func testDateStringInitFail() {
        let failedValue1 = Date.date(fromSerializedDateAndTimeString: "2018.11.04+11:10")
        let failedValue2 = Date.date(fromSerializedDay: "2018+11+04")
        
        XCTAssertNil(failedValue1)
        XCTAssertNil(failedValue2)
    }
    
    func testDayDescription() {
        XCTAssertEqual("\(String(describing: Day("2018.11.04")!))", "2018.11.04")
        XCTAssertEqual(Day("2018.11.04")!.description, "2018.11.04")
    }

    func testDayTimeStringInvalidFormat() {
        let invalidHour = Date.date(fromSerializedDateAndTimeString: "2018.11.04.25.00")
        let invalidMinute = Date.date(fromSerializedDateAndTimeString: "2018.11.04.10.61")

        XCTAssertNil(invalidHour)
        XCTAssertNil(invalidMinute)
    }

}
