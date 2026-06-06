`timescale 1ns/1ps

module uart_tb;

reg clk;
reg rst_n;

reg tx_start;
reg [7:0] tx_data;

wire [7:0] rx_data;
wire rx_done;

uart_top DUT (

    .clk(clk),
    .rst_n(rst_n),

    .tx_start(tx_start),
    .tx_data(tx_data),

    .rx_data(rx_data),
    .rx_done(rx_done)

);


initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial
begin
    $monitor(
    "TIME=%0t TX_DATA=%h RX_DATA=%h RX_DONE=%b",
    $time,
    tx_data,
    rx_data,
    rx_done
    );
end

initial
begin

    rst_n = 0;
    tx_start = 0;
    tx_data = 8'h00;

    #20;
    rst_n = 1;

    #20;

    tx_data = 8'hA5;
    tx_start = 1;
    #400;
    tx_start = 0;

    #4000;

    tx_data = 8'h55;
    tx_start = 1;
    #400;
    tx_start = 0;

    #4000;

    tx_data = 8'h3C;
    tx_start = 1;
    #400;
    tx_start = 0;

    #4000;

    $stop;

end

endmodule