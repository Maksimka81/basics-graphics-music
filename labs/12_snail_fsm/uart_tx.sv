module uart_tx (
    input  logic       clk_i,
    input  logic       rst_i,
    input  logic [7:0] data_i,
    input  logic       start_i,
    output logic       tx_o,
    output logic       readytx_o 
);

               
   logic [13:0] cnt;// cчетчик, который будет считать до ...
	logic [3:0]  baud_num; // 
	 
	 logic  baud_start;
	 assign baud_start = (cnt == 16'd5208);
	 
	 logic  s_idle;
	 assign s_idle = (baud_num == 4'd11);//
	 
	 
	 always @(posedge clk_i or negedge rst_i) begin 
	     if (!rst_i) 
			  cnt <= '0;
		 else if (baud_start || start_i) 
		      cnt <= '0;  		 			
	     else  
		      cnt <= cnt + 16'b1;
	 end  
	   
	  
	  always @(posedge clk_i or negedge rst_i) begin
	      if(!rst_i)
			  baud_num <= '0;
		  else if (baud_start && (baud_num == 4'd11)) 
		      baud_num <= '0;
	      else if (baud_start) 
			  baud_num <= baud_num + 1'b1;
	  end
		
	  	
	  logic [10:0] sr_reg; 
	  always @(posedge clk_i or negedge rst_i) begin 
        if (!rst_i)
           sr_reg <= 'hFFF;
        else if (start_i)
           sr_reg <= {1'b1 , ^data_i , data_i , 1'b0}; 
		else if (baud_start) 
		   sr_reg <= sr_reg >> 1;
	  end 
	  
     assign readytx_o = s_idle;
	 //assign readytx_o    = (s_idle & (baud_num[1] | baud_num[0]));

     
	 assign tx_o =   sr_reg[0];

  

endmodule 
	














































































	
	/*module uart_tx (
	 input  clk,
	 input  rst,
	 input [7:0] data,
	 input logic start,
	 output logic tx   = 1'b1,
	 output logic pb
	 );
	 
	 
	 logic [3:0] bit_coun; // счетчик для пердачи 10 бит 
	 logic [13:0] baud_count; // 
	 logic [9:0] shiftright_reg; // сдвиговый регистр для послед передачи 
	 logic state, next_state;  // idle и transmitting
	 logic shift;
	 logic load;
	 logic clear;
	 
	 always @(posedge clk or posedge rst) begin 
	     if (rst) begin 
		      state      <= '0;
				bit_count  <= '0;
				baud_count <= '0;
		  end
		  else begin 
		  baut_cout <= bout_count + 14'd1;
		  if (boud_cout == 14'd10415) begin // 9600
		      state <= next_state; // передаем 
			   baud_count <= '0;
		  if (load)
		      shiftright_reg <= {1'b1, data, 1'b0};
		  if (clear)
		      bit_count <= '0;
				
		  if (shift) begin
		      shiftright_reg <= shiftright_reg >> '1;
				bit_count <= bit_count + '1;
				end
		  end
	end 
   // fsm
	always @(posedge clk) begin 
	    case(state)*/
		 
		 
	
	
		/*always @(posedge clk) begin
		  if (start && s_idle) begin 
		           state <= 4'h0;
					  tx      <= 1'b0;
		  end 
		  else if (bit_start) begin 
		  case (state)
		  4'h0: begin state <= 4'h1; tx <= data[0]; end
		  4'h1: begin state <= 4'h2; tx <= data[1]; end
		  4'h2: begin state <= 4'h3; tx <= data[2]; end
		  4'h3: begin state <= 4'h4; tx <= data[3]; end
		  4'h4: begin state <= 4'h5; tx <= data[4]; end
		  4'h5: begin state <= 4'h6; tx <= data[5]; end
		  4'h6: begin state <= 4'h7; tx <= data[6]; end
		  4'h7: begin state <= 4'h8; tx <= data[7]; end
		  4'h8: begin state <= 4'h9; tx <= 1'b1; end
		  default: begin state <= s_idle; end
		  endcase
		  end
        
     end */

  
    
	 
	
	 
	
				
				
		      
		
		  
		  
				
		  
		  
	  
	 
	 
	 
	 
		  
		  
	 
	 
    

    
