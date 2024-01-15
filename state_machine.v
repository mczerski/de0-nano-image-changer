module StateMachine (
  input wire clk,
  input wire busy,
  output reg write,
  output reg reconfig
);

  // Define states
  parameter IDLE = 3'b000;
  parameter SET_WRITE = 3'b001;
  parameter WAIT_FOR_BUSY_1 = 3'b010;
  parameter WAIT_FOR_BUSY_0 = 3'b011;
  parameter SET_RECONFIG = 3'b100;
  parameter DONE = 3'b101;

  // Define state register
  reg [2:0] next_state;

  // State transition and output logic
  always @(posedge clk) begin
    write <= 0;
    reconfig <= 0;

    case(next_state)
      IDLE:
        if (!busy) begin
          // Transition to SET_WRITE state when busy becomes 0
          next_state = SET_WRITE;
        end
      SET_WRITE:
        begin
          // Transition to WAIT_FOR_BUSY_1 state immediately and set write to 1
          next_state = WAIT_FOR_BUSY_1;
          write <= 1;
        end
      WAIT_FOR_BUSY_1:
        if (busy) begin
          // Transition to WAIT_FOR_BUSY_0 state when busy becomes 1
          next_state = WAIT_FOR_BUSY_0;
        end
      WAIT_FOR_BUSY_0:
        if (!busy) begin
          // Transition to SET_RECONFIG state when busy becomes 0
          next_state = SET_RECONFIG;
        end
      SET_RECONFIG:
        begin
          // Transition back to IDLE state after setting reconfig to 1
          next_state = DONE;
          reconfig <= 1;
        end
      DONE:
        begin
          // Transition to WAIT_FOR_BUSY_1 state immediately and set write to 1
          next_state = DONE;
          reconfig <= 1;
        end
    endcase

  end

endmodule