export default {
  get name(): string {
    return 'ReactNativeLocalNetworkPermission';
  },
  check() {
    // no-op implementation
    return Promise.resolve(true);
  },
};
