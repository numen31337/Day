//
//  DayString.swift
//
//  Created by Alexander Kirsch on 2/3/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import Foundation

struct DayString: CustomStringConvertible {
	let stringValue: String
	private static let formatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd"
		return dateFormatter
	}()
	
	var day: Day { return Day(DayString.formatter.date(from: stringValue)) }
	
	init?(_ string: String) {
		guard DayString.isCorrectFormat(string) else { return nil }
		stringValue = string
	}
	
	private static func isCorrectFormat(_ string: String) -> Bool {
		guard string.count == 10 else { return false }
		
		let components = string.components(separatedBy: ".")
		guard components.count == 3 else { return false }
		
		guard let year = Int(components[0]), year > 0 else { return false }
		guard let month = Int(components[1]), month > 0, month < 13 else { return false }
		guard let day = Int(components[2]), day > 0, day < 32 else { return false }
		
		return true
	}
	
	var description: String { return stringValue }
}

extension Day {
    ///String representation of the current day in 0 timezone
    public var stringValue: String {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self.rawValue)
        let dayString = "\(String(format: "%04d", components.year!)).\(String(format: "%02d", components.month!)).\(String(format: "%02d", components.day!))"
		
		return DayString(dayString)!.stringValue
    }
}
