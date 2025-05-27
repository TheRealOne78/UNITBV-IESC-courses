// App.js

import React from 'react';
import 'react-native-gesture-handler';
import { NavigationContainer } from '@react-navigation/native';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { Provider as PaperProvider } from 'react-native-paper';
import { TrainingProvider } from './context/TrainingContext';

import HomeScreen from './screens/HomeScreen';
import WorkoutHistoryScreen from './screens/WorkoutHistoryScreen';
import StepCounterScreen from './screens/StepCounterScreen';
import TimerScreen from './screens/TimerScreen';
import BMIScreen from './screens/BMIScreen';
import SquatsScreen from './screens/SquatsScreen';
import AbsScreen from './screens/AbsScreen';
import DietScreen from './screens/DietScreen';
import CardioScreen from './screens/CardioScreen';
import RecoveryScreen from './screens/RecoveryScreen';

const Drawer = createDrawerNavigator();

export default function App() {
  return (
    <PaperProvider>
      <TrainingProvider>
        <NavigationContainer>
          <Drawer.Navigator initialRouteName="Home">
            <Drawer.Screen name="Home" component={HomeScreen} />
            <Drawer.Screen name="Workout History" component={WorkoutHistoryScreen} />
            <Drawer.Screen name="Step Counter" component={StepCounterScreen} />
            <Drawer.Screen name="Timer" component={TimerScreen} />
            <Drawer.Screen name="BMI" component={BMIScreen} />
            <Drawer.Screen name="Squats" component={SquatsScreen} />
            <Drawer.Screen name="Abs" component={AbsScreen} />
            <Drawer.Screen name="Diet" component={DietScreen} />
            <Drawer.Screen name="Cardio" component={CardioScreen} />
            <Drawer.Screen name="Recovery" component={RecoveryScreen} />

          </Drawer.Navigator>
        </NavigationContainer>
      </TrainingProvider>
    </PaperProvider>
  );
}
