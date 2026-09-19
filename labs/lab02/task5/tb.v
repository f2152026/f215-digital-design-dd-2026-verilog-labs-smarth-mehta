module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  integer a_val;
  integer b_val;
  integer op_val;
  integer errors;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  initial begin
    errors = 0;

    for (op_val = 0; op_val < 2; op_val = op_val + 1) begin
      for (a_val = 0; a_val < 16; a_val = a_val + 1) begin
        for (b_val = 0; b_val < 16; b_val = b_val + 1) begin

          t_a = a_val;
          t_b = b_val;
          t_op = op_val;

          #1;

          if (op_val == 0) begin
            if (t_result !== ((a_val + b_val) & 4'hF)) begin
              $display("FAIL ADD: a=%d b=%d expected=%d got=%d",
                       a_val, b_val,
                       ((a_val + b_val) & 4'hF),
                       t_result);
              errors = errors + 1;
            end
          end
          else begin
            if (t_result !== ((a_val - b_val) & 4'hF)) begin
              $display("FAIL SUB: a=%d b=%d expected=%d got=%d",
                       a_val, b_val,
                       ((a_val - b_val) & 4'hF),
                       t_result);
              errors = errors + 1;
            end
          end

        end
      end
    end

    if (errors == 0)
      $display("PASS: All 512 tests passed.");
    else
      $display("FAIL: %0d tests failed.", errors);

    $finish;
  end

endmodule
