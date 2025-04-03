import React from "react";
import Square from "Square";

const Board = () => {
  const handleClick = (id) => {
    document.getElementById(id).innerText = "X";
    alert(`Button ${id} clicked!`);
  };

    return(
      <div id="container">
        <div>
          <Square value="1"/>
        </div>
        <div>
        </div>
        <div>
        </div>
      </div>
    );
};

export default Board;
