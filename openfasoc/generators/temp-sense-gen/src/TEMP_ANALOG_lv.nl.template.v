module TEMP_ANALOG_lv (EN, OUT, OUTB);
	input  EN;
	// inout in_vin;
 	output OUT, OUTB;
 	wire  n;

	% for i in range(0, ninv + 1):
	wire n${i + 1};
	% endfor
	wire nx1, nx2, nx3, nb1, nb2;

	${nand2} a_nand_0 ( .A(EN), .B(n${ninv + 1}), .Y(n1));

	% for i in range(0, ninv):
	${inv} a_inv_${i} ( .A(n${i + 1}), .Y(n${i + 2}));
	% endfor

	${inv} a_inv_m1 ( .A(n${ninv + 1}), .Y(nx1));
	${inv} a_inv_m2 ( .A(n${ninv + 1}), .Y(nx2));
	${inv} a_inv_m3 ( .A(nx2), .Y(nx3));

	${buf} a_buf_0 ( .A(nx1), .${nbout}(nb1));
	${buf} a_buf_1 ( .A(nb1), .${nbout}(OUT));

	${buf} a_buf_3 ( .A(nx3), .${nbout}(nb2));
	${buf} a_buf_2 ( .A(nb2), .${nbout}(OUTB));

endmodule
