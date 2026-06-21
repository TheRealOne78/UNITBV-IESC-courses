import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, useTheme } from 'react-native-paper';

export default function AbsScreen() {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>
        Abdomens Workout Guide
      </Text>
      <Text style={{ color: colors.onBackground }}>
        Build core strength and definition with ab exercises:{"\n\n"}
        - Crunches{"\n"}
        - Planks (front and side){"\n"}
        - Leg raises{"\n"}
        - Mountain climbers{"\n\n"}
        Stay consistent and combine with cardio + clean eating.
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
