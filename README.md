# Day
![Platform](https://img.shields.io/cocoapods/p/AKVideoImageView.svg)
![CocoaPods](https://img.shields.io/cocoapods/l/AKVideoImageView.svg)
[![CI](https://github.com/numen31337/Day/actions/workflows/swift.yml/badge.svg?branch=master)](https://github.com/numen31337/Day/actions/workflows/swift.yml)

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
let serializedString = day.serializedDayString //A serialized string value
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

## Swift Package Manager
Add Day to your *Package.swift*:

```swift
.package(url: "https://github.com/numen31337/Day.git", from: "1.2.0")
```

Then include `Day` as a dependency for your target.

## CocoaPods

Add the pod to your *Podfile*:

```ruby
pod 'Day', '~> 1.2'
```