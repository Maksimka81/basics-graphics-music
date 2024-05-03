module main
(
  input  logic clk_i,
  input  logic rx_i,
  input  logic rst_i,
  input  logic start_i_in,
  output logic tx_o
);

logic [    7:0]data;
logic          readytx;
logic          start;
logic          readyrx; 


uart UART
(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(data),
        .start_i(start),
        .tx_o(tx_o),            
        .readytx_o(readytx),
        .rx_i(rx_i),
        .data_o(data),
        .readyrx_o(readyrx)  	  
);



/*always @ (posedge clk_i or negedge rst_i) begin
	if(!rst_i)begin
		start_i_in <= 1'b0;
  end
  else if(readyrx_o) begin 
    data_i   <= data_o;
  end 
end*/

 /*always @(posedge readyrx_o or negedge readytx_o) begin
  if(~readytx_o) begin
		start_i_in <= 1'b0;
  end
  else if(readyrx_o) begin
	  data_i  <= data_o;
    start_i_in <= 1'b1;

	end
end*/
assign start = (readyrx & readytx);

 
endmodule