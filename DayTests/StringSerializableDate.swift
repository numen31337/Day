//
//  DayTests.swift
//  DayTests
//
//  Created by Alexander Kirsch on 11/22/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import XCTest
@testable import Day

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
        let dayString = DayString("2018.11.04")!.day.rawValue
        XCTAssertEqual(correctResultDate, dayString)
    }
    
    func testDayTimeFromString() {
        let correctResultDate = formatter.date(from: "2018.11.04 11:10")
        let dayString = DayTimeString("2018.11.04.11.10")!.date
        XCTAssertEqual(correctResultDate, dayString)
    }
    
    func testStringFromDay() {
        let date = formatter.date(from: "2018.11.04 11:10")!
        let string = DayString(date).stringValue
        XCTAssertEqual(string, "2018.11.04")
    }
    
    func testStringFromDayTime() {
        let date = formatter.date(from: "2018.11.04 11:10")!
        let string = DayTimeString(date).stringValue
        XCTAssertEqual(string, "2018.11.04.11.10")
    }
    
    func testDayStringFail() {
        let failedValue = DayTimeString("2018+11+04")
        XCTAssertNil(failedValue)
    }
    
    func testDayTimeStringFail() {
        let failedValue = DayTimeString("2018.11.04+11:10")
        XCTAssertNil(failedValue)
    }
}
