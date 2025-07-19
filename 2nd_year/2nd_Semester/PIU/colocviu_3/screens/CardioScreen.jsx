import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, useTheme } from 'react-native-paper';

export default function CardioScreen() {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text style={{ color: colors.onBackground }}>
        Cardio improves heart health and burns fat.{"\n\n"}
        a. Try jogging, cycling, swimming, or brisk walking{"\n"}
        b. Mix steady-state and interval (H.I.I.T.) sessions{"\n"}
        c. Aim for 3–5 cardio sessions per week{"\n"}
        d. Always warm up and cool down properly{"\n"}
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
