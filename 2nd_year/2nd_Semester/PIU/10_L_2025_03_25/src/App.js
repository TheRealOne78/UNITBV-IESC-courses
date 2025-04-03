import React, { useState, useEffect } from 'react';
import Footer from './Footer'; // Importăm componenta Footer
import Greeting from './Greeting';


function App() {
  // Aici vom face modificările pentru exerciții:
  // - Vom crea stări (count, array de items, boolean afiseazaMesaj, etc.)
  // - Vom crea input-uri, butoane, fetch în useEffect ș.a.m.d.
  // Pe moment e un conținut de bază, loc bun pentru început de laborator
  const [count, setCount] = useState(0);
  const [afiseazaMesaj, setAfiseazaMesaj] = useState(false);
  const [items, setItems] = useState(["Element 1", "Element 2", "Element 3"]);
  const [newItemText, setNewItemText] = useState("");

  function addItem() {
    if (newItemText) {
      setItems([...items, newItemText]);
      setNewItemText("");
    }
  }

  return (
    <div className="app-container">
      <h1>Bine ai venit la cursul React!</h1>
      <h2>Introducere în React</h2>
      <p>Acesta este proiectul tău React de bază. Îl vei modifica la exerciții.</p>

      <div className="content-section">
        <h2>Secțiune de conținut</h2>
        <p>
          Ești pregătit să începi să editezi componentele React și să vezi schimbările
          în timp real?
        </p>
      </div>

      {
        /*
         * Aici e locul în care vei adăuga:
         *   - un contor cu butoane +/-
         *   - un buton Arată/Ascunde
         *   - starea cu array + listă
         *   - input pentru a adăuga iteme
         *   - buton Golește lista
         *   - etc.
         * După ce termini, sub această zonă se află footer-ul.
         */

        <div>
          <p>Contor: {count}</p>
          <button onClick={() => setCount(count + 1)}>Incrementați</button>
          <button onClick={() => count > 0 ? setCount(count - 1) : null}>Decrementați</button>

          <br/><br/>
          <button onClick={() => setAfiseazaMesaj(!afiseazaMesaj)}>Arata/Ascunde mesaj</button>
          {afiseazaMesaj ? <p>Acesta este un mesaj secret!</p> : null}

          <br/>
          <br/>
          <Greeting name="Fabian"/>

          <ul>
            {items.map((item, index) => (
              <li key={index}>{item}</li>
            ))}
          </ul>

          <input
            type="text"
            value={newItemText}
            onChange={(e) => setNewItemText(e.target.value)}
            placeholder="Introduceti un item"
          />

          <button onClick={addItem}>Adauga item</button>

      </div>
      }

      <Footer />
    </div>
  );
}

export default App;
