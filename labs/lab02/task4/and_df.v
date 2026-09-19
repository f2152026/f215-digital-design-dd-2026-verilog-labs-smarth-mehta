module and_df (
  input a,
  input b,
  output wire y
);
  assign #1 y = a & b;
endmodule