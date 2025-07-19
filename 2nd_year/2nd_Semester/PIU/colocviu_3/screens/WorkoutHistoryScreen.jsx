import React, { useContext } from 'react';
import { View, FlatList, StyleSheet } from 'react-native';
import { Text, Card, useTheme } from 'react-native-paper';
import { TrainingContext } from '../context/TrainingContext';

export default function WorkoutHistoryScreen() {
  const { historyList } = useContext(TrainingContext);
  const { colors }      = useTheme(); // TODO: FIXME: dark theme

  const renderItem = ({ item }) => (
    <Card style={[styles.card, { backgroundColor: colors.surface }]}>
      <Card.Content>
        <Text variant="bodyLarge" style={{ color: colors.onSurface }}>
          {item.time} minutes - {item.sessions} sessions
        </Text>
      </Card.Content>
    </Card>
  );

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <FlatList data               = {historyList}
                keyExtractor       = {(item) => item.id}
                renderItem         = {renderItem}
                ListEmptyComponent = {
                  <Text style={[styles.empty, { color: colors.onBackground }]}>
                    Emtpy history ...
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

  card: {
    marginBottom: 10
  },

  empty: {
    textAlign: 'center',
    marginTop: 20
  },
});
