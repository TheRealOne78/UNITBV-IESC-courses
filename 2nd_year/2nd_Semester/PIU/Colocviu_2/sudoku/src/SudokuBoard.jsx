import SudokuSubgrid from './SudokuSubgrid.jsx';
import './Styles.css'

const SudokuBoard = ({ board }) => {
  const subgrids = [];

  for (let blockRow = 0; blockRow < 3; blockRow++) {
    for (let blockCol = 0; blockCol < 3; blockCol++) {
      let subgridCells = [];

      for (let row = 0; row < 3; row++) {
        for (let col = 0; col < 3; col++) {
          let value = board[blockRow * 3 + row][blockCol * 3 + col];
          subgridCells.push(value);
        }
      }

      subgrids.push(subgridCells);
    }
  }

  return (
    <div className="sudoku-board">
    {subgrids.map((cells, index) => (
      <SudokuSubgrid key={index} cells={cells}/>
    ))}
    </div>
  );
};

export default SudokuBoard;
