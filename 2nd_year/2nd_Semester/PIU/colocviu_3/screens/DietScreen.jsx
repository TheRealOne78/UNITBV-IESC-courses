import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, useTheme } from 'react-native-paper';

export default function DietScreen() {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>
        Diet and Nutrition
      </Text>
      <Text style={{ color: colors.onBackground }}>
        A good diet fuels performance and recovery.{"\n\n"}
        + Prioritize whole foods: veggies, lean protein, grains{"\n"}
        + Stay hydrated: 2–3L water/day{"\n"}
        - Avoid processed foods & sugar{"\n"}
        + Consider meal prepping to stay consistent
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
