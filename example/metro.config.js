// Learn more https://docs.expo.io/guides/customizing-metro
const { getDefaultConfig } = require('expo/metro-config');
const path = require('path');

const projectRoot = __dirname;
const workspaceRoot = path.resolve(projectRoot, '..');

const config = getDefaultConfig(projectRoot);

// Block the parent's copies of react / react-native so the example always uses its own.
config.resolver.blockList = [
  ...Array.from(config.resolver.blockList ?? []),
  new RegExp(path.resolve(workspaceRoot, 'node_modules', 'react') + '/.*'),
  new RegExp(path.resolve(workspaceRoot, 'node_modules', 'react-native') + '/.*'),
];

config.resolver.nodeModulesPaths = [
  path.resolve(projectRoot, 'node_modules'),
  path.resolve(workspaceRoot, 'node_modules'),
];

// Resolve `react-native-local-network-permission` to the workspace root for local development.
config.resolver.extraNodeModules = {
  'react-native-local-network-permission': workspaceRoot,
};

config.watchFolders = [workspaceRoot];

module.exports = config;
