import XCTest
import Day

final class DayOperationsTests: XCTestCase {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    func testNextAndPrevDay() {
        let base = Day("2018.11.04")!
        XCTAssertEqual(base.nextDay, Day("2018.11.05")!)
        XCTAssertEqual(base.prevDay, Day("2018.11.03")!)
    }

    func testDayByAddingDays() {
        let base = Day("2018.11.04")!
        XCTAssertEqual(base.dayBy(addingDays: 7), Day("2018.11.11")!)
        XCTAssertEqual(base.dayBy(addingDays: -2), Day("2018.11.02")!)
    }

    func testNumberOfDaysBetween() {
        let start = Day("2018.11.01")!
        let end = Day("2018.11.10")!
        XCTAssertEqual(end.numberOfDays(sinceDay: start), 9)
        XCTAssertEqual(start.numberOfDays(toDate: end), 9)
    }

    func testNextDayMatchingPredicate() {
        let start = Day("2018.11.02")! // Friday
        let weekend = Day.nextDay(fromDay: start) { day in
            Calendar.current.isDateInWeekend(day.rawValue)
        }
        XCTAssertEqual(weekend, Day("2018.11.03")!)
    }

    func testRowLengthOfDaysMatchingPredicate() {
        let start = Day("2018.11.03")! // Saturday
        let length = Day.rowLengthOfDays(fromDay: start) { day in
            Calendar.current.isDateInWeekend(day.rawValue)
        }
        XCTAssertEqual(length, 2) // Saturday and Sunday
    }
}