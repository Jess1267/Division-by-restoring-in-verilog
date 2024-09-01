`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2024 11:25:45
// Design Name: 
// Module Name: restore_division
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

module shift_a (data_out, clk,cl,shift,ld,a,data_in);
//parameter N=4;
input clk,cl,shift,ld,a;
input [4:0]data_in;
output reg [4:0]data_out;

always @(posedge clk)
begin
    if(cl)data_out<=0;
    else if(shift)data_out<={data_in[3:1],a};
    else if(ld)data_out<=data_in;
end

endmodule

module shift_q (data_out, ld,shift,clk,update,data_in);
input ld,shift,clk,update;
input [4:0]data_in;
output reg [4:0]data_out;

always @(posedge clk)
begin
    if(ld)data_out<=data_in;
    else if(shift)data_out<={data_in[4],data_in[2:0],update};
end
endmodule

module shift_b (data_out, clk,ld,data_in);
input ld,clk;
input [4:0]data_in;
output reg [4:0]data_out;

always @(posedge clk)
begin
    if(ld)data_out<=data_in;
end
endmodule

module adder (out,a,b);
input [4:0]a,b;
output reg [4:0]out;

always @(*)
begin
    out<=a+b;
end

endmodule

module bcomp (out,in);
input [4:0]in;
output reg [4:0]out;

always @(in)
begin
    out<=(~in)+1;
end

endmodule

module mux(out,sel,x1,x2);
input sel;
input [3:0]x1,x2;
output reg [3:0]out;

always @(sel)
begin
    if(sel)out<=x1;
    else out<=x2;
end

endmodule

module count (out,in,dec,ld);
input dec,ld;
input [3:0]in;
output reg [3:0]out;

always @(dec,ld)
begin
    if(ld)out<=in;
    else if(dec)out<=out-1;
end
endmodule


module data_path(comp,comp1, 
            data_in,clk, cl_a,shift_a,ld_a,  ld_q,shift_q,update_q, ld_b, sel, ld_count, dec_count);

input clk,cl_a,shift_a,ld_a,
        ld_q,shift_q,update_q,
        ld_b,
        sel,
        ld_count, dec_count;
input [4:0]data_in;

output comp,comp1;

wire [4:0]A,B,X,Q,Bcom,Y,C;

assign comp1=~|C;
assign comp=A[4];

shift_a a (A,clk,cl_a,shift_a,ld_a,Q[3],X);
shift_q q (Q,ld_q,shift_q,clk,update_q,data_in);
shift_b b (B,clk,ld_b,data_in);
adder add (X,A,Y);
bcomp bc (Bcom,B);
mux m (Y,sel,B,Bcomp);

count c (C,data_in,ld_count,dec_count);

endmodule

module control_path(cl_a,shift_a,ld_a,ld_q,shift_q,update_q,ld_b,sel,ld_count,dec_count,e,   start,comp,a,clk);
input start,comp,a,clk;
output reg cl_a,shift_a,ld_a,ld_q,shift_q,update_q,ld_b,sel,ld_count,dec_count,e;

reg [3:0]state;
parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=4'b0100,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=4'b1000,s9=4'b1001,s10=4'b1010;

always @(posedge clk)
begin
    case(state)
        s0:if(start)state<=s1;
        s1:state<=s2;
        s2:state<=s3;
        s3:state<=s4;
        s4:state<=s5;
        s5:if(a)state<=s6;
            else state<=s7;        
        s6:state<=s8;
        s7:state<=s8;
        s8:if(comp)state<=s9;
            else state<=s4;
        s9:state<=s9;
        
        default:state<=s0;
        
    endcase
end

always @(state)
begin
    case(state)
        s0:begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end
        s1:begin cl_a=1; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=1; sel=0; ld_count=0; dec_count=0; e=0; end        
        s2:begin cl_a=0; shift_a=0; ld_a=0; ld_q=1; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end
        s3:begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=1; dec_count=0; e=0; end        
        s4:begin cl_a=0; shift_a=1; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end        
        s5:begin cl_a=0; shift_a=0; ld_a=1; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end
        s6:begin cl_a=0; shift_a=0; ld_a=1; ld_q=0; shift_q=1; update_q=0; ld_b=0; sel=1; ld_count=0; dec_count=0; e=0; end
        s7:begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=1; update_q=1; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end
        s8:begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=1; e=0; end
        s9:begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=1; end
        default: begin cl_a=0; shift_a=0; ld_a=0; ld_q=0; shift_q=0; update_q=0; ld_b=0; sel=0; ld_count=0; dec_count=0; e=0; end
    endcase
end


endmodule

module restore_division (f,clk,start,data_in);
input clk,start;
input [4:0]data_in;
output f;

wire comp,a,cl_a,shift_a,ld_a,  ld_q,shift_q,update_q, ld_b, sel, ld_count, dec_count;

data_path data (a,comp, data_in,clk, cl_a,shift_a,ld_a,ld_q,shift_q,update_q,ld_b, sel, ld_count, dec_count);
control_path control (cl_a,shift_a,ld_a,ld_q,shift_q,update_q,ld_b,sel,ld_count,dec_count,f,   start,comp,a,clk);
endmodule
