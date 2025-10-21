// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SetarehWorkoutApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SetarehWorkoutApp",
            targets: ["SetarehWorkoutApp"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SetarehWorkoutApp",
            dependencies: []
        ),
        .testTarget(
            name: "SetarehWorkoutAppTests",
            dependencies: ["SetarehWorkoutApp"]
        ),
    ]
)