import React, { createContext, useState } from 'react';

export const TrainingContext = createContext();

export const TrainingProvider = ({ children }) => {
  const [trainingList, setTrainingList] = useState([]); // current trainings
  const [historyList, setHistoryList] = useState([]);   // all trainings ever added

  return (
    <TrainingContext.Provider value={{
      trainingList,
      setTrainingList,
      historyList,
      setHistoryList,
    }}>
      {children}
    </TrainingContext.Provider>
  );
};
