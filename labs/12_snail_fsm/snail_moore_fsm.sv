// Asynchronous reset here is needed for some FPGA boards we use

`include "config.svh"

module snail_moore_fsm
(
    input  clk,
    input  arst,
    input  en,
	 input  ok_button,
	 input clear_button,
	 input [3:0] switch_input,
	 output logic [2:0] rgb_led,
	 output logic safe_open
);

    typedef enum logic [2:0]
    {
        IDLE = 3'd0,
        ENTER_CODE = 3'd1,
        CHANGE_CODE = 3'd2,
		  BLOCKED = 3'd3
    }
    state_e;

    state_e state, next_state;
	 
	 
	 
	 //logic [1:0] attempts ;	
	 
	 //always_ff @ (posedge clk or posedge arst) не знаю, как релизовать счетчик для неверных попыток
	 
		
	 

    // State register
	 always_ff @ (posedge clk or posedge arst)
	 begin
	    if (arst)
		    state <= IDLE;
		 else if (en)
		    state <= next_state;
	 end
	 
    // Next state logic

    always_comb
    begin
        next_state = state;

        case (state)
        IDLE: if (ok_button && switch_input == 4'b1111) next_state = ENTER_CODE;// нажата кнопка ок и введен правильный пароль
		        else if (ok_button && switch_input != 4'b1111) next_state = IDLE;  // переходим в состояние блокировки, если исчерпан лимит попыток
				  else if (clear_button) next_state = CHANGE_CODE;// переход в состояние смены пароля
        ENTER_CODE: if (ok_button) next_state = IDLE;// при открытом сейфе, если нажата кнопка ОК, происходит возврат в исходное состояние
		              else next_state = ENTER_CODE;	  
 
        // S2: next_state = a ? S0 : S1;

        CHANGE_CODE: if (ok_button) next_state = IDLE; // переходим в IDLE при нажатии OK для завершения смены пароля
		  BLOCKED: if (clear_button) next_state = IDLE;
 
        endcase
    end
	 
	 always @ (*)// для отображения состояния автомата с помощью RGP
	 begin 
	    case (state)
		 IDLE:rgb_led = 3'b100; // как расположены цвета на плате? (RED, GREEN, BLUE)
		 ENTER_CODE:rgb_led = 3'b010;
		 CHANGE_CODE:rgb_led = 3'b001; 
	    endcase
    end
	 
    // Output logic based on current state
 assign safe_open = (state == ENTER_CODE );
   // assign y = (state == S2);// выход конечного автомата привязан  только к состоянию конечного автомата 
endmodule
