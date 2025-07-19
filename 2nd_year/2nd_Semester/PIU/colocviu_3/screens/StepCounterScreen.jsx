import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, Button, useTheme } from 'react-native-paper';

export default function StepCounter() {
  const [steps, setSteps] = useState(0);
  const { colors }        = useTheme(); // TODO: FIXME: dark theme

  const addSteps = () => setSteps(steps + 100);

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="displaySmall" style={[styles.stepCount, { color: colors.onBackground }]}>
        {steps} steps
      </Text>
      <Button mode="contained" onPress={addSteps}>Add 100 more steps</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
    alignItems: 'center'
  },

  header: {
    marginBottom: 20
  },

  stepCount: {
    marginBottom: 30
  },
});
