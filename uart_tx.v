module uart_tx(

    input clk,
    input rst_n,

    input baud_tick,

    input tx_start,
    input [7:0] tx_data,

    output reg tx,
    output reg tx_done

);

localparam IDLE  = 2'b00;
localparam START = 2'b01;
localparam DATA  = 2'b10;
localparam STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_cnt;
reg [7:0] data_reg;

always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin
        state   <= IDLE;
        tx      <= 1'b1;
        tx_done <= 1'b0;
        bit_cnt <= 0;
        data_reg<= 0;
    end

    else if(baud_tick)
    begin

        case(state)

        IDLE:
        begin
            tx <= 1'b1;
            tx_done <= 0;

            if(tx_start)
            begin

		$display("TX START DETECTED TIME=%0t DATA=%h",$time,tx_data);
                data_reg <= tx_data;
                state <= START;
            end
        end

        START:
        begin
            tx <= 1'b0;
            bit_cnt <= 0;
            state <= DATA;
        end

        DATA:
        begin
            tx <= data_reg[bit_cnt];

            if(bit_cnt == 7)
                state <= STOP;
            else
                bit_cnt <= bit_cnt + 1;
        end

        STOP:
        begin
            tx <= 1'b1;
            tx_done <= 1'b1;
            state <= IDLE;
        end

        endcase

    end

end

endmodule