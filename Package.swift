// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "swift-opentdb",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "OpenTDB", targets: ["OpenTDB"])
  ],
  targets: [
    .target( name: "OpenTDB"),
  ]
)
