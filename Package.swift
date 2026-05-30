// swift-tools-version:5.9
//
// This Package.swift is forward-compatibility scaffolding for the React Native
// SPM migration outlined in RFC 0994:
//   https://github.com/react-native-community/discussions-and-proposals/pull/994
//
// The RN CLI's SPM autolinking (and Expo's `et prebuild` pipeline that consumes
// `spm.config.json`) is the supported install path. The expo-modules-core
// dependency below points at the standard React Native / Expo `node_modules`
// layout (`../expo-modules-core` relative to this package). That matches the
// shape RFC 0994's autolinking generates and works whenever this package is
// resolved as a local SPM package alongside a node_modules tree.
//
// Platform floor is iOS 14: that is when `NWBrowser` / local network
// permission first exist. Bumping it would be an unnecessary breaking change
// for downstream apps still on the CocoaPods path.

import PackageDescription

let package = Package(
  name: "ReactNativeLocalNetworkPermission",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "ReactNativeLocalNetworkPermission",
      targets: ["ReactNativeLocalNetworkPermission"]
    )
  ],
  dependencies: [
    .package(name: "expo-modules-core", path: "../expo-modules-core")
  ],
  targets: [
    .target(
      name: "ReactNativeLocalNetworkPermission",
      dependencies: [
        .product(name: "ExpoModulesCore", package: "expo-modules-core")
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
