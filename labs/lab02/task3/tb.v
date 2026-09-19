module tb;

  reg  [1:0] t_A, t_B;
  wire       t_GT, t_LT, t_EQ;

  integer i, j;
  integer errors;

  comp2 DUT (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  initial begin
    errors = 0;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin

        t_A = i;
        t_B = j;
        #1;

        if ((t_GT !== (i > j)) ||
            (t_LT !== (i < j)) ||
            (t_EQ !== (i == j))) begin

          $display("FAIL: A=%b B=%b | GT=%b LT=%b EQ=%b",
                   t_A, t_B, t_GT, t_LT, t_EQ);

          errors = errors + 1;
        end

      end
    end

    if (errors == 0)
      $display("PASS: All 16 combinations passed.");
    else
      $display("FAIL: %0d combinations failed.", errors);

    $finish;
  end

endmodule