const SudokuCell = ({ index, cellValue }) => {
  let isImutable = false;
  let myCellValue = cellValue;

  let hasConflict = false;

  if (cellValue !== 0)
    isImutable = true;

  if (cellValue === 0)
    myCellValue = null;
  else
    myCellValue = cellValue;

  const handleChange = (e) => {
    if (!isImutable)
      myCellValue = e.target.value;
  };

  return (
    <div key={index} className="sudoku-cell">
      <input type="text" value={myCellValue} className="sudoku-cell" onChange={handleChange}/>
    </div>
  );
};

export default SudokuCell;
