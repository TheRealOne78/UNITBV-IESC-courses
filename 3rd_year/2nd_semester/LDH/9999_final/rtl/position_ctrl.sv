module position_ctrl #(
                       parameter int DISPLAYS = 6,
                       parameter int X_RAW_PER_COLUMN = 64
                       )
   (
    input  logic signed [9:0]            accel_x_i,
    input  logic signed [9:0]            accel_y_i,
    output logic                         row_o,
    output logic [$clog2(DISPLAYS)-1:0]  col_o
    );

   localparam int ZERO_COLUMN           = (DISPLAYS - 1) / 2;
   localparam int LAST_COLUMN           = DISPLAYS - 1;
   localparam int X_RAW_PER_COLUMN_SAFE = (X_RAW_PER_COLUMN > 0) ? X_RAW_PER_COLUMN : 1;

   integer accel_x_int;
   integer accel_y_int;
   integer raw_x_steps;
   integer col_index;

   always_comb begin
      accel_x_int = { {22{accel_x_i[9]}}, accel_x_i };
      accel_y_int = { {22{accel_y_i[9]}}, accel_y_i };

      // One display column is crossed every X_RAW_PER_COLUMN raw X units.
      raw_x_steps = accel_x_int / X_RAW_PER_COLUMN_SAFE;

      // Positive X tilt should move the bubble toward lower-index displays.
      col_index = ZERO_COLUMN - raw_x_steps;

      if (col_index < 0)
        col_o = '0;
      else if (col_index > LAST_COLUMN)
        col_o = $clog2(DISPLAYS)'(LAST_COLUMN);
      else
        col_o = $clog2(DISPLAYS)'(col_index);

      row_o = (accel_y_int > 0);
   end

endmodule : position_ctrl
