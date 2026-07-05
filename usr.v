module usr (
input rst,clk,shift,load,s_in,
input [3:0]p_in,
input [1:0]mode,
output s_out,
output [3:0]p_out);

reg [3:0] temp;  //temparary register

always@(posedge clk or posedge rst)
begin
if (rst) temp<=4'b0000;
else begin
case(mode) 
    2'b00: begin      //for siso
        if(shift)
        temp <= {s_in, temp[3:1]};
        else
        temp<=temp;
    end
    2'b01: begin      //for sipo
        if (shift)
        temp <= {s_in, temp[3:1]};
        else
        temp<=temp;
    end
    2'b10: begin    //for piso
        if (load)
        temp<=p_in;
        else if(shift)
         temp<={1'b0,temp[3:1]};
         else 
         temp<=temp;
    end
    2'b11: begin    //for pipo
        if(load)
        temp<=p_in;
        else
        temp<=temp;
    end
    default:temp<=temp;
endcase
end
end

        assign s_out=temp[0];  //to get the serial output
        assign p_out=temp;     // to get the parallel output
endmodule
