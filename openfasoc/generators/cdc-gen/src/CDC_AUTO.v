module cdcInst
( 
	
	input PRECHARGE, 

	output OSEN, OREF, FINISH, CONVFINISH,
	output LCOUT, CLKR, CLKF, CLK, SENSE,
	output [23:0] OUT_TOTAL,
	output [23:0] OUT_RISE,
	output [23:0] OUT_FALL
	);

 wire PRECHARGEB, IN, INB, osenb, orefb, n1, vl_dly, n3, n4, n5, n6, n7, n8, n9, n10, n11, clk_pre, dly_ref, clkb, osen_b2;
 wire prechargeb_pre, OUTF, OUTR, DONER, DONEF, done;



	CDC_ANALOG cdc_analog_0(
		.PRECHARGE(PRECHARGE),
		.PRECHARGEB(PRECHARGEB),
		.IN(IN),
		.INB(INB),
		.OSEN(OSEN),
		.LCOUT(LCOUT)
	);
	CDC_ANALOG2 cdc_analog_1(
		.IN(LCOUT),
		.OREF(OREF)
	);

INV_X2M_A9TR	tot_inv_0 (.A(OSEN), .Y(osenb));
INV_X2M_A9TR	tot_inv_1 (.A(OREF), .Y(orefb));
INV_X2M_A9TR	tot_inv_2 (.A(orefb), .Y(vl_dly));
INV_X2M_A9TR	tot_inv_3 (.A(vl_dly), .Y(n1));
INV_X2M_A9TR	tot_inv_4 (.A(n1), .Y(n3));
INV_X2M_A9TR	tot_inv_5 (.A(n3), .Y(n4));
INV_X2M_A9TR	tot_inv_6 (.A(n4), .Y(n5));
INV_X2M_A9TR	tot_inv_7 (.A(n5), .Y(n6));
INV_X2M_A9TR	tot_inv_8 (.A(n6), .Y(n7));
INV_X2M_A9TR	tot_inv_9 (.A(n7), .Y(n8));
INV_X2M_A9TR	tot_inv_10 (.A(n8), .Y(n9));
INV_X2M_A9TR	tot_inv_11 (.A(n9), .Y(n10));
INV_X2M_A9TR	tot_inv_12 (.A(n10), .Y(n11));
INV_X2M_A9TR	tot_inv_13 (.A(n11), .Y(dly_ref));
	
//IN generation
INV_X2M_A9TR	tot_inv_14 (.A(CLK), .Y(clkb));
INV_X2M_A9TR	tot_inv_15 (.A(clkb), .Y(clk_pre));
BUF_X4M_A9TR	tot_buf_0 (.A(clk_pre), .Y(IN));	
//INB generation
BUF_X4M_A9TR	tot_buf_1 (.A(clkb), .Y(INB));
	
BUF_X4M_A9TR	tot_buf_2 (.A(prechargeb_pre), .Y(PRECHARGEB));

INV_X2M_A9TR	tot_inv_16 (.A(PRECHARGE), .Y(prechargeb_pre));
INV_X2M_A9TR	tot_inv_17 (.A(OSEN), .Y(osen_b2));




	DLY_COMP dly_comp_0 (
		.DLYP(OSEN),
		.DLYM(OREF),
		.EN(OUTF),
		.DONE(DONEF),
		.YB(CLKF)
	);
	DLY_COMP dly_comp_1 (
		.DLYP(osenb),
		.DLYM(orefb),
		.EN(OUTR),
		.DONE(DONER),
		.YB(CLKR)
	);
	DLY_COMP dly_comp_2 (
		.DLYP(osen_b2),
		.DLYM(dly_ref),
		.EN(OUTR),
		.DONE(done),
		.YB(FINISH)
	);
	
	NEXT_EDGE_GEN nxt_edge_0 (
		.RESET(PRECHARGE),
		.VLOWDLY(vl_dly),
		.FINISH(FINISH),
		.DONEF(DONEF),
		.DONER(DONER),
		.OUTR(OUTR),
		.OUTF(OUTF),
		.CONVFINISH(CONVFINISH),
		.CLK(CLK),
		.SENSE(SENSE)
	);
	CDCW_CNT cdcw_cnt_0 (
		.TICK_TOTAL(CLK),
		.TICK_RISE(CLKR),
		.TICK_FALL(CLKF),
		.RESETn(PRECHARGE),
		.OE(PRECHARGEB),
		.OUT_TOTAL(OUT_TOTAL),
		.OUT_RISE(OUT_RISE),
		.OUT_FALL(OUT_FALL)
	);

endmodule
