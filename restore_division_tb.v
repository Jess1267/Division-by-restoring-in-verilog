`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2024 20:23:28
// Design Name: 
// Module Name: restore_division_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module restore_division_tb;

reg clk,start;
reg [4:0]data_in;
wire e;
//wire [4:0]out;
//restore_division dut (,clk,start,data_in);
restore_division dut (e,clk,start,data_in);

initial
begin
    clk=1'b0;
    #3 start=1'b1;
    #300 $finish;
end

always #5 clk=~clk;

initial
begin
    #12 data_in=4'b0011;
    #10 data_in=4'b0101;
    #10 data_in=4'b0100;
end

endmodule
