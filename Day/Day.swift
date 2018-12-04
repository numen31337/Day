//
//  Day.swift
//
//  Created by Alexander Kirsch on 4/15/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import Foundation

public struct Day {
    public let rawValue: Date
    
    fileprivate init(withRawValue value: Date) {
        rawValue = value
    }
    
    public init(_ date: Date? = nil) {
        let comps = Calendar.current.dateComponents([.day, .month, .year], from: date ?? Date())
        rawValue = Calendar.current.date(from: comps)!
    }
	
	public init(_ day: Day) {
		rawValue = day.rawValue
	}
}

///MARK: Helpers
extension Day {
    public var nextDay: Day { return dayBy(addingDays: 1) }
	public var prevDay: Day { return dayBy(addingDays: -1) }
	
    public func numberOfDays(sinceDay: Day) -> Int {
        if let cachedValue = DayCache.daysSinceDayCache[self]?[sinceDay] { return cachedValue }
        let days = Calendar.current.dateComponents([.day], from: sinceDay.rawValue, to: self.rawValue).day!
        DayCache.daysSinceDayCache[self] = [sinceDay : days]
        
        return days
    }
    
    public func numberOfDays(toDate: Day) -> Int {
		return toDate.numberOfDays(sinceDay: self)
    }
    
    public func dayBy(addingDays days: NSInteger) -> Day {
        if let cacheValue = DayCache.dayByAddingDays[self]?[days] { return cacheValue }
        let dayByAddingDays = Day(withRawValue: Calendar.current.date(byAdding: .day, value: days, to: self.rawValue)!)
        DayCache.dayByAddingDays[self] = [days : dayByAddingDays]
        
        return dayByAddingDays
    }
}

extension Day: Equatable {
    public static func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Day: Comparable {
    public static func <(lhs: Day, rhs: Day) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Day: Hashable {
    public var hashValue: Int { return rawValue.hashValue }
}

extension Date {
    public var dayValue: Day { return Day(self) }
}

extension DateFormatter {
    public func string(from day: Day) -> String {
        return string(from: day.rawValue)
    }
}

struct DayCache {
    ///Day -> SinceDay -> Days
    static var daysSinceDayCache = SwiftlyLRU<Day, Dictionary<Day, Int>>(capacity: 300)
    ///Day -> DaysToAdd -> Result
    static var dayByAddingDays = SwiftlyLRU<Day, Dictionary<Int, Day>>(capacity: 100)
}
