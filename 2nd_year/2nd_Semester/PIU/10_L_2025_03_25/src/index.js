import React from 'react';
import ReactDOM from 'react-dom/client';
import './style.css';   // Importăm stilurile globale
import App from './App'; // Componenta principală

// Luăm div-ul cu id "root" din index.html
const rootElement = document.getElementById('root');

// Creăm o "rădăcină" React
const root = ReactDOM.createRoot(rootElement);

// Randăm aplicația React (componenta App) în acel div
root.render(<App />);
