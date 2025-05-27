import React, { useContext, useState } from 'react';
import { View, FlatList, StyleSheet } from 'react-native';
import { TextInput, Button, Text, Card, IconButton, useTheme } from 'react-native-paper';
import { TrainingContext } from '../context/TrainingContext';

const generateId = () => Date.now().toString() + Math.floor(Math.random() * 1000);

export default function HomeScreen() {
  const { trainingList, setTrainingList, historyList, setHistoryList } = useContext(TrainingContext);
  const [time, setTime]         = useState('');
  const [sessions, setSessions] = useState('');
  const { colors }              = useTheme(); // TODO: FIXME: dark theme

  const addTraining = () => {
    if (!time || !sessions) {
      alert('Please enter both time and sessions.');
      return;
    }

    const newTraining = {
      id: generateId(),
      time: parseInt(time),
      sessions: parseInt(sessions),
    };

    setTrainingList([...trainingList, newTraining]);
    setHistoryList([...historyList, newTraining]);

    setTime('');
    setSessions('');
  };

  const deleteTraining = (id) => {
    setTrainingList(trainingList.filter(item => item.id !== id));
  };

  const renderItem = ({ item }) => (
    <Card style={[styles.card, { backgroundColor: colors.surface }]}>
      <Card.Title
        title      = {`${item.time} min | ${item.sessions} sessions`}
        titleStyle = {{ color: colors.onSurface }}
        right      = {(props) => (
          <IconButton
            {...props}
            icon      = "trash-can"
            iconColor = {colors.error}
            onPress   = {() => deleteTraining(item.id)}
          />
        )}
      />
    </Card>
  );

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>
        Fitness Trainings
      </Text>

      <TextInput
        label        = "Time (min)"
        keyboardType = "numeric"
        value        = {time}
        onChangeText = {setTime}
        mode         = "outlined"
        style        = {styles.input}
      />
      <TextInput
        label        = "Sessions"
        keyboardType = "numeric"
        value        = {sessions}
        onChangeText = {setSessions}
        mode         = "outlined"
        style        = {styles.input}
      />
      <Button mode="contained" onPress={addTraining} style={styles.button}>
        Add Training
      </Button>

      <FlatList
        data               = {trainingList}
        keyExtractor       = {(item) => item.id}
        renderItem         = {renderItem}
        ListEmptyComponent = {
          <Text style={[styles.empty, { color: colors.onBackground }]}>
            No trainings.
          </Text>
        }
      />
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

  input: {
    marginBottom: 12
  },

  button: {
    marginBottom: 24
  },

  card: {
    marginBottom: 10
  },

  empty: {
    textAlign: 'center',
    marginTop: 20
  },
});
