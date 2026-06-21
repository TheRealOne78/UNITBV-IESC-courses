import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, useTheme } from 'react-native-paper';

export default function RecoveryScreen() {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text style={{ color: colors.onBackground }}>
        Recovery is where your body grows stronger.{"\n\n"}
        * Sleep 7–9 hours/night{"\n"}
        * Include rest days to prevent burnout{"\n"}
        * Try stretching, foam rolling, or yoga{"\n"}
        * Eat well and hydrate after workouts{"\n"}
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20
  },

  header: {
    marginBottom: 20,
    textAlign: 'center'
  },
});
