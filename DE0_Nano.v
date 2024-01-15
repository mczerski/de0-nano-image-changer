
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE0_Nano(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////////// EPCS //////////
	EPCS_ASDO,
	EPCS_DATA0,
	EPCS_DCLK,
	EPCS_NCSO,

	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT,

	//////////// ADC //////////
	ADC_CS_N,
	ADC_SADDR,
	ADC_SCLK,
	ADC_SDAT,

	//////////// 2x13 GPIO Header //////////
	GPIO_2,
	GPIO_2_IN,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0,
	GPIO_0_IN,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	GPIO_1,
	GPIO_1_IN
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

`define CLOCK
`define LED
`define KEY
`define SW
`define SDRAM
`define EPCS
`define AE
`define ADC
`define GPIOH
`define GPIO0
`define GPIO1


//////////// CLOCK //////////
//3.3-V LVTTL//
`ifdef CLOCK
input 		          		CLOCK_50;
`endif

//////////// LED //////////
//3.3-V LVTTL//
`ifdef LED
output		     [7:0]		LED;
`endif

//////////// KEY //////////
//3.3-V LVTTL//
`ifdef KEY
input 		     [1:0]		KEY;
`endif

//////////// SW //////////
//3.3-V LVTTL//
`ifdef SW
input 		     [3:0]		SW;
`endif

//////////// SDRAM //////////
//3.3-V LVTTL//
`ifdef SDRAM
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [15:0]		DRAM_DQ;
output		     [1:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;
`endif

//////////// EPCS //////////
//3.3-V LVTTL//
`ifdef EPCS
output		          		EPCS_ASDO;
input 		          		EPCS_DATA0;
output		          		EPCS_DCLK;
output		          		EPCS_NCSO;
`endif

//////////// Accelerometer and EEPROM //////////
//3.3-V LVTTL//
`ifdef AE
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;
`endif

//////////// ADC //////////
//3.3-V LVTTL//
`ifdef ADC
output		          		ADC_CS_N;
output		          		ADC_SADDR;
output		          		ADC_SCLK;
input 		          		ADC_SDAT;
`endif

//////////// 2x13 GPIO Header //////////
//3.3-V LVTTL//
`ifdef GPIOH
inout 		    [12:0]		GPIO_2;
input 		     [2:0]		GPIO_2_IN;
`endif

//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
//3.3-V LVTTL//
`ifdef GPIO0
inout 		    [33:0]		GPIO_0;
input 		     [1:0]		GPIO_0_IN;
`endif

//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
//3.3-V LVTTL//
`ifdef GPIO1
inout 		    [33:0]		GPIO_1;
input 		     [1:0]		GPIO_1_IN;
`endif

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire busy;
wire reconfig;
wire write;
wire [23:0] boot_address;
wire clk;

//=======================================================
//  Structural coding
//=======================================================

assign boot_address = SW[0] ? 24'hB0000 : 24'h160000;
assign LED[0] = 1;

remote_update u0 (
	.busy        (busy),        //        busy.busy
	.param       (3'b100),       //       param.param
	.reconfig    (reconfig),    //    reconfig.reconfig
	.clock       (CLOCK_50),       //       clock.clk
	.reset       (1'b0),       //       reset.reset
	.write_param (write), // write_param.write_param
	.data_in     (boot_address)      //     data_in.data_in
);

StateMachine s0 (
  .clk(CLOCK_50),
  .busy(busy),
  .write(write),
  .reconfig(reconfig)
);

endmodule
