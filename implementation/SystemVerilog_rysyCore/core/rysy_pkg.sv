/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

package rysyPkg;

	localparam int REG_LEN = 32;
	localparam int REG_NUM = 32;
	localparam int ADDR_LEN = 5;

	localparam NOP = 32'h00000013;
endpackage : rysyPkg

`default_nettype wire
