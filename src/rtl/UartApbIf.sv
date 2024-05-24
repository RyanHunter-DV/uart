// apb interface module, to detect apb interface and send wren, rden control
// signals for internal uart control registers
module UartApbIf(
	output[31:0] wdata_o, // to reg control module
	Apb2.slave apb,
	UartRegCtrlIf.master regc
);

	`include "UartRegAddr.svh"



	// using pclk and presetn

	wire isWrite;
	isWrite=apb.psel&apb.pwrite&apb.penable;
	assign wdata_o = (isWrite)? apb.pwdata : 32'h0;
	wire [9:0] wordSel;
	assign wordSel=(apb.psel)? apb.paddr[11:2] : 10'h0;

	
	assign regc.DRWrEn = (isWrite) & (wordSel==DRAddr);
	assign regc.DRRdEn = (apb.psel) & (wordSel==DRAddr);


	// RSR, read only
	assign regc.RSRRdEn=

endmodule