// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PLC",
    products: [
        .library(name: "FormulaSolver", targets: [
            "FormulaSolver"
        ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "FormulaSolver"),
        .testTarget(name: "FormulaSolverTests",
                    dependencies: [.target(name: "FormulaSolver")],
                    path: "Tests/FormulaSolverTests"
                   ),
        .executableTarget(
            name: "FST", // Formula Solver Tool
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "FormulaSolver")
            ]
        ),
    ]
)
