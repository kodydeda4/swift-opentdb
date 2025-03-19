// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "swift-opentdb",
  platforms: [
    .iOS(.v15),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(name: "OpenTDB", targets: ["OpenTDB"])
  ],
  targets: [
    .target( name: "OpenTDB"),
  ]
)
