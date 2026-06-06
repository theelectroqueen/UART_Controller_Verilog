module uart_top(

    input clk,
    input rst_n,

    input tx_start,
    input [7:0] tx_data,

    output [7:0] rx_data,
    output rx_done

);

wire baud_tick;
wire tx_wire;

// Baud Generator
baud_gen BAUD_GEN (

    .clk(clk),
    .rst_n(rst_n),
    .baud_tick(baud_tick)

);

// UART TX
uart_tx TX (

    .clk(clk),
    .rst_n(rst_n),

    .baud_tick(baud_tick),

    .tx_start(tx_start),
    .tx_data(tx_data),

    .tx(tx_wire),
    .tx_done()

);

// UART RX
uart_rx RX (

    .clk(clk),
    .rst_n(rst_n),

    .baud_tick(baud_tick),

    .rx(tx_wire),

    .rx_data(rx_data),
    .rx_done(rx_done)

);

endmodule