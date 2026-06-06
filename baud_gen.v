module baud_gen #

(
    parameter BAUD_DIV = 32
)

(
    input clk,
    input rst_n,

    output reg baud_tick
);

reg [7:0] count;

always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin
        count <= 0;
        baud_tick <= 0;
    end

    else
    begin

        if(count == BAUD_DIV-1)
        begin
            count <= 0;
            baud_tick <= 1;
        end

        else
        begin
            count <= count + 1;
            baud_tick <= 0;
        end

    end

end

endmodule