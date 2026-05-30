# React Native Local Network Permission

A library to handle the local network permission introduced with iOS 14. It is only relevant for iOS, not for Android or
web.

## Getting started

Add this library to your project:

`npm install @generac/react-native-local-network-permission`

`yarn add @generac/react-native-local-network-permission`

### Using Swift Package Manager (Expo SDK 56+)

This module ships with both a CocoaPods podspec and a `Package.swift`. If your app uses Expo's precompiled-modules pipeline (`EXPO_USE_PRECOMPILED_MODULES=1`), Expo's autolinking picks up `spm.config.json` automatically — no extra setup needed.

To add this module to a non-Expo Swift project directly:

1. In Xcode, choose **File → Add Package Dependencies…**
2. Enter the repository URL: `https://github.com/neurio/react-native-local-network-permission`
3. Select the version range and add `ReactNativeLocalNetworkPermission` to your target.

The `.podspec` integration path remains supported for all CocoaPods-based React Native apps and is the default for SDK ≤ 55.

### iOS manual configuration

#### NSLocalNetworkUsageDescription

You need to add the `NSLocalNetworkUsageDescription` key to your `Info.plist` file. This should be a description of why
your app needs Local Network permissions:

```
<key>NSLocalNetworkUsageDescription</key>
<string>App requires local network access to do ...</string>
```

_See
also: [Apple documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocalnetworkusagedescription)_

#### NSBonjourServices

You need to add the `NSBonjourServices` key to your `Info.plist` file. This should be an array of Bonjour services that
your app uses:

```
<key>NSBonjourServices</key>
<array>
  <string>_bonjour._tcp</string>
  <string>_lnp._tcp.</string>
</array>
```

_See
also: [Apple documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nsbonjourservices)_

#### Expo

If you are using the Expo managed workflow, you cannot directly edit your `Info.plist`. Instead, you can add the
following to your `app.json` or `app.config.js`:

```
expo: {
  ios: {
    infoPlist: {
      NSLocalNetworkUsageDescription: 'App requires local network access to do ...',
      NSBonjourServices: ['_bonjour._tcp', '_lnp._tcp.'],
    },
  },
}
```

## Usage

This library can be used in both React Native and Expo projects. Note however:
- If using Expo, you need to [create a development build](https://docs.expo.dev/develop/development-builds/create-a-build/), using the Expo Go app will not work;
- If using bare React Native, you need to add Expo modules to your project, see [Expo documentation](https://docs.expo.dev/bare/installing-expo-modules/).

```typescript
import {
  checkLocalNetworkAccess,
  requestLocalNetworkAccess,
} from '@generac/react-native-local-network-permission';

//you need to make sure the local network permission dialog popup once
const result = await requestLocalNetworkAccess();

//then use checkLocalNetworkAccess when you need
const result = await checkLocalNetworkAccess();
//here run the code depends local network access
```

## Jest mocking

If you need to mock this library in your Jest tests, you can use the following code in your `testSetup.ts` file which
you need to reference in your `jest.config.js` under `setupFilesAfterEnv`:

```javascript
jest.mock('@generac/react-native-local-network-permission', () => ({
    checkLocalNetworkAccess: jest.fn(),
    requestLocalNetworkAccess: jest.fn(),
  }),
);
```

## Commit messages

This repository uses a [commit message convention](https://github.com/conventional-changelog/conventional-changelog)
which is enforced by a pre-commit hook. If you execute `npm run commit` instead of `git commit -m "some message"` you
will be guided through the steps to write an acceptable commit message.

It is important that you do this properly, because
the [semantic-release](https://github.com/semantic-release/semantic-release) automation depends on the commit messages
to be starting with the proper keyword to determine if a major, minor or
patch [semantic version](https://semver.org/) should be assigned.

## See also

- [Apple FAQ 1](https://developer.apple.com/forums/thread/663858)
- [Apple FAQ 2](https://developer.apple.com/forums/thread/663874)
- [Stackoverflow inspiration for this library](https://stackoverflow.com/questions/63940427/ios-14-how-to-trigger-local-network-dialog-and-check-user-answer/67758105#67758105)
