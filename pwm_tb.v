module pwm_tb;

reg clk,reset;
wire dout;

pwm p1(clk,reset,dout);

always #5 clk = ~clk;

initial begin
clk = 0;
reset = 1'b1;
#10;
reset = 1'b0;
end
endmodule
