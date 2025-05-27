import React, { useState, useRef } from 'react';
import { View, FlatList, StyleSheet } from 'react-native';
import { Text, Button, useTheme } from 'react-native-paper';

export default function TimerScreen() {
  const [time, setTime]       = useState(0);
  const [running, setRunning] = useState(false);
  const [laps, setLaps]       = useState([]);
  const intervalRef           = useRef(null);
  const { colors }            = useTheme(); // TODO: FIXME: dark theme

  const startTimer = () => {
    if (!running) {
      setRunning(true);
      intervalRef.current = setInterval(() => {
        setTime(prev => prev + 1);
      }, 1000);
    }
  };

  const pauseTimer = () => {
    clearInterval(intervalRef.current);
    setRunning(false);
  };

  const resetTimer = () => {
    clearInterval(intervalRef.current);
    setRunning(false);
    setTime(0);
    setLaps([]);
  };

  const recordLap = () => setLaps([...laps, time]);

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>⏱ Timer</Text>
      <Text variant="displayMedium" style={[styles.time, { color: colors.onBackground }]}>
        {time}s
      </Text>

      <View style={styles.buttonRow}>
        <Button mode="outlined" onPress={startTimer}>Start</Button>
        <Button mode="outlined" onPress={pauseTimer}>Pause</Button>
        <Button mode="outlined" onPress={recordLap}>Lap</Button>
        <Button mode="contained-tonal" onPress={resetTimer}>Reset</Button>
      </View>

      <FlatList
        data         = {laps}
        keyExtractor = {(_, index)        => index.toString()}
        renderItem   = {({ item, index }) => (
          <Text style={[styles.lap, { color: colors.onBackground }]}>
            Lap {index + 1}: {item}s
          </Text>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    alignItems: 'center'
  },

  header: {
    marginBottom: 20
  },

  time: {
    marginBottom: 20
  },

  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '100%',
    marginBottom: 30,
    gap: 8,
  },

  lap: {
    fontSize: 16,
    marginBottom: 5
  },
});
