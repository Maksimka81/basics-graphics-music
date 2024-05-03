module uart
(
    input  logic                 clk_i,
    input  logic                 rst_i,
 // uart_tx
    input  logic [         7:0]  data_i,
    input  logic                 start_i,
    output logic                 tx_o,
    output logic                 readytx_o,
 // uart_rx 
    input  logic                 rx_i,
    output logic [         7:0]  data_o,
    output logic                 readyrx_o     
);




uart_tx i_uart_tx
 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(data_i),
        .start_i(start_i),
	     .tx_o(tx_o),
        .readytx_o(readytx_o)
 );
 
uart_rx i_uart_rx
 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(rx_i),
        .data_o(data_o),
        .readyrx_o(readyrx_o)
 );

endmodule