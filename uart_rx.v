module uart_rx(

    input clk,
    input rst_n,

    input baud_tick,
    input rx,

    output reg [7:0] rx_data,
    output reg rx_done

);

localparam IDLE = 2'd0;
localparam DATA = 2'd1;
localparam STOP = 2'd2;

reg [1:0] state;
reg [2:0] bit_cnt;
reg [7:0] data_reg;

always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin
        state    <= IDLE;
        bit_cnt  <= 0;
        data_reg <= 0;
        rx_data  <= 0;
        rx_done  <= 0;
    end

    else if(baud_tick)
    begin

        case(state)

        IDLE:
        begin

            rx_done <= 0;

            if(rx == 0)
            begin
                bit_cnt <= 0;
                state <= DATA;
            end

        end

        DATA:
        begin

            data_reg[bit_cnt] <= rx;

            if(bit_cnt == 3'd7)
                state <= STOP;
            else
                bit_cnt <= bit_cnt + 1'b1;

        end

        STOP:
        begin

            rx_data <= data_reg;
            rx_done <= 1'b1;

            state <= IDLE;

        end

        endcase

    end

end

endmodule