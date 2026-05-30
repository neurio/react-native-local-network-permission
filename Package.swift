// swift-tools-version:5.9
//
// This Package.swift is forward-compatibility scaffolding for the React Native
// SPM migration outlined in RFC 0994:
//   https://github.com/react-native-community/discussions-and-proposals/pull/994
//
// The RN CLI's SPM autolinking (and Expo's `et prebuild` pipeline that consumes
// `spm.config.json`) is the supported install path. When the autolinking
// pipeline lands, the consumer app's generated `Package.swift` provides the
// `expo-modules-core` package, so this manifest only declares the
// `ExpoModulesCore` product by name — it does not pin a source.
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
