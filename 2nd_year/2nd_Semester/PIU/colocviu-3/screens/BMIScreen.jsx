import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, TextInput, Button, Card, useTheme } from 'react-native-paper';

export default function BMIScreen() {
  const [weight, setWeight]     = useState('');
  const [height, setHeight]     = useState('');
  const [bmi, setBmi]           = useState(null);
  const [category, setCategory] = useState('');
  const { colors }              = useTheme(); // TODO: FIXME: dark theme

  const calculateBMI = () => {
    const w = parseFloat(weight);
    const h = parseFloat(height) / 100;

    if (!w || !h) return;

    const bmiValue = (w / (h * h)).toFixed(1);
    setBmi(bmiValue);

    if (bmiValue < 18.5)
      setCategory('Underweight');
    else if (bmiValue < 24.9)
      setCategory('Normal');
    else if (bmiValue < 29.9)
      setCategory('Overweight');
    else
      setCategory('Obese killing whale WTF!!!!!!!!!!!!!!!!!');
  };

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text variant="titleLarge" style={[styles.header, { color: colors.onBackground }]}>
        Body Mass Index (BMI) Calculator
      </Text>

      <TextInput
        label        = "Weight"
        value        = {weight}
        onChangeText = {setWeight}
        keyboardType = "numeric"
        mode         = "outlined"
        style        = {styles.input}
      />

      <TextInput
        label        = "Height"
        value        = {height}
        onChangeText = {setHeight}
        keyboardType = "numeric"
        mode         = "outlined"
        style        = {styles.input}
      />

      <Button mode="contained" onPress={calculateBMI}>Calculate</Button>

      {bmi && (
        <Card style={[styles.result, { backgroundColor: colors.surface }]}>
          <Card.Content>
            <Text variant="headlineMedium" style={{ color: colors.onSurface }}>
              BMI: {bmi}
            </Text>
            <Text variant="bodyLarge" style={{ color: colors.onSurface }}>
              Category: {category}
            </Text>
          </Card.Content>
        </Card>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20
  },

  header: {
    textAlign: 'center',
    marginBottom: 20
  },

  input: {
    marginBottom: 12
  },

  result: {
    marginTop: 20,
    padding: 10
  },
});
