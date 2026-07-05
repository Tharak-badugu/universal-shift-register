`timescale 1ns/1ps
`include "usr.v"
module tb_usr;
reg rst,clk,shift,load,s_in;
reg [3:0]p_in;
reg [1:0] mode;
wire s_out;
wire [3:0]p_out;

usr dut(rst,clk,shift,load,s_in,p_in,mode,s_out,p_out);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_usr);
end
always #5 clk=~clk;

initial begin
    {clk,shift,load,s_in,p_in,mode}=0; 
    rst=1; //resets the circuit
    #10;
    rst=0;  //releasing the reset

//for siso
mode=2'b00;
shift=1'b1;
s_in=1; #10;
s_in=1; #10;
s_in=0; #10;
s_in=0;
#50; // extra time to see the output
shift=1'b0;  #10;
//for sipo
rst=1; #10;  // resetting the circuit

rst=0; 
mode=2'b01; shift=1'b1;
s_in=1; #10;
s_in=1; #10;
s_in=0; #10;
s_in=0; 
#50;         // extra time to see the output
shift=1'b0;  #10;
//for piso
rst=1; #10;  // resetting the circuit

rst=0; mode=2'b10;
p_in=4'b1100; 
load=1'b1; // to load the parallel input
#10;
load=1'b0;  // off to avoid overriding the parallel input
shift=1'b1;  // shifting the parallel input to serial output
#50;
shift=1'b0; load=1'b0;
#10;
rst=1; #10;  //reset

//for pipo
rst=0; mode=2'b11; load=1'b1; p_in=4'b1100;
#50;
$finish;
end

endmodule

