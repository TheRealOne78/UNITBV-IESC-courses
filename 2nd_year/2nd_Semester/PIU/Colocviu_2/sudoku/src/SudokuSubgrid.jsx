import SudokuCell from './SudokuCell.jsx';

const SudokuSubgrid = ({ cells }) => {
  return (
    <div className="sudoku-subgrid">
      {cells.map((cellValue, index) => (
        <SudokuCell key={index} cellValue={cellValue} />
      ))}
    </div>
  );
};

export default SudokuSubgrid;
