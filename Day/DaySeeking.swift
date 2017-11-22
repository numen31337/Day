//
//  DaySeeking.swift
//
//  Created by Alexander Kirsch on 4/25/17.
//  Copyright © 2017 Alexander Kirsch. All rights reserved.
//

import Foundation

extension Day {
	///The maximum numbers of days to seek through
    private static let seekRangeLimit = 300
    
    ///Search for first matching day skipping row of days from start day which is matching predicate.
    ///Search starts from the NEXT day from today or NEXT day from the 'fromDay'.
    ///Example: input 'xx000xxx' with predicate == x will return 6th position day
    public static func nextDay(fromDay: Day? = nil, matchingPredicate predicate: (Day) -> Bool) -> Day? {
        var dayIterrator = fromDay ?? Day()
        
        //Calculate number of days matching current search predicate from the start point
        let itemsToSkip: Int = {
            for i in 0 ..< seekRangeLimit {
                if predicate(dayIterrator) == false { return i }
                dayIterrator = dayIterrator.nextDay
            }
            return 0
        }()
        
        //At this point we are standing on the day without searching result
        for _ in itemsToSkip ..< seekRangeLimit {
            dayIterrator = dayIterrator.nextDay
            if predicate(dayIterrator) { return dayIterrator }
        }
        
        return nil
    }
    
    ///Example: input 'xx000xxx' with predicate == x will returns 2
    ///Example: input '000xxx' with predicate == x will returns 0
    public static func rowLengthOfDays(fromDay: Day? = nil, matchingPredicate predicate: (Day) -> Bool) -> Int {
        var dayIterrator = fromDay ?? Day()
        var counter = 0
        
        while predicate(dayIterrator) {
            dayIterrator = dayIterrator.nextDay
            counter += 1
        }
        
        return counter
    }
}
