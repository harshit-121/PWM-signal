`timescale 1ns / 1ps

module pwm(
input clk,reset,
output reg dout
    );
    
    parameter period = 100;
    integer ton = 0;
    reg nxt_cycle = 1'b0;
    reg direction = 1'b0;
    integer count = 0;
    
    always@(posedge clk)begin
        if(reset)begin
            nxt_cycle <= 1'b0;
            ton <= 0;
            direction <= 1'b0;
            count <= 0;
        end
        else begin
            if(count <= ton)begin
                count <= count + 1;
                dout <= 1'b1;
                nxt_cycle <= 1'b0;
            end
            else if (count < period)begin
                count <= count + 1;
                dout <= 1'b0;
                nxt_cycle <= 1'b0;
            end
            else begin
                count <= 0;
                nxt_cycle <= 1'b1;
            end
        end
    end
    
always@(posedge clk)begin
    if(reset == 1'b0)begin
        if(nxt_cycle)begin 
            if (direction == 1'b0)
                begin
                    if(ton < period)begin
                       ton <= ton + 5;
                    end
                    else if(ton >= period)begin
                            direction <= 1'b1;
                            ton <= ton - 5;
                            end
                     else
                            direction <= 1'b0;
                end        
            else 
                 begin
                    ton <= ton - 5;
                    if(ton <= 0)begin
                    ton <= ton + 5;
                    direction <= 1'b0;
                    end
                end
        end    
    end    
end
    
endmodule
