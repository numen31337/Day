# Day
![Platform](https://img.shields.io/cocoapods/p/AKVideoImageView.svg)
![CocoaPods](https://img.shields.io/cocoapods/l/AKVideoImageView.svg)
[![Build Status](https://travis-ci.org/numen31337/Day.svg?branch=master)](https://travis-ci.org/numen31337/Day)

Day is the mini library to represent a Day value with serialization functionality. Mainly for private use.

## Features

- Can be created from the Date with resetting of its time components
- Serialization to the human-readable and sortable String and back
- Caching (for internal usage)
- Day seeking algorithms (primarily for my personal need)
- Convenient property for accessing next and previous day
- Day offset calculations

## Usage
Initialising:<br />
```swift
let day = Day() //Day value for the current day
let day = Day(date) //Day value from the date by dropping time components
```

Serialization:<br />
```swift
let serializedString = DayString(day).stringValue //A serialized string value
let day = Day(serializedString) //Day value from the serialized string
```

Getting a Date value from the Day value:<br />
```swift
let date = day.rawValue
```
    
Day calculations:<br />
```swift
let nextDay = day.nextDay
let previousDay = day.prevDay
let twoDaysBefore = day.dayBy(addingDays: -2)
```
    
Difference between two days:<br />
```swift
let diff = day.numberOfDays(sinceDay: day1)
let diff = day.numberOfDays(toDate: day1)
```
