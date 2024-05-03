
module uart_rx (
    input  logic       clk_i,
    input  logic       rst_i,
    input  logic       rx_i,
    output logic [7:0] data_o,
    output logic       readyrx_o 
);

    logic [13:0] cnt;
    logic [12:0] cnt_2;
    logic [3:0]  baud_num_2;
    
    
    logic  baud_st;
    assign baud_st    = (cnt_2 == 16'd2604);

    logic  baud_start;
    assign baud_start = (cnt == 16'd5209);
    
    logic  s_idle;
    assign s_idle = (baud_num_2 == 4'd11); // 
	
  
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            cnt_2 <= '0;
        else if (!rx_i)
            cnt_2 <= cnt_2 + 16'b1;
        else if (baud_st) begin
            cnt_2 <= '0;
        end
    end

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            cnt <= '0;
        else if (baud_start)
            cnt <= '0;
        else
            cnt <= cnt + 16'b1;
    end
    logic [1:0] rx_reg;
    always_ff @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            rx_reg <= '0;
        else 
            rx_reg <= {rx_reg[0], rx_i};
    end
    
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            baud_num_2 <= '0;
        else if (baud_start && (baud_num_2 == 4'd11))
            baud_num_2 <= '0;
        else if (baud_start)
            baud_num_2 <= baud_num_2 + 1'b1;
        else if (baud_st && (baud_num_2 == 4'd11))
            baud_num_2 <= '0;
    end
    
    logic [10:0] sr_reg;
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            sr_reg <= 'hFFF;
        else if (baud_start)
            sr_reg <=  {sr_reg[9:0], rx_i};     
    end
    
    assign readyrx_o    = s_idle;
    assign data_o       = sr_reg[9:2];

endmodule 








