`include "config.svh"

module top
# (
    parameter clk_mhz = 50,
              w_key   = 4,
              w_sw    = 8,
              w_led   = 8,
              w_digit = 8,
              w_gpio  = 100
)
(
    input                        clk,
    input                        slow_clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // VGA

    output logic                 vsync,
    output logic                 hsync,
    output logic [          3:0] red,
    output logic [          3:0] green,
    output logic [          3:0] blue,

    input                        uart_rx,
    output                       uart_tx,

    input                        mic_ready,
    input        [         23:0] mic,
    output       [         15:0] sound,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio
);

    //------------------------------------------------------------------------

    // assign led      = '0;
    // assign abcdefgh = '0;
    // assign digit    = '0;
       assign vsync    = '0;
       assign hsync    = '0;
       assign red      = '0;
       assign green    = '0;
       assign blue     = '0;
       assign sound    = '0;
       assign uart_tx  = '1;

    //------------------------------------------------------------------------

    wire enable;
    wire fsm_in, moore_fsm_out, mealy_fsm_out;

    // Generate a strobe signal 3 times a second

   /* strobe_gen
    # (.clk_mhz (clk_mhz), .strobe_hz (3)) // параметр отвечающий за частоту следования стробов в герцах 
    i_strobe_gen // генерация строба частотой в 3 Гц Будет использоваться в управлении сдвиговым регистром 
	 (.strobe (enable), .*);

    shift_reg # (.depth (w_led)) i_shift_reg //сдвиговый регистр совпадающий с кол-во светодиодов на плате
    (
        .en      (   enable ), // сдвиг происходит по стробу enable 3 раза в секунду
        .seq_in  ( | key    ), // на выход сдвигового регистра подается результат логического или если в момент когда enable равно 1 и хотя одна кнопка будет нажата, то на вход будет подана единица
        .seq_out (   fsm_in ), // выход сдвигового регистра. Подается на конечный автомат как входное воздействие.
        .par_out (   led    ), // шина, отражающая состояние всех триггеров сдвигового регистра для визуализации на светодиодах
        .*
    );*/

    snail_moore_fsm i_moore_fsm
        //(.en (enable), .a (fsm_in), .y (moore_fsm_out), .*);// на вход приходит состояние кнопок с сдвигового регистра.На выходе была ли распознана последовательность нажатий или нет.
		 (
        .clk(clk),
        .arst(arst),
        .en(en),
        .ok_button(ok_button),
        .clear_button(clear_button),
        .switch_input(switch_input),
        .rgb_led(rgb_led),
        .safe_open(safe_open)
    );
	 

		  
    //snail_mealy_fsm i_mealy_fsm
        //(.en (enable), .a (fsm_in), .y (mealy_fsm_out), .*);

    //------------------------------------------------------------------------

    //   --a--
    //  |     |
    //  f     b
    //  |     |
    //   --g--
    //  |     |
    //  e     c
    //  |     |
    //   --d--  h

    /*always_comb
    begin
        case ({ mealy_fsm_out, moore_fsm_out })// на семисегметный индикатор выводиться информация о состоянии конечных автоматов.
        2'b00: abcdefgh = 8'b0000_0000;
        2'b01: abcdefgh = 8'b1100_0110;  // Moore only
        2'b10: abcdefgh = 8'b0011_1010;  // Mealy only
        2'b11: abcdefgh = 8'b1111_1110;
        endcase

        digit = w_digit' (1);
    end*/

    // Exercise: Implement FSM for recognizing other sequence,
    // for example 0101

endmodule
