import React, { useState, useEffect } from 'react';
import Footer from './Footer'; // Importăm componenta Footer

function App() {
  // Aici vom face modificările pentru exerciții:
  // - Vom crea stări (count, array de items, boolean afiseazaMesaj, etc.)
  // - Vom crea input-uri, butoane, fetch în useEffect ș.a.m.d.
  // Pe moment e un conținut de bază, loc bun pentru început de laborator

  return (
    <div className="app-container">
      <h1>Bine ai venit la aplicația React!</h1>
      <h2>Introducere în React</h2>
      <p>Acesta este proiectul tău React de bază. Îl vei modifica la exerciții.</p>

      <div className="content-section">
        <h2>Secțiune de conținut</h2>
        <p>
          Ești pregătit să începi să editezi componentele React și să vezi schimbările
          în timp real?
        </p>
      </div>

      {/* 
        Aici e locul în care vei adăuga:
          - un contor cu butoane +/-
          - un buton Arată/Ascunde
          - starea cu array + listă
          - input pentru a adăuga iteme
          - buton Golește lista
          - etc.
        După ce termini, sub această zonă se află footer-ul.
      */}

      <Footer />
    </div>
  );
}

export default App;
