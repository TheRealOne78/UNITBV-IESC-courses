import HangmanFigure from "./HangmanFigure";
import WordDisplay from "./WordDisplay";
import './styles.css';

function App() {
  return (<div>
            <HangmanFigure className="hangman-figure"/>
            <WordDisplay className="word-display"/>
         </div>);
}

export default App;
