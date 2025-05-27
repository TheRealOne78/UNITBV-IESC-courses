import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, useTheme } from 'react-native-paper';

export default function SquatsScreen() {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>
         Squat Tips
      </Text>
      <Text style={{ color: colors.onBackground }}>
        Squats build leg and glute strength, and improve mobility.{"\n\n"}
        1. Keep your back straight and chest up{"\n"}
        2. Push your knees out, not in{"\n"}
        3. Lower until thighs are parallel to the ground{"\n"}
        4. Start with bodyweight, then add resistance
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
