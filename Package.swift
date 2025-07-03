// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Day",
    platforms: [
        .iOS(.v9),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "Day",
            targets: ["Day"]
        ),
    ],
    targets: [
        .target(
            name: "Day",
            path: "Day",
            sources: [
                "Day.swift",
                "DaySeeking.swift",
                "StringSerializableDate.swift",
                "SwiftlyLRU.swift"
            ]
        ),
        .testTarget(
            name: "DayTests",
            dependencies: ["Day"],
            path: "DayTests"
        )
    ]
)