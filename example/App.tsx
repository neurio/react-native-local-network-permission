import React, { useState } from 'react';
import { Pressable, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import * as ReactNativeLocalNetworkPermission from 'react-native-local-network-permission';

export default function App() {
  const [isPermissionGranted, setIsPermissionGranted] = useState<boolean | undefined>(undefined);
  const [result, setResult] = useState<string>('');

  const handlePermissionRequested = () => {
    const permission = async () => {
      await ReactNativeLocalNetworkPermission.requestLocalNetworkAccess();
    };

    permission().catch((e) => {
      console.log(e);
      setResult(JSON.stringify(e, null, 2));
    });
  };

  const handleCheckPermission = () => {
    const permission = async () => {
      const hasLocalNetworkAccess = await ReactNativeLocalNetworkPermission.checkLocalNetworkAccess();
      setResult(JSON.stringify(hasLocalNetworkAccess, null, 2));
      if (hasLocalNetworkAccess) {
        setIsPermissionGranted(true);
      } else {
        setIsPermissionGranted(false);
      }
    };

    permission().catch((e) => {
      console.log(e);
      setResult(JSON.stringify(e, null, 2));
    });
  };

  const mapToString = (isPermissionGranted: boolean | undefined) => {
    switch (isPermissionGranted) {
      case undefined:
        return 'undetermined';
      case true:
        return 'granted';
      case false:
        return 'not granted';
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerText}>Local network permission</Text>
      </View>
      <View style={styles.mainContent}>
        {result ? (<Text>Result from Native Code: {result}</Text>) : null}
        <Text>
          Permission is: {mapToString(isPermissionGranted)}
        </Text>
      </View>
      <View style={styles.buttonsContainer}>
        <Pressable style={styles.button} onPress={handlePermissionRequested}>
          <Text style={styles.buttonText}>Request permission</Text>
        </Pressable>
        <Pressable style={styles.button} onPress={handleCheckPermission}>
          <Text style={styles.buttonText}>Check permission</Text>
        </Pressable>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  header: {
    flex: 1,
    marginTop: 30,
  },
  headerText: {
    fontSize: 20,
    textAlign: 'center',
  },
  mainContent: {
    flex: 3,
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonsContainer: {
    flex: 2,
    flexDirection: 'column',
    gap: 30,
    marginBottom: 30,
  },
  button: {
    backgroundColor: 'blue',
    padding: 20,
    borderRadius: 20,
  },
  buttonText: {
    color: 'white',
  },
});
