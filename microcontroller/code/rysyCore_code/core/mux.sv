/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module mux
#(parameter
	DATA_WIDTH=32,
	INPUTS=2,
	ADDR_WIDTH=$clog2(INPUTS)
) (
	input wire [DATA_WIDTH-1:0]inputs[INPUTS-1:0],
	input wire [ADDR_WIDTH-1:0]addr,
	output wire [DATA_WIDTH-1:0]out
);

	assign out = inputs[addr];
endmodule

`default_nettype wire
