module StateMachine (
  input wire clk,
  input wire busy,
  input wire sw,
  output reg write,
  output reg reconfig,
  output reg [2:0] param,
  output reg [23:0] data
);

  // Define states
  parameter IDLE = 3'b000;
  parameter DISABLE_WATCHDOG = 3'b001;
  parameter WAIT_FOR_BUSY_HIGH_0 = 3'b010;
  parameter WAIT_FOR_BUSY_LOW_0 = 3'b011;
  parameter SET_BOOT_ADDR = 3'b100;
  parameter WAIT_FOR_BUSY_HIGH_1 = 3'b101;
  parameter WAIT_FOR_BUSY_LOW_1 = 3'b110;
  parameter SET_RECONFIG = 3'b111;

  // Define state register
  reg [2:0] next_state;

  // State transition and output logic
  always @(posedge clk) begin
    write <= 0;
    reconfig <= 0;
    param <= 0;
    data <= 0;

    case(next_state)
      IDLE:
        if (!busy) begin
          next_state = DISABLE_WATCHDOG;
        end
      DISABLE_WATCHDOG:
        begin
          next_state = WAIT_FOR_BUSY_HIGH_0;
          write <= 1;
          param <= 3'b011;
          data <= 0;
        end
      WAIT_FOR_BUSY_HIGH_0:
        if (busy) begin
          next_state = WAIT_FOR_BUSY_LOW_0;
        end
      WAIT_FOR_BUSY_LOW_0:
        if (!busy) begin
          next_state = SET_BOOT_ADDR;
        end
      SET_BOOT_ADDR:
        begin
          next_state = WAIT_FOR_BUSY_HIGH_1;
          write <= 1;
          param <= 3'b100;
          if (sw) begin
            data <= 24'h160000;
          end else begin
            data <= 24'hB0000;
          end
        end
      WAIT_FOR_BUSY_HIGH_1:
        if (busy) begin
          next_state = WAIT_FOR_BUSY_LOW_1;
        end
      WAIT_FOR_BUSY_LOW_1:
        if (!busy) begin
          next_state = SET_RECONFIG;
        end
      SET_RECONFIG:
        begin
          next_state = SET_RECONFIG;
          reconfig <= 1;
        end
    endcase

  end

endmodule
