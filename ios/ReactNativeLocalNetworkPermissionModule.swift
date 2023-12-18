import ExpoModulesCore

public final class ReactNativeLocalNetworkPermissionModule: Module {
    
    public func definition() -> ModuleDefinition {
        Name("ReactNativeLocalNetworkPermission")

        AsyncFunction("check") { (promise: Promise) in
            if #available(iOS 14.0, *) {
                let authorizationInstance = LocalNetworkAuthorization()
                
                authorizationInstance.requestAuthorization { (isAuthorized) in
                    if isAuthorized {
                        promise.resolve(true)
                    } else {
                        promise.resolve(false)
                    }
                }
            } else {
                // if iOS is lower than 14.0, no local network permission is needed and we always return true
                promise.resolve(true)
            }
        }
    }
}
