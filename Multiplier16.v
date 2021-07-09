module Multiplier16(a,b,c);
input [15:0]a;
input [15:0]b;
output [31:0]c;

wire [15:0]q0;	
wire [15:0]q1;	
wire [15:0]q2;
wire [15:0]q3;	
wire [31:0]c;
wire [15:0]temp1;
wire [23:0]temp2;
wire [23:0]temp3;
wire [23:0]temp4;
wire [15:0]q4;
wire [23:0]q5;
wire [23:0]q6;
wire c4,c5,c6;

// using 4 8x8 multipliers
Multiplier8 m8_1(.a(a[7:0]),.b(b[7:0]),.c(q0[15:0]));
Multiplier8 m8_2(.a(a[15:8]),.b(b[7:0]),.c(q1[15:0]));
Multiplier8 m8_3(.a(a[7:0]),.b(b[15:8]),.c(q2[15:0]));
Multiplier8 m8_4(.a(a[15:8]),.b(b[15:8]),.c(q3[15:0]));

// stage 1 adders 
assign temp1 ={8'b0,q0[15:8]};

Carry_sel_16bit z5(.A(q1[15:0]),.B(temp1),.cin(0),.S(q4),.cout(c4));

assign temp2 ={8'b0,q2[15:0]};
assign temp3 ={q3[15:0],8'b0};

Carry_sel_24bit m24_1(.A(temp2),.B(temp3),.cin(0),.S(q5),.cout(c5));

assign temp4={7'b0,c4,q4[15:0]};

//stage 2 adder
Carry_sel_24bit m24_2(.A(temp4),.B(q5),.cin(c5),.S(q6),.cout(c6));
// fnal output assignment 
assign c[7:0]=q0[7:0];
assign c[31:8]=q6[23:0];


endmodule



module Multilpier16_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;

	// Outputs
	wire [31:0] c;

	// Instantiate the Unit Under Test (UUT)
	Multiplier16 m16 (
		.a(a), 
		.b(b), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		
	       a = 16'd125;
		b = 16'd10;
		#100;
		
		
		

	end
      
endmodule


