//
//  StringSerializableDate.swift
//
//  Created by Alexander Kirsch on 2/3/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import Foundation

protocol StringSerializableDate {
    var stringValue: String { get }
    static var formatter: DateFormatter { get }
    
    init?(_ string: String)
    init(_ day: Day)
    init(_ date: Date)
    static func isCorrectFormat(_ string: String) -> Bool
}

extension StringSerializableDate {
    init(_ date: Date) {
        let parsedString = Self.formatter.string(from: date)
        assert(Self.isCorrectFormat(parsedString))
        self.init(parsedString)!
    }
    
    init(_ day: Day) {
        self.init(day.rawValue)
    }
}

struct DayString: StringSerializableDate {
	let stringValue: String
    internal static let formatter: DateFormatter = {
		let dateFormatter = DateFormatter()
        //Fixes the issue when the DateFormatter returns nil when system set to 12 hours system for HH item
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy.MM.dd"
		return dateFormatter
	}()
	
	init?(_ string: String) {
		guard DayString.isCorrectFormat(string) else { return nil }
		stringValue = string
	}
    
    var day: Day { return Day(DayString.formatter.date(from: stringValue)) }
    
    internal static func isCorrectFormat(_ string: String) -> Bool {
		guard string.count == 10 else { return false }
		
		let components = string.components(separatedBy: ".")
		guard components.count == 3 else { return false }
		
		guard let year = Int(components[0]), year > 0 else { return false }
		guard let month = Int(components[1]), month > 0, month < 13 else { return false }
		guard let day = Int(components[2]), day > 0, day < 32 else { return false }
		
		return true
	}
}

struct DayTimeString: StringSerializableDate {
    let stringValue: String
    internal static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        //Fixes the issue when the DateFormatter returns nil when system set to 12 hours system for HH item
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy.MM.dd.HH.mm"
        return dateFormatter
    }()
    
    init?(_ string: String) {
        guard DayTimeString.isCorrectFormat(string) else { return nil }
        stringValue = string
    }
    
    var date: Date { return DayTimeString.formatter.date(from: stringValue)! }
    
    internal static func isCorrectFormat(_ string: String) -> Bool {
        guard string.count == 16 else { return false }
        
        let components = string.components(separatedBy: ".")
        guard components.count == 5 else { return false }
        
        guard let year = Int(components[0]), year > 0 else { return false }
        guard let month = Int(components[1]), month > 0, month < 13 else { return false }
        guard let day = Int(components[2]), day > 0, day < 32 else { return false }
        guard let hours = Int(components[3]), hours >= 0, hours < 24 else { return false }
        guard let minutes = Int(components[4]), minutes >= 0, minutes < 60 else { return false }
        
        return true
    }
}

extension Date {
    public static func date(fromSerializedDateAndTimeString string: String) -> Date? {
        return DayTimeString(string)?.date
    }
    
    public static func date(fromSerializedDay string: String) -> Date? {
        return DayString(string)?.day.rawValue
    }
    
    public var serializedDayString: String { return DayString(self).stringValue }
    
    public var serializedDayAndTimeString: String { return DayTimeString(self).stringValue }
}

extension Day {
    public init?(_ string: String) {
        guard let day = DayString(string)?.day else { return nil }
        rawValue = day.rawValue
    }
    
    public var serializedDayString: String { return DayString(self).stringValue }
}

extension Day: CustomStringConvertible {
    public var description: String { return serializedDayString }
}
