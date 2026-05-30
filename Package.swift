// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "ReactNativeLocalNetworkPermission",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "ReactNativeLocalNetworkPermission",
      targets: ["ReactNativeLocalNetworkPermission"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/expo/expo.git", from: "56.0.0")
  ],
  targets: [
    .target(
      name: "ReactNativeLocalNetworkPermission",
      dependencies: [
        .product(name: "ExpoModulesCore", package: "expo")
      ],
      path: "ios",
      exclude: [
        "ReactNativeLocalNetworkPermission.podspec"
      ],
      sources: [
        "ReactNativeLocalNetworkPermissionModule.swift",
        "LocalNetworkAuthorization.swift"
      ],
      resources: [
        .copy("PrivacyInfo.xcprivacy")
      ],
      linkerSettings: [
        .linkedFramework("Network")
      ]
    )
  ]
)
