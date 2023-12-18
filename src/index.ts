// Import the native module. On web, it will be resolved to ReactNativeLocalNetworkPermissionModule.web.ts
// and on native platforms to ReactNativeLocalNetworkPermissionModule.PLATFORM.ts
import ReactNativeLocalNetworkPermissionModule from './ReactNativeLocalNetworkPermissionModule';

/**
 * The following function also will trigger the local network permission dialog if it did not show up before.
 *
 * If the permission was not granted, the result will be false.
 * If the permission was granted, the result will be true.
 *
 * NOTE: This function is only applicable to iOS, on other platforms nothing will happen.
 */
export const checkLocalNetworkAccess = (): Promise<boolean> => {
  return ReactNativeLocalNetworkPermissionModule.check();
};

/**
 * The following function will trigger the local network permission dialog if it did not show up before.
 */
export const requestLocalNetworkAccess = async () => {
  try {
    await checkLocalNetworkAccess();
    return Promise.resolve();
  } catch (error) {
    // eslint-disable-next-line no-console
    console.warn(`requestLocalNetworkAccess ${JSON.stringify(error)}`);
  }
};
