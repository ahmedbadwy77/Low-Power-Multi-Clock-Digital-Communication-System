/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Oct  1 07:33:03 2026
/////////////////////////////////////////////////////////////


module CLK_GATE ( clk, clk_en, gated_clk );
  input clk, clk_en;
  output gated_clk;


  TLATNCAX2M U0 ( .E(clk_en), .CK(clk), .ECK(gated_clk) );
endmodule


module prescale_mux ( prescale, div_ratio );
  input [5:0] prescale;
  output [2:0] div_ratio;
  wire   n1, n2, n3;

  NOR3X2M U3 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .Y(n2) );
  OAI21X2M U4 ( .A0(n1), .A1(n3), .B0(n2), .Y(div_ratio[0]) );
  AND2X2M U5 ( .A(n2), .B(n3), .Y(div_ratio[1]) );
  AND2X2M U6 ( .A(n1), .B(n2), .Y(div_ratio[2]) );
  NOR3BX2M U7 ( .AN(prescale[4]), .B(prescale[3]), .C(prescale[5]), .Y(n3) );
  NOR3BX2M U8 ( .AN(prescale[3]), .B(prescale[4]), .C(prescale[5]), .Y(n1) );
endmodule


module CLK_DIV_0_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CLK_DIV_0 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   divided_clk, N19, N20, N21, N22, N23, N24, N25, N26, N29, N30, N31,
         N32, N33, N34, N35, N36, N80, N81, N82, N83, N84, N85, N86, N87, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68;
  wire   [7:0] edge_count;
  wire   [7:0] prev_div_ratio;

  CLK_DIV_0_DW01_inc_0 r80 ( .A(edge_count), .SUM({N36, N35, N34, N33, N32, 
        N31, N30, N29}) );
  DFFRQX2M \edge_count_reg[7]  ( .D(N87), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[7]) );
  DFFRQX2M \edge_count_reg[0]  ( .D(N80), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[0]) );
  DFFRQX2M \edge_count_reg[1]  ( .D(N81), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[1]) );
  DFFRQX2M \edge_count_reg[2]  ( .D(N82), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[2]) );
  DFFRQX2M \edge_count_reg[3]  ( .D(N83), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[3]) );
  DFFRQX2M \edge_count_reg[4]  ( .D(N84), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[4]) );
  DFFRQX2M \edge_count_reg[5]  ( .D(N85), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[5]) );
  DFFRQX2M \edge_count_reg[6]  ( .D(N86), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[6]) );
  DFFRX1M clk_div_en_reg ( .D(i_clk_en), .CK(i_ref_clk), .RN(n3), .Q(n68) );
  DFFRQX2M \prev_div_ratio_reg[1]  ( .D(n31), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[1]) );
  DFFRQX2M \prev_div_ratio_reg[2]  ( .D(n32), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[2]) );
  DFFRQX2M \prev_div_ratio_reg[3]  ( .D(n33), .CK(i_ref_clk), .RN(i_rst_n), 
        .Q(prev_div_ratio[3]) );
  DFFRQX2M \prev_div_ratio_reg[4]  ( .D(n34), .CK(i_ref_clk), .RN(i_rst_n), 
        .Q(prev_div_ratio[4]) );
  DFFRQX2M \prev_div_ratio_reg[5]  ( .D(n35), .CK(i_ref_clk), .RN(i_rst_n), 
        .Q(prev_div_ratio[5]) );
  DFFRQX2M \prev_div_ratio_reg[6]  ( .D(n36), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[6]) );
  DFFRQX2M \prev_div_ratio_reg[7]  ( .D(n37), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[7]) );
  DFFRQX2M \prev_div_ratio_reg[0]  ( .D(n38), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[0]) );
  DFFSX1M divided_clk_reg ( .D(n39), .CK(i_ref_clk), .SN(n3), .Q(divided_clk), 
        .QN(n24) );
  AND4X2M U3 ( .A(n21), .B(n20), .C(n19), .D(n18), .Y(n1) );
  CLKINVX2M U4 ( .A(i_rst_n), .Y(n4) );
  INVX4M U5 ( .A(n4), .Y(n3) );
  BUFX2M U6 ( .A(n43), .Y(n2) );
  NOR2X2M U7 ( .A(n44), .B(n1), .Y(n43) );
  OR2X2M U8 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n5) );
  CLKINVX1M U9 ( .A(i_div_ratio[1]), .Y(N19) );
  OAI2BB1X1M U10 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n5), .Y(N20) );
  OR2X1M U11 ( .A(n5), .B(i_div_ratio[3]), .Y(n6) );
  OAI2BB1X1M U12 ( .A0N(n5), .A1N(i_div_ratio[3]), .B0(n6), .Y(N21) );
  OR2X1M U13 ( .A(n6), .B(i_div_ratio[4]), .Y(n7) );
  OAI2BB1X1M U14 ( .A0N(n6), .A1N(i_div_ratio[4]), .B0(n7), .Y(N22) );
  OR2X1M U15 ( .A(n7), .B(i_div_ratio[5]), .Y(n8) );
  OAI2BB1X1M U16 ( .A0N(n7), .A1N(i_div_ratio[5]), .B0(n8), .Y(N23) );
  XNOR2X1M U17 ( .A(i_div_ratio[6]), .B(n8), .Y(N24) );
  NOR3X1M U18 ( .A(i_div_ratio[6]), .B(i_div_ratio[7]), .C(n8), .Y(N26) );
  OAI21X1M U19 ( .A0(i_div_ratio[6]), .A1(n8), .B0(i_div_ratio[7]), .Y(n9) );
  NAND2BX1M U20 ( .AN(N26), .B(n9), .Y(N25) );
  NOR2BX1M U21 ( .AN(prev_div_ratio[0]), .B(i_div_ratio[0]), .Y(n10) );
  OAI2B2X1M U22 ( .A1N(i_div_ratio[1]), .A0(n10), .B0(prev_div_ratio[1]), .B1(
        n10), .Y(n21) );
  NOR2BX1M U23 ( .AN(i_div_ratio[0]), .B(prev_div_ratio[0]), .Y(n11) );
  OAI2B2X1M U24 ( .A1N(prev_div_ratio[1]), .A0(n11), .B0(i_div_ratio[1]), .B1(
        n11), .Y(n20) );
  CLKXOR2X2M U25 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .Y(n13) );
  CLKXOR2X2M U26 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .Y(n12) );
  NOR2X1M U27 ( .A(n13), .B(n12), .Y(n19) );
  CLKXOR2X2M U28 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .Y(n17) );
  CLKXOR2X2M U29 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .Y(n16) );
  CLKXOR2X2M U30 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .Y(n15) );
  CLKXOR2X2M U31 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .Y(n14) );
  NOR4X1M U32 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(n18) );
  CLKMX2X2M U33 ( .A(i_ref_clk), .B(divided_clk), .S0(n22), .Y(o_div_clk) );
  MXI2X1M U34 ( .A(n23), .B(n24), .S0(n25), .Y(n39) );
  NOR2X1M U35 ( .A(n26), .B(n27), .Y(n25) );
  OAI33X1M U36 ( .A0(n28), .A1(n29), .A2(n30), .B0(n40), .B1(n24), .B2(n41), 
        .Y(n27) );
  CLKINVX1M U37 ( .A(n42), .Y(n29) );
  NOR2X1M U38 ( .A(n24), .B(n26), .Y(n23) );
  NAND3BX1M U39 ( .AN(n2), .B(n22), .C(i_clk_en), .Y(n26) );
  CLKMX2X2M U40 ( .A(prev_div_ratio[0]), .B(i_div_ratio[0]), .S0(n2), .Y(n38)
         );
  CLKMX2X2M U41 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .S0(n2), .Y(n37)
         );
  CLKMX2X2M U42 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .S0(n2), .Y(n36)
         );
  CLKMX2X2M U43 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .S0(n2), .Y(n35)
         );
  CLKMX2X2M U44 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .S0(n2), .Y(n34)
         );
  CLKMX2X2M U45 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .S0(n2), .Y(n33)
         );
  CLKMX2X2M U46 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .S0(n2), .Y(n32)
         );
  CLKMX2X2M U47 ( .A(prev_div_ratio[1]), .B(i_div_ratio[1]), .S0(n2), .Y(n31)
         );
  AND2X1M U48 ( .A(N36), .B(n45), .Y(N87) );
  AND2X1M U49 ( .A(N35), .B(n45), .Y(N86) );
  AND2X1M U50 ( .A(N34), .B(n45), .Y(N85) );
  AND2X1M U51 ( .A(N33), .B(n45), .Y(N84) );
  AND2X1M U52 ( .A(N32), .B(n45), .Y(N83) );
  AND2X1M U53 ( .A(N31), .B(n45), .Y(N82) );
  AND2X1M U54 ( .A(N30), .B(n45), .Y(N81) );
  AND2X1M U55 ( .A(N29), .B(n45), .Y(N80) );
  CLKNAND2X2M U56 ( .A(n46), .B(n47), .Y(n45) );
  NAND4BX1M U57 ( .AN(n40), .B(i_clk_en), .C(divided_clk), .D(n41), .Y(n47) );
  CLKNAND2X2M U58 ( .A(n48), .B(n49), .Y(n41) );
  NOR4X1M U59 ( .A(edge_count[7]), .B(n50), .C(n51), .D(n52), .Y(n49) );
  CLKXOR2X2M U60 ( .A(i_div_ratio[3]), .B(edge_count[2]), .Y(n52) );
  CLKXOR2X2M U61 ( .A(i_div_ratio[2]), .B(edge_count[1]), .Y(n51) );
  CLKXOR2X2M U62 ( .A(i_div_ratio[1]), .B(edge_count[0]), .Y(n50) );
  NOR4X1M U63 ( .A(n53), .B(n54), .C(n55), .D(n56), .Y(n48) );
  CLKXOR2X2M U64 ( .A(i_div_ratio[7]), .B(edge_count[6]), .Y(n56) );
  CLKXOR2X2M U65 ( .A(i_div_ratio[6]), .B(edge_count[5]), .Y(n55) );
  CLKXOR2X2M U66 ( .A(i_div_ratio[5]), .B(edge_count[4]), .Y(n54) );
  CLKXOR2X2M U67 ( .A(i_div_ratio[4]), .B(edge_count[3]), .Y(n53) );
  OAI21X1M U68 ( .A0(n30), .A1(n28), .B0(n42), .Y(n46) );
  OAI31X1M U69 ( .A0(n40), .A1(divided_clk), .A2(n44), .B0(n57), .Y(n42) );
  NAND4BX1M U70 ( .AN(i_div_ratio[0]), .B(i_clk_en), .C(n22), .D(n1), .Y(n57)
         );
  CLKINVX1M U71 ( .A(i_clk_en), .Y(n44) );
  NAND3X1M U72 ( .A(n22), .B(n1), .C(i_div_ratio[0]), .Y(n40) );
  OA21X1M U73 ( .A0(n58), .A1(n59), .B0(n68), .Y(n22) );
  OR3X1M U74 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n59) );
  OR4X1M U75 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n58) );
  NAND4X1M U76 ( .A(n60), .B(n61), .C(n62), .D(n63), .Y(n28) );
  XNOR2X1M U77 ( .A(edge_count[0]), .B(N19), .Y(n63) );
  XNOR2X1M U78 ( .A(edge_count[1]), .B(N20), .Y(n62) );
  XNOR2X1M U79 ( .A(edge_count[2]), .B(N21), .Y(n61) );
  XNOR2X1M U80 ( .A(edge_count[7]), .B(N26), .Y(n60) );
  NAND4X1M U81 ( .A(n64), .B(n65), .C(n66), .D(n67), .Y(n30) );
  XNOR2X1M U82 ( .A(edge_count[3]), .B(N22), .Y(n67) );
  XNOR2X1M U83 ( .A(edge_count[4]), .B(N23), .Y(n66) );
  XNOR2X1M U84 ( .A(edge_count[5]), .B(N24), .Y(n65) );
  XNOR2X1M U85 ( .A(edge_count[6]), .B(N25), .Y(n64) );
endmodule


module CLK_DIV_1_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CLK_DIV_1 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   divided_clk, N19, N20, N21, N22, N23, N24, N25, N26, N29, N30, N31,
         N32, N33, N34, N35, N36, N80, N81, N82, N83, N84, N85, N86, N87, n1,
         n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77;
  wire   [7:0] edge_count;
  wire   [7:0] prev_div_ratio;

  CLK_DIV_1_DW01_inc_0 r80 ( .A(edge_count), .SUM({N36, N35, N34, N33, N32, 
        N31, N30, N29}) );
  DFFRQX2M \edge_count_reg[7]  ( .D(N87), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[7]) );
  DFFRQX2M \edge_count_reg[0]  ( .D(N80), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[0]) );
  DFFRQX2M \edge_count_reg[1]  ( .D(N81), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[1]) );
  DFFRQX2M \edge_count_reg[2]  ( .D(N82), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[2]) );
  DFFRQX2M \edge_count_reg[3]  ( .D(N83), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[3]) );
  DFFRQX2M \edge_count_reg[4]  ( .D(N84), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[4]) );
  DFFRQX2M \edge_count_reg[5]  ( .D(N85), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[5]) );
  DFFRQX2M \edge_count_reg[6]  ( .D(N86), .CK(i_ref_clk), .RN(n3), .Q(
        edge_count[6]) );
  DFFRX1M clk_div_en_reg ( .D(i_clk_en), .CK(i_ref_clk), .RN(n3), .Q(n68) );
  DFFRQX2M \prev_div_ratio_reg[3]  ( .D(n75), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[3]) );
  DFFRQX2M \prev_div_ratio_reg[1]  ( .D(n77), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[1]) );
  DFFRQX2M \prev_div_ratio_reg[2]  ( .D(n76), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[2]) );
  DFFRQX2M \prev_div_ratio_reg[4]  ( .D(n74), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[4]) );
  DFFRQX2M \prev_div_ratio_reg[5]  ( .D(n73), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[5]) );
  DFFRQX2M \prev_div_ratio_reg[6]  ( .D(n72), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[6]) );
  DFFRQX2M \prev_div_ratio_reg[7]  ( .D(n71), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[7]) );
  DFFRQX2M \prev_div_ratio_reg[0]  ( .D(n70), .CK(i_ref_clk), .RN(n3), .Q(
        prev_div_ratio[0]) );
  DFFSX1M divided_clk_reg ( .D(n69), .CK(i_ref_clk), .SN(n3), .Q(divided_clk), 
        .QN(n24) );
  AND4X2M U3 ( .A(n21), .B(n20), .C(n19), .D(n18), .Y(n1) );
  OR2X2M U4 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n5) );
  INVX4M U5 ( .A(n4), .Y(n3) );
  BUFX2M U6 ( .A(n43), .Y(n2) );
  NOR2X2M U7 ( .A(n44), .B(n1), .Y(n43) );
  INVX2M U8 ( .A(i_rst_n), .Y(n4) );
  CLKINVX1M U9 ( .A(i_div_ratio[1]), .Y(N19) );
  OAI2BB1X1M U10 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n5), .Y(N20) );
  OR2X1M U11 ( .A(n5), .B(i_div_ratio[3]), .Y(n6) );
  OAI2BB1X1M U12 ( .A0N(n5), .A1N(i_div_ratio[3]), .B0(n6), .Y(N21) );
  OR2X1M U13 ( .A(n6), .B(i_div_ratio[4]), .Y(n7) );
  OAI2BB1X1M U14 ( .A0N(n6), .A1N(i_div_ratio[4]), .B0(n7), .Y(N22) );
  OR2X1M U15 ( .A(n7), .B(i_div_ratio[5]), .Y(n8) );
  OAI2BB1X1M U16 ( .A0N(n7), .A1N(i_div_ratio[5]), .B0(n8), .Y(N23) );
  XNOR2X1M U17 ( .A(i_div_ratio[6]), .B(n8), .Y(N24) );
  NOR3X1M U18 ( .A(i_div_ratio[6]), .B(i_div_ratio[7]), .C(n8), .Y(N26) );
  OAI21X1M U19 ( .A0(i_div_ratio[6]), .A1(n8), .B0(i_div_ratio[7]), .Y(n9) );
  NAND2BX1M U20 ( .AN(N26), .B(n9), .Y(N25) );
  NOR2BX1M U21 ( .AN(prev_div_ratio[0]), .B(i_div_ratio[0]), .Y(n10) );
  OAI2B2X1M U22 ( .A1N(i_div_ratio[1]), .A0(n10), .B0(prev_div_ratio[1]), .B1(
        n10), .Y(n21) );
  NOR2BX1M U23 ( .AN(i_div_ratio[0]), .B(prev_div_ratio[0]), .Y(n11) );
  OAI2B2X1M U24 ( .A1N(prev_div_ratio[1]), .A0(n11), .B0(i_div_ratio[1]), .B1(
        n11), .Y(n20) );
  CLKXOR2X2M U25 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .Y(n13) );
  CLKXOR2X2M U26 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .Y(n12) );
  NOR2X1M U27 ( .A(n13), .B(n12), .Y(n19) );
  CLKXOR2X2M U28 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .Y(n17) );
  CLKXOR2X2M U29 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .Y(n16) );
  CLKXOR2X2M U30 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .Y(n15) );
  CLKXOR2X2M U31 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .Y(n14) );
  NOR4X1M U32 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(n18) );
  CLKMX2X2M U33 ( .A(i_ref_clk), .B(divided_clk), .S0(n22), .Y(o_div_clk) );
  MXI2X1M U34 ( .A(n23), .B(n24), .S0(n25), .Y(n69) );
  NOR2X1M U35 ( .A(n26), .B(n27), .Y(n25) );
  OAI33X1M U36 ( .A0(n28), .A1(n29), .A2(n30), .B0(n40), .B1(n24), .B2(n41), 
        .Y(n27) );
  CLKINVX1M U37 ( .A(n42), .Y(n29) );
  NOR2X1M U38 ( .A(n24), .B(n26), .Y(n23) );
  NAND3BX1M U39 ( .AN(n2), .B(n22), .C(i_clk_en), .Y(n26) );
  CLKMX2X2M U40 ( .A(prev_div_ratio[0]), .B(i_div_ratio[0]), .S0(n2), .Y(n70)
         );
  CLKMX2X2M U41 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .S0(n2), .Y(n71)
         );
  CLKMX2X2M U42 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .S0(n2), .Y(n72)
         );
  CLKMX2X2M U43 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .S0(n2), .Y(n73)
         );
  CLKMX2X2M U44 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .S0(n2), .Y(n74)
         );
  CLKMX2X2M U45 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .S0(n2), .Y(n75)
         );
  CLKMX2X2M U46 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .S0(n2), .Y(n76)
         );
  CLKMX2X2M U47 ( .A(prev_div_ratio[1]), .B(i_div_ratio[1]), .S0(n2), .Y(n77)
         );
  AND2X1M U48 ( .A(N36), .B(n45), .Y(N87) );
  AND2X1M U49 ( .A(N35), .B(n45), .Y(N86) );
  AND2X1M U50 ( .A(N34), .B(n45), .Y(N85) );
  AND2X1M U51 ( .A(N33), .B(n45), .Y(N84) );
  AND2X1M U52 ( .A(N32), .B(n45), .Y(N83) );
  AND2X1M U53 ( .A(N31), .B(n45), .Y(N82) );
  AND2X1M U54 ( .A(N30), .B(n45), .Y(N81) );
  AND2X1M U55 ( .A(N29), .B(n45), .Y(N80) );
  CLKNAND2X2M U56 ( .A(n46), .B(n47), .Y(n45) );
  NAND4BX1M U57 ( .AN(n40), .B(i_clk_en), .C(divided_clk), .D(n41), .Y(n47) );
  CLKNAND2X2M U58 ( .A(n48), .B(n49), .Y(n41) );
  NOR4X1M U59 ( .A(edge_count[7]), .B(n50), .C(n51), .D(n52), .Y(n49) );
  CLKXOR2X2M U60 ( .A(i_div_ratio[3]), .B(edge_count[2]), .Y(n52) );
  CLKXOR2X2M U61 ( .A(i_div_ratio[2]), .B(edge_count[1]), .Y(n51) );
  CLKXOR2X2M U62 ( .A(i_div_ratio[1]), .B(edge_count[0]), .Y(n50) );
  NOR4X1M U63 ( .A(n53), .B(n54), .C(n55), .D(n56), .Y(n48) );
  CLKXOR2X2M U64 ( .A(i_div_ratio[7]), .B(edge_count[6]), .Y(n56) );
  CLKXOR2X2M U65 ( .A(i_div_ratio[6]), .B(edge_count[5]), .Y(n55) );
  CLKXOR2X2M U66 ( .A(i_div_ratio[5]), .B(edge_count[4]), .Y(n54) );
  CLKXOR2X2M U67 ( .A(i_div_ratio[4]), .B(edge_count[3]), .Y(n53) );
  OAI21X1M U68 ( .A0(n30), .A1(n28), .B0(n42), .Y(n46) );
  OAI31X1M U69 ( .A0(n40), .A1(divided_clk), .A2(n44), .B0(n57), .Y(n42) );
  NAND4BX1M U70 ( .AN(i_div_ratio[0]), .B(i_clk_en), .C(n22), .D(n1), .Y(n57)
         );
  CLKINVX1M U71 ( .A(i_clk_en), .Y(n44) );
  NAND3X1M U72 ( .A(n22), .B(n1), .C(i_div_ratio[0]), .Y(n40) );
  OA21X1M U73 ( .A0(n58), .A1(n59), .B0(n68), .Y(n22) );
  OR3X1M U74 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n59) );
  OR4X1M U75 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n58) );
  NAND4X1M U76 ( .A(n60), .B(n61), .C(n62), .D(n63), .Y(n28) );
  XNOR2X1M U77 ( .A(edge_count[0]), .B(N19), .Y(n63) );
  XNOR2X1M U78 ( .A(edge_count[1]), .B(N20), .Y(n62) );
  XNOR2X1M U79 ( .A(edge_count[2]), .B(N21), .Y(n61) );
  XNOR2X1M U80 ( .A(edge_count[7]), .B(N26), .Y(n60) );
  NAND4X1M U81 ( .A(n64), .B(n65), .C(n66), .D(n67), .Y(n30) );
  XNOR2X1M U82 ( .A(edge_count[3]), .B(N22), .Y(n67) );
  XNOR2X1M U83 ( .A(edge_count[4]), .B(N23), .Y(n66) );
  XNOR2X1M U84 ( .A(edge_count[5]), .B(N24), .Y(n65) );
  XNOR2X1M U85 ( .A(edge_count[6]), .B(N25), .Y(n64) );
endmodule


module RST_SYNC_0 ( rst, clk, sync_rst );
  input rst, clk;
  output sync_rst;

  wire   [0:1] flops;

  DFFRQX2M \flops_reg[2]  ( .D(flops[1]), .CK(clk), .RN(rst), .Q(sync_rst) );
  DFFRQX2M \flops_reg[1]  ( .D(flops[0]), .CK(clk), .RN(rst), .Q(flops[1]) );
  DFFRQX2M \flops_reg[0]  ( .D(1'b1), .CK(clk), .RN(rst), .Q(flops[0]) );
endmodule


module RST_SYNC_1 ( rst, clk, sync_rst );
  input rst, clk;
  output sync_rst;

  wire   [0:1] flops;

  DFFRQX2M \flops_reg[2]  ( .D(flops[1]), .CK(clk), .RN(rst), .Q(sync_rst) );
  DFFRQX2M \flops_reg[1]  ( .D(flops[0]), .CK(clk), .RN(rst), .Q(flops[1]) );
  DFFRQX2M \flops_reg[0]  ( .D(1'b1), .CK(clk), .RN(rst), .Q(flops[0]) );
endmodule


module MUX ( ser_data, par_bit, mux_sel, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, par_bit;
  output TX_OUT;
  wire   n2, n3, n1;

  OAI21X4M U3 ( .A0(n2), .A1(n1), .B0(n3), .Y(TX_OUT) );
  NOR2BX2M U4 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
  NAND3X2M U5 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n1) );
endmodule


module Parity_Calc ( Data_Valid, PAR_TYP, clk, rst, P_DATA, par_bit );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, clk, rst;
  output par_bit;
  wire   n1, n3, n4, n5, n6, n7, n2;

  DFFRQX1M par_bit_reg ( .D(n7), .CK(clk), .RN(rst), .Q(par_bit) );
  XNOR2X2M U2 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  XOR3XLM U3 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U4 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n7) );
  INVX2M U6 ( .A(Data_Valid), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
endmodule


module Serializer ( P_DATA, ser_en, clk, rst, ser_done, ser_data );
  input [7:0] P_DATA;
  input ser_en, clk, rst;
  output ser_done, ser_data;
  wire   N5, N6, N7, N13, N26, N27, N28, N30, n2, n3, n5, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n1, n4, n6, n7, n8, n21, n22,
         n23, n24, n25, n26, n27, n28, n29;
  wire   [7:0] Data_In;

  DFFRQX1M \Data_In_reg[0]  ( .D(n20), .CK(clk), .RN(n4), .Q(Data_In[0]) );
  DFFRQX1M \Data_In_reg[7]  ( .D(n13), .CK(clk), .RN(n4), .Q(Data_In[7]) );
  DFFRQX1M \Data_In_reg[5]  ( .D(n15), .CK(clk), .RN(n4), .Q(Data_In[5]) );
  DFFRQX1M \Data_In_reg[3]  ( .D(n17), .CK(clk), .RN(n4), .Q(Data_In[3]) );
  DFFRQX1M \Data_In_reg[1]  ( .D(n19), .CK(clk), .RN(n4), .Q(Data_In[1]) );
  DFFRQX1M \Data_In_reg[6]  ( .D(n14), .CK(clk), .RN(n4), .Q(Data_In[6]) );
  DFFRQX1M \Data_In_reg[4]  ( .D(n16), .CK(clk), .RN(n4), .Q(Data_In[4]) );
  DFFRQX1M \Data_In_reg[2]  ( .D(n18), .CK(clk), .RN(n4), .Q(Data_In[2]) );
  DFFRQX1M ser_done_reg ( .D(N30), .CK(clk), .RN(n4), .Q(ser_done) );
  DFFRQX1M \count_reg[2]  ( .D(N28), .CK(clk), .RN(n4), .Q(N7) );
  DFFRQX1M \count_reg[0]  ( .D(N26), .CK(clk), .RN(n4), .Q(N5) );
  DFFRQX1M ser_data_reg ( .D(n12), .CK(clk), .RN(rst), .Q(ser_data) );
  DFFRQX1M \count_reg[1]  ( .D(N27), .CK(clk), .RN(n4), .Q(N6) );
  BUFX4M U3 ( .A(rst), .Y(n4) );
  INVX2M U4 ( .A(n3), .Y(n25) );
  INVX2M U5 ( .A(P_DATA[0]), .Y(n29) );
  INVX2M U6 ( .A(n1), .Y(n24) );
  NOR2X2M U7 ( .A(n26), .B(n1), .Y(N26) );
  INVX2M U8 ( .A(ser_en), .Y(n26) );
  NOR2X2M U9 ( .A(n9), .B(n28), .Y(N30) );
  NAND3X2M U10 ( .A(n27), .B(n28), .C(N26), .Y(n3) );
  OAI221X1M U11 ( .A0(n26), .A1(n2), .B0(n3), .B1(n29), .C0(n5), .Y(n12) );
  NAND2X2M U12 ( .A(ser_data), .B(n26), .Y(n5) );
  OAI31X1M U13 ( .A0(n1), .A1(N7), .A2(N6), .B0(N13), .Y(n2) );
  OAI2BB2X1M U14 ( .B0(n3), .B1(n29), .A0N(Data_In[0]), .A1N(n3), .Y(n20) );
  BUFX2M U15 ( .A(N5), .Y(n1) );
  AO22X1M U16 ( .A0(P_DATA[6]), .A1(n25), .B0(Data_In[6]), .B1(n3), .Y(n14) );
  AO22X1M U17 ( .A0(P_DATA[2]), .A1(n25), .B0(Data_In[2]), .B1(n3), .Y(n18) );
  AO22X1M U18 ( .A0(P_DATA[7]), .A1(n25), .B0(Data_In[7]), .B1(n3), .Y(n13) );
  AO22X1M U19 ( .A0(P_DATA[3]), .A1(n25), .B0(Data_In[3]), .B1(n3), .Y(n17) );
  AO22X1M U20 ( .A0(P_DATA[1]), .A1(n25), .B0(Data_In[1]), .B1(n3), .Y(n19) );
  AO22X1M U21 ( .A0(P_DATA[5]), .A1(n25), .B0(Data_In[5]), .B1(n3), .Y(n15) );
  AO22X1M U22 ( .A0(P_DATA[4]), .A1(n25), .B0(Data_In[4]), .B1(n3), .Y(n16) );
  NAND3X2M U23 ( .A(n1), .B(ser_en), .C(N6), .Y(n9) );
  INVX2M U24 ( .A(N7), .Y(n28) );
  INVX2M U25 ( .A(N6), .Y(n27) );
  OAI22X1M U26 ( .A0(N7), .A1(n9), .B0(n10), .B1(n28), .Y(N28) );
  AOI21X2M U27 ( .A0(ser_en), .A1(n27), .B0(N26), .Y(n10) );
  NOR2X2M U28 ( .A(n11), .B(n26), .Y(N27) );
  XNOR2X2M U29 ( .A(n1), .B(N6), .Y(n11) );
  AOI22X1M U30 ( .A0(Data_In[2]), .A1(n24), .B0(Data_In[3]), .B1(n1), .Y(n7)
         );
  AOI22X1M U31 ( .A0(Data_In[0]), .A1(n24), .B0(Data_In[1]), .B1(n1), .Y(n6)
         );
  OA22X1M U32 ( .A0(n27), .A1(n7), .B0(N6), .B1(n6), .Y(n23) );
  AOI22X1M U33 ( .A0(Data_In[6]), .A1(n24), .B0(Data_In[7]), .B1(n1), .Y(n21)
         );
  AOI22X1M U34 ( .A0(Data_In[4]), .A1(n24), .B0(Data_In[5]), .B1(n1), .Y(n8)
         );
  OAI22X1M U35 ( .A0(n21), .A1(n27), .B0(N6), .B1(n8), .Y(n22) );
  OAI2BB2X1M U36 ( .B0(n23), .B1(N7), .A0N(N7), .A1N(n22), .Y(N13) );
endmodule


module FSM_TX ( Data_Valid, PAR_EN, ser_done, clk, rst, ser_en, busy, mux_sel
 );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, clk, rst;
  output ser_en, busy;
  wire   n4, n5, n1, n2, n3;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(rst), .Q(
        current_state[1]) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(rst), .Q(
        current_state[2]) );
  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(rst), .Q(
        current_state[0]) );
  INVX2M U3 ( .A(mux_sel[1]), .Y(n2) );
  NAND2X2M U4 ( .A(n2), .B(mux_sel[0]), .Y(next_state[1]) );
  NOR2X2M U5 ( .A(n3), .B(current_state[2]), .Y(mux_sel[1]) );
  NAND2BX2M U6 ( .AN(current_state[2]), .B(current_state[0]), .Y(mux_sel[0])
         );
  INVX2M U7 ( .A(current_state[1]), .Y(n3) );
  AOI21X2M U8 ( .A0(current_state[1]), .A1(ser_done), .B0(mux_sel[0]), .Y(
        ser_en) );
  OAI21X2M U9 ( .A0(current_state[0]), .A1(n3), .B0(mux_sel[0]), .Y(busy) );
  NOR2X2M U10 ( .A(n4), .B(n2), .Y(next_state[2]) );
  AOI2B1X1M U11 ( .A1N(PAR_EN), .A0(ser_done), .B0(n1), .Y(n4) );
  INVX2M U12 ( .A(current_state[0]), .Y(n1) );
  NAND2BX2M U13 ( .AN(ser_en), .B(n5), .Y(next_state[0]) );
  NAND3BX2M U14 ( .AN(current_state[2]), .B(n3), .C(Data_Valid), .Y(n5) );
endmodule


module UART_TX ( Data_Valid, PAR_EN, PAR_TYP, clk, rst, P_DATA, TX_OUT, busy
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, clk, rst;
  output TX_OUT, busy;
  wire   ser_data, par_bit, ser_en, ser_done, n1, n2;
  wire   [1:0] mux_sel;

  MUX U0 ( .ser_data(ser_data), .par_bit(par_bit), .mux_sel(mux_sel), .TX_OUT(
        TX_OUT) );
  Parity_Calc U1 ( .Data_Valid(Data_Valid), .PAR_TYP(PAR_TYP), .clk(clk), 
        .rst(n1), .P_DATA(P_DATA), .par_bit(par_bit) );
  Serializer U2 ( .P_DATA(P_DATA), .ser_en(ser_en), .clk(clk), .rst(n1), 
        .ser_done(ser_done), .ser_data(ser_data) );
  FSM_TX U3 ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(ser_done), 
        .clk(clk), .rst(n1), .ser_en(ser_en), .busy(busy), .mux_sel(mux_sel)
         );
  INVX2M U4 ( .A(n2), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n2) );
endmodule


module parity_checker ( par_chk_en, strt_chk_en, PAR_TYP, rst, clk, 
        majority_bit, P_DATA, edge_cnt, prescale, par_err );
  input [7:0] P_DATA;
  input [5:0] edge_cnt;
  input [5:0] prescale;
  input par_chk_en, strt_chk_en, PAR_TYP, rst, clk, majority_bit;
  output par_err;
  wire   N4, N5, N6, N7, N8, N9, N10, n3, n4, n5, n6, n7, n8, n9, n10, n11, n1,
         n2, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23;

  DFFRQX2M par_err_reg ( .D(n11), .CK(clk), .RN(rst), .Q(par_err) );
  OAI31X1M U3 ( .A0(n3), .A1(strt_chk_en), .A2(n4), .B0(n5), .Y(n11) );
  XOR3XLM U4 ( .A(n6), .B(n7), .C(n8), .Y(n3) );
  NAND2X2M U5 ( .A(par_err), .B(n4), .Y(n5) );
  AOI21X2M U6 ( .A0(par_chk_en), .A1(N10), .B0(strt_chk_en), .Y(n4) );
  XOR3XLM U7 ( .A(P_DATA[6]), .B(P_DATA[5]), .C(n9), .Y(n7) );
  XNOR2X2M U8 ( .A(majority_bit), .B(P_DATA[7]), .Y(n9) );
  XNOR2X2M U9 ( .A(P_DATA[2]), .B(PAR_TYP), .Y(n8) );
  XOR3XLM U10 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n10), .Y(n6) );
  XNOR2X2M U11 ( .A(P_DATA[4]), .B(P_DATA[3]), .Y(n10) );
  OR2X2M U12 ( .A(prescale[1]), .B(prescale[0]), .Y(n1) );
  INVX2M U13 ( .A(prescale[3]), .Y(n14) );
  CLKINVX1M U14 ( .A(prescale[0]), .Y(N4) );
  OAI2BB1X1M U15 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n1), .Y(N5) );
  NOR2X1M U16 ( .A(n1), .B(prescale[2]), .Y(n2) );
  AO21XLM U17 ( .A0(n1), .A1(prescale[2]), .B0(n2), .Y(N6) );
  CLKNAND2X2M U18 ( .A(n2), .B(n14), .Y(n12) );
  OAI21X1M U19 ( .A0(n2), .A1(n14), .B0(n12), .Y(N7) );
  XNOR2X1M U20 ( .A(prescale[4]), .B(n12), .Y(N8) );
  NOR2X1M U21 ( .A(prescale[4]), .B(n12), .Y(n13) );
  CLKXOR2X2M U22 ( .A(prescale[5]), .B(n13), .Y(N9) );
  NOR2BX1M U23 ( .AN(edge_cnt[0]), .B(N4), .Y(n15) );
  OAI2B2X1M U24 ( .A1N(N5), .A0(n15), .B0(edge_cnt[1]), .B1(n15), .Y(n19) );
  NOR2BX1M U25 ( .AN(N4), .B(edge_cnt[0]), .Y(n16) );
  OAI2B2X1M U26 ( .A1N(edge_cnt[1]), .A0(n16), .B0(N5), .B1(n16), .Y(n18) );
  XNOR2X1M U27 ( .A(N9), .B(edge_cnt[5]), .Y(n17) );
  NAND3X1M U28 ( .A(n19), .B(n18), .C(n17), .Y(n23) );
  CLKXOR2X2M U29 ( .A(N8), .B(edge_cnt[4]), .Y(n22) );
  CLKXOR2X2M U30 ( .A(N6), .B(edge_cnt[2]), .Y(n21) );
  CLKXOR2X2M U31 ( .A(N7), .B(edge_cnt[3]), .Y(n20) );
  NOR4X1M U32 ( .A(n23), .B(n22), .C(n21), .D(n20), .Y(N10) );
endmodule


module strt_checker ( strt_chk_en, majority_bit, clk, rst, strt_glitch );
  input strt_chk_en, majority_bit, clk, rst;
  output strt_glitch;
  wire   N4;

  DFFRQX1M strt_glitch_reg ( .D(N4), .CK(clk), .RN(rst), .Q(strt_glitch) );
  AND2X2M U3 ( .A(strt_chk_en), .B(majority_bit), .Y(N4) );
endmodule


module stop_checker ( stp_chk_en, strt_chk_en, clk, rst, majority_bit, 
        prescale, edge_cnt, stp_err );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input stp_chk_en, strt_chk_en, clk, rst, majority_bit;
  output stp_err;
  wire   N2, N3, N4, N5, N6, N7, N8, n5, n6, n7, \sub_14/carry[5] ,
         \sub_14/carry[4] , \sub_14/carry[3] , n1, n2, n3, n4, n8, n9, n10,
         n11, n12;
  assign N2 = prescale[0];

  DFFRQX2M stp_err_reg ( .D(n7), .CK(clk), .RN(rst), .Q(stp_err) );
  NOR2X2M U3 ( .A(strt_chk_en), .B(n5), .Y(n7) );
  AOI2BB2XLM U4 ( .B0(stp_err), .B1(n6), .A0N(majority_bit), .A1N(n6), .Y(n5)
         );
  NAND2X2M U5 ( .A(stp_chk_en), .B(N8), .Y(n6) );
  INVX2M U6 ( .A(prescale[1]), .Y(N3) );
  XNOR2X1M U7 ( .A(prescale[5]), .B(\sub_14/carry[5] ), .Y(N7) );
  OR2X1M U8 ( .A(prescale[4]), .B(\sub_14/carry[4] ), .Y(\sub_14/carry[5] ) );
  XNOR2X1M U9 ( .A(\sub_14/carry[4] ), .B(prescale[4]), .Y(N6) );
  OR2X1M U10 ( .A(prescale[3]), .B(\sub_14/carry[3] ), .Y(\sub_14/carry[4] )
         );
  XNOR2X1M U11 ( .A(\sub_14/carry[3] ), .B(prescale[3]), .Y(N5) );
  OR2X1M U12 ( .A(prescale[2]), .B(prescale[1]), .Y(\sub_14/carry[3] ) );
  XNOR2X1M U13 ( .A(prescale[1]), .B(prescale[2]), .Y(N4) );
  NOR2BX1M U14 ( .AN(edge_cnt[0]), .B(N2), .Y(n1) );
  OAI2B2X1M U15 ( .A1N(N3), .A0(n1), .B0(edge_cnt[1]), .B1(n1), .Y(n8) );
  NOR2BX1M U16 ( .AN(N2), .B(edge_cnt[0]), .Y(n2) );
  OAI2B2X1M U17 ( .A1N(edge_cnt[1]), .A0(n2), .B0(N3), .B1(n2), .Y(n4) );
  XNOR2X1M U18 ( .A(N7), .B(edge_cnt[5]), .Y(n3) );
  NAND3X1M U19 ( .A(n8), .B(n4), .C(n3), .Y(n12) );
  CLKXOR2X2M U20 ( .A(N6), .B(edge_cnt[4]), .Y(n11) );
  CLKXOR2X2M U21 ( .A(N4), .B(edge_cnt[2]), .Y(n10) );
  CLKXOR2X2M U22 ( .A(N5), .B(edge_cnt[3]), .Y(n9) );
  NOR4X1M U23 ( .A(n12), .B(n11), .C(n10), .D(n9), .Y(N8) );
endmodule


module data_sampling ( edge_cnt, prescale, dat_samp_en, clk, rst, RX_IN, 
        majority_bit );
  input [5:0] edge_cnt;
  input [5:0] prescale;
  input dat_samp_en, clk, rst, RX_IN;
  output majority_bit;
  wire   first_sample, second_sample, third_sample, N7, N8, N9, N10, N11, N14,
         N15, N16, N17, N18, N19, n18, n19, n20, \add_21/carry[4] ,
         \add_21/carry[3] , \add_21/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33;

  DFFRQX1M third_sample_reg ( .D(n20), .CK(clk), .RN(rst), .Q(third_sample) );
  DFFRQX1M second_sample_reg ( .D(n18), .CK(clk), .RN(rst), .Q(second_sample)
         );
  DFFRQX1M first_sample_reg ( .D(n19), .CK(clk), .RN(rst), .Q(first_sample) );
  OR2X2M U3 ( .A(prescale[2]), .B(prescale[1]), .Y(n1) );
  ADDHX1M U4 ( .A(prescale[2]), .B(prescale[1]), .CO(\add_21/carry[2] ), .S(
        N15) );
  ADDHX1M U5 ( .A(prescale[4]), .B(\add_21/carry[3] ), .CO(\add_21/carry[4] ), 
        .S(N17) );
  ADDHX1M U6 ( .A(prescale[3]), .B(\add_21/carry[2] ), .CO(\add_21/carry[3] ), 
        .S(N16) );
  ADDHX1M U7 ( .A(prescale[5]), .B(\add_21/carry[4] ), .CO(N19), .S(N18) );
  OAI2BB1X1M U8 ( .A0N(prescale[1]), .A1N(prescale[2]), .B0(n1), .Y(N7) );
  OR2X1M U9 ( .A(n1), .B(prescale[3]), .Y(n2) );
  OAI2BB1X1M U10 ( .A0N(n1), .A1N(prescale[3]), .B0(n2), .Y(N8) );
  XNOR2X1M U11 ( .A(prescale[4]), .B(n2), .Y(N9) );
  NOR3X1M U12 ( .A(prescale[4]), .B(prescale[5]), .C(n2), .Y(N11) );
  OAI21X1M U13 ( .A0(prescale[4]), .A1(n2), .B0(prescale[5]), .Y(n3) );
  NAND2BX1M U14 ( .AN(N11), .B(n3), .Y(N10) );
  CLKINVX1M U15 ( .A(prescale[1]), .Y(N14) );
  CLKMX2X2M U16 ( .A(third_sample), .B(RX_IN), .S0(n4), .Y(n20) );
  NOR4X1M U17 ( .A(n5), .B(n6), .C(n7), .D(n8), .Y(n4) );
  CLKXOR2X2M U18 ( .A(edge_cnt[1]), .B(N15), .Y(n8) );
  CLKXOR2X2M U19 ( .A(edge_cnt[0]), .B(N14), .Y(n7) );
  NAND2BX1M U20 ( .AN(n9), .B(n10), .Y(n6) );
  NAND4X1M U21 ( .A(n11), .B(n12), .C(n13), .D(n14), .Y(n5) );
  XNOR2X1M U22 ( .A(edge_cnt[2]), .B(N16), .Y(n14) );
  XNOR2X1M U23 ( .A(edge_cnt[3]), .B(N17), .Y(n13) );
  XNOR2X1M U24 ( .A(edge_cnt[4]), .B(N18), .Y(n12) );
  XNOR2X1M U25 ( .A(edge_cnt[5]), .B(N19), .Y(n11) );
  CLKMX2X2M U26 ( .A(first_sample), .B(RX_IN), .S0(n15), .Y(n19) );
  NOR2BX1M U27 ( .AN(dat_samp_en), .B(n16), .Y(n15) );
  CLKMX2X2M U28 ( .A(second_sample), .B(RX_IN), .S0(n17), .Y(n18) );
  NOR2X1M U29 ( .A(n9), .B(n10), .Y(n17) );
  NAND4X1M U30 ( .A(n21), .B(n22), .C(n23), .D(n24), .Y(n10) );
  NOR3X1M U31 ( .A(n25), .B(edge_cnt[5]), .C(n26), .Y(n24) );
  CLKXOR2X2M U32 ( .A(prescale[1]), .B(edge_cnt[0]), .Y(n26) );
  CLKXOR2X2M U33 ( .A(prescale[5]), .B(edge_cnt[4]), .Y(n25) );
  XNOR2X1M U34 ( .A(edge_cnt[2]), .B(prescale[3]), .Y(n23) );
  XNOR2X1M U35 ( .A(edge_cnt[3]), .B(prescale[4]), .Y(n22) );
  XNOR2X1M U36 ( .A(edge_cnt[1]), .B(prescale[2]), .Y(n21) );
  CLKNAND2X2M U37 ( .A(dat_samp_en), .B(n16), .Y(n9) );
  NAND4X1M U38 ( .A(n27), .B(n28), .C(n29), .D(n30), .Y(n16) );
  NOR3X1M U39 ( .A(n31), .B(n32), .C(n33), .Y(n30) );
  CLKXOR2X2M U40 ( .A(edge_cnt[4]), .B(N10), .Y(n33) );
  CLKXOR2X2M U41 ( .A(edge_cnt[0]), .B(N14), .Y(n32) );
  CLKXOR2X2M U42 ( .A(edge_cnt[5]), .B(N11), .Y(n31) );
  XNOR2X1M U43 ( .A(edge_cnt[2]), .B(N8), .Y(n29) );
  XNOR2X1M U44 ( .A(edge_cnt[3]), .B(N9), .Y(n28) );
  XNOR2X1M U45 ( .A(edge_cnt[1]), .B(N7), .Y(n27) );
  ADDFX1M U46 ( .A(second_sample), .B(third_sample), .CI(first_sample), .CO(
        majority_bit) );
endmodule


module deserializer ( deser_en, majority_bit, clk, rst, P_DATA );
  output [7:0] P_DATA;
  input deser_en, majority_bit, clk, rst;
  wire   n1, n2, n5, n8, n9, n11, n12, n13, n15, n16, n18, n20, n22, n24, n25,
         n27, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n3, n4, n6, n7, n10, n14, n17, n19, n21, n23,
         n26, n28, n47, n48, n49;
  wire   [3:0] counter;
  wire   [6:0] data;

  DFFRQX1M \data_reg[6]  ( .D(n33), .CK(clk), .RN(n4), .Q(data[6]) );
  DFFRQX1M \data_reg[2]  ( .D(n41), .CK(clk), .RN(n4), .Q(data[2]) );
  DFFRQX1M \data_reg[5]  ( .D(n35), .CK(clk), .RN(n4), .Q(data[5]) );
  DFFRQX1M \data_reg[4]  ( .D(n37), .CK(clk), .RN(n4), .Q(data[4]) );
  DFFRQX1M \data_reg[0]  ( .D(n45), .CK(clk), .RN(n4), .Q(data[0]) );
  DFFRQX1M \data_reg[3]  ( .D(n39), .CK(clk), .RN(n4), .Q(data[3]) );
  DFFRQX1M \data_reg[1]  ( .D(n43), .CK(clk), .RN(n4), .Q(data[1]) );
  DFFRQX1M \counter_reg[0]  ( .D(n31), .CK(clk), .RN(n4), .Q(counter[0]) );
  DFFRQX1M \P_DATA_reg[5]  ( .D(n34), .CK(clk), .RN(n4), .Q(P_DATA[5]) );
  DFFRQX1M \P_DATA_reg[0]  ( .D(n44), .CK(clk), .RN(n4), .Q(P_DATA[0]) );
  DFFRQX1M \P_DATA_reg[6]  ( .D(n32), .CK(clk), .RN(n4), .Q(P_DATA[6]) );
  DFFRQX1M \P_DATA_reg[1]  ( .D(n42), .CK(clk), .RN(rst), .Q(P_DATA[1]) );
  DFFRQX1M \P_DATA_reg[2]  ( .D(n40), .CK(clk), .RN(n4), .Q(P_DATA[2]) );
  DFFRQX1M \P_DATA_reg[4]  ( .D(n36), .CK(clk), .RN(n4), .Q(P_DATA[4]) );
  DFFRQX1M \counter_reg[1]  ( .D(n30), .CK(clk), .RN(n4), .Q(counter[1]) );
  DFFRQX1M \counter_reg[2]  ( .D(n29), .CK(clk), .RN(n4), .Q(counter[2]) );
  DFFRQX1M \P_DATA_reg[7]  ( .D(n46), .CK(clk), .RN(n4), .Q(P_DATA[7]) );
  DFFRQX1M \P_DATA_reg[3]  ( .D(n38), .CK(clk), .RN(rst), .Q(P_DATA[3]) );
  CLKINVX1M U3 ( .A(rst), .Y(n6) );
  INVX4M U4 ( .A(n6), .Y(n4) );
  OR2X2M U5 ( .A(n8), .B(n49), .Y(n12) );
  BUFX2M U6 ( .A(n9), .Y(n3) );
  NAND2X2M U7 ( .A(deser_en), .B(n10), .Y(n8) );
  NAND2X2M U8 ( .A(majority_bit), .B(n7), .Y(n15) );
  OAI221X1M U9 ( .A0(n1), .A1(n2), .B0(n7), .B1(n17), .C0(n5), .Y(n29) );
  CLKXOR2X2M U10 ( .A(n14), .B(n2), .Y(n30) );
  OAI22X1M U11 ( .A0(n15), .A1(n24), .B0(n25), .B1(n48), .Y(n43) );
  NOR2X2M U12 ( .A(n2), .B(n24), .Y(n25) );
  OAI22X1M U13 ( .A0(n1), .A1(n15), .B0(n20), .B1(n47), .Y(n39) );
  NOR2X2M U14 ( .A(n1), .B(n2), .Y(n20) );
  OAI22X1M U15 ( .A0(n1), .A1(n12), .B0(n22), .B1(n21), .Y(n41) );
  NOR2X2M U16 ( .A(n1), .B(n8), .Y(n22) );
  OAI22X1M U17 ( .A0(n12), .A1(n24), .B0(n27), .B1(n28), .Y(n45) );
  NOR2X2M U18 ( .A(n8), .B(n24), .Y(n27) );
  OAI22X1M U19 ( .A0(n12), .A1(n5), .B0(n18), .B1(n26), .Y(n37) );
  NOR2X2M U20 ( .A(n8), .B(n5), .Y(n18) );
  OAI22X1M U21 ( .A0(n5), .A1(n15), .B0(n16), .B1(n23), .Y(n35) );
  NOR2X2M U22 ( .A(n2), .B(n5), .Y(n16) );
  OAI22X1M U23 ( .A0(n11), .A1(n12), .B0(n13), .B1(n19), .Y(n33) );
  NOR2X2M U24 ( .A(n11), .B(n8), .Y(n13) );
  INVX2M U25 ( .A(n2), .Y(n7) );
  OAI21X2M U26 ( .A0(deser_en), .A1(n10), .B0(n8), .Y(n31) );
  NAND2BX2M U27 ( .AN(n11), .B(n7), .Y(n9) );
  INVX2M U28 ( .A(majority_bit), .Y(n49) );
  NAND2X2M U29 ( .A(n17), .B(n14), .Y(n24) );
  NAND2X2M U30 ( .A(deser_en), .B(counter[0]), .Y(n2) );
  OAI2BB2X1M U31 ( .B0(n3), .B1(n49), .A0N(P_DATA[7]), .A1N(n3), .Y(n46) );
  OAI2BB2X1M U32 ( .B0(n3), .B1(n48), .A0N(P_DATA[1]), .A1N(n3), .Y(n42) );
  OAI2BB2X1M U33 ( .B0(n9), .B1(n47), .A0N(P_DATA[3]), .A1N(n3), .Y(n38) );
  OAI2BB2X1M U34 ( .B0(n9), .B1(n28), .A0N(P_DATA[0]), .A1N(n3), .Y(n44) );
  OAI2BB2X1M U35 ( .B0(n9), .B1(n26), .A0N(P_DATA[4]), .A1N(n3), .Y(n36) );
  OAI2BB2X1M U36 ( .B0(n9), .B1(n23), .A0N(P_DATA[5]), .A1N(n3), .Y(n34) );
  OAI2BB2X1M U37 ( .B0(n9), .B1(n21), .A0N(P_DATA[2]), .A1N(n3), .Y(n40) );
  OAI2BB2X1M U38 ( .B0(n9), .B1(n19), .A0N(P_DATA[6]), .A1N(n3), .Y(n32) );
  NAND2X2M U39 ( .A(counter[1]), .B(n17), .Y(n1) );
  NAND2X2M U40 ( .A(counter[2]), .B(n14), .Y(n5) );
  NAND2X2M U41 ( .A(counter[1]), .B(counter[2]), .Y(n11) );
  INVX2M U42 ( .A(counter[1]), .Y(n14) );
  INVX2M U43 ( .A(counter[2]), .Y(n17) );
  INVX2M U44 ( .A(counter[0]), .Y(n10) );
  INVX2M U45 ( .A(data[1]), .Y(n48) );
  INVX2M U46 ( .A(data[3]), .Y(n47) );
  INVX2M U47 ( .A(data[0]), .Y(n28) );
  INVX2M U48 ( .A(data[4]), .Y(n26) );
  INVX2M U49 ( .A(data[5]), .Y(n23) );
  INVX2M U50 ( .A(data[2]), .Y(n21) );
  INVX2M U51 ( .A(data[6]), .Y(n19) );
endmodule


module edge_bit_counter ( enable, clk, rst, prescale, edge_cnt );
  input [5:0] prescale;
  output [5:0] edge_cnt;
  input enable, clk, rst;
  wire   N4, N5, N6, N7, N8, N9, N10, N12, N13, N14, N15, N16, N17, n4, n5, n6,
         n7, n8, n9, n10, \add_18/carry[5] , \add_18/carry[4] ,
         \add_18/carry[3] , \add_18/carry[2] , n1, n2, n3, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24;

  DFFRQX2M \edges_counter_reg[5]  ( .D(n9), .CK(clk), .RN(n1), .Q(edge_cnt[5])
         );
  DFFRQX2M \edges_counter_reg[3]  ( .D(n7), .CK(clk), .RN(n1), .Q(edge_cnt[3])
         );
  DFFRQX2M \edges_counter_reg[2]  ( .D(n6), .CK(clk), .RN(n1), .Q(edge_cnt[2])
         );
  DFFRQX2M \edges_counter_reg[4]  ( .D(n8), .CK(clk), .RN(n1), .Q(edge_cnt[4])
         );
  DFFRQX4M \edges_counter_reg[1]  ( .D(n5), .CK(clk), .RN(n1), .Q(edge_cnt[1])
         );
  DFFRQX4M \edges_counter_reg[0]  ( .D(n10), .CK(clk), .RN(n1), .Q(edge_cnt[0]) );
  INVX2M U3 ( .A(enable), .Y(n24) );
  INVX2M U4 ( .A(n2), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n2) );
  NOR2X2M U6 ( .A(N10), .B(n24), .Y(n4) );
  AO22X1M U7 ( .A0(edge_cnt[0]), .A1(n24), .B0(N12), .B1(n4), .Y(n10) );
  AO22X1M U8 ( .A0(edge_cnt[1]), .A1(n24), .B0(N13), .B1(n4), .Y(n5) );
  AO22X1M U9 ( .A0(edge_cnt[4]), .A1(n24), .B0(N16), .B1(n4), .Y(n8) );
  AO22X1M U10 ( .A0(edge_cnt[2]), .A1(n24), .B0(N14), .B1(n4), .Y(n6) );
  AO22X1M U11 ( .A0(edge_cnt[3]), .A1(n24), .B0(N15), .B1(n4), .Y(n7) );
  AO22X1M U12 ( .A0(edge_cnt[5]), .A1(n24), .B0(N17), .B1(n4), .Y(n9) );
  ADDHX1M U13 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .CO(\add_18/carry[2] ), .S(
        N13) );
  ADDHX1M U14 ( .A(edge_cnt[2]), .B(\add_18/carry[2] ), .CO(\add_18/carry[3] ), 
        .S(N14) );
  ADDHX1M U15 ( .A(edge_cnt[3]), .B(\add_18/carry[3] ), .CO(\add_18/carry[4] ), 
        .S(N15) );
  ADDHX1M U16 ( .A(edge_cnt[4]), .B(\add_18/carry[4] ), .CO(\add_18/carry[5] ), 
        .S(N16) );
  OR2X2M U17 ( .A(prescale[1]), .B(prescale[0]), .Y(n3) );
  INVX2M U18 ( .A(prescale[3]), .Y(n14) );
  CLKINVX1M U19 ( .A(prescale[0]), .Y(N4) );
  OAI2BB1X1M U20 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n3), .Y(N5) );
  NOR2X1M U21 ( .A(n3), .B(prescale[2]), .Y(n11) );
  AO21XLM U22 ( .A0(n3), .A1(prescale[2]), .B0(n11), .Y(N6) );
  CLKNAND2X2M U23 ( .A(n11), .B(n14), .Y(n12) );
  OAI21X1M U24 ( .A0(n11), .A1(n14), .B0(n12), .Y(N7) );
  XNOR2X1M U25 ( .A(prescale[4]), .B(n12), .Y(N8) );
  NOR2X1M U26 ( .A(prescale[4]), .B(n12), .Y(n13) );
  CLKXOR2X2M U27 ( .A(prescale[5]), .B(n13), .Y(N9) );
  CLKINVX1M U28 ( .A(edge_cnt[0]), .Y(N12) );
  CLKXOR2X2M U29 ( .A(\add_18/carry[5] ), .B(edge_cnt[5]), .Y(N17) );
  NOR2BX1M U30 ( .AN(edge_cnt[0]), .B(N4), .Y(n15) );
  OAI2B2X1M U31 ( .A1N(N5), .A0(n15), .B0(edge_cnt[1]), .B1(n15), .Y(n19) );
  NOR2BX1M U32 ( .AN(N4), .B(edge_cnt[0]), .Y(n16) );
  OAI2B2X1M U33 ( .A1N(edge_cnt[1]), .A0(n16), .B0(N5), .B1(n16), .Y(n18) );
  XNOR2X1M U34 ( .A(N9), .B(edge_cnt[5]), .Y(n17) );
  NAND3X1M U35 ( .A(n19), .B(n18), .C(n17), .Y(n23) );
  CLKXOR2X2M U36 ( .A(N8), .B(edge_cnt[4]), .Y(n22) );
  CLKXOR2X2M U37 ( .A(N6), .B(edge_cnt[2]), .Y(n21) );
  CLKXOR2X2M U38 ( .A(N7), .B(edge_cnt[3]), .Y(n20) );
  NOR4X1M U39 ( .A(n23), .B(n22), .C(n21), .D(n20), .Y(N10) );
endmodule


module FSM_RX ( PAR_EN, RX_IN, strt_glitch, clk, rst, prescale, edge_cnt, 
        dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en, data_valid, deser_en, 
        enable );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input PAR_EN, RX_IN, strt_glitch, clk, rst;
  output dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en, data_valid,
         deser_en, enable;
  wire   N31, N32, N33, N34, N35, N36, N37, N38, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [2:0] data_counter;

  DFFRQX1M \data_counter_reg[2]  ( .D(n31), .CK(clk), .RN(n2), .Q(
        data_counter[2]) );
  DFFRQX1M \data_counter_reg[1]  ( .D(n30), .CK(clk), .RN(n2), .Q(
        data_counter[1]) );
  DFFRQX1M \data_counter_reg[0]  ( .D(n32), .CK(clk), .RN(n2), .Q(
        data_counter[0]) );
  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(n2), .Q(
        current_state[1]) );
  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(n2), .Q(
        current_state[0]) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(n2), .Q(
        current_state[2]) );
  DFFRQX1M data_valid_reg ( .D(N38), .CK(clk), .RN(n2), .Q(data_valid) );
  NOR3X6M U3 ( .A(current_state[1]), .B(current_state[2]), .C(n34), .Y(
        strt_chk_en) );
  NOR4X4M U4 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(N37) );
  NAND2XLM U5 ( .A(N37), .B(n21), .Y(n20) );
  INVX2M U6 ( .A(n3), .Y(n2) );
  INVX2M U7 ( .A(rst), .Y(n3) );
  INVX2M U8 ( .A(n20), .Y(deser_en) );
  NOR2X2M U9 ( .A(n41), .B(n35), .Y(N38) );
  NAND3BX2M U10 ( .AN(n21), .B(n36), .C(n22), .Y(next_state[1]) );
  AOI32XLM U11 ( .A0(N37), .A1(n42), .A2(strt_chk_en), .B0(stp_chk_en), .B1(
        n41), .Y(n22) );
  INVXLM U12 ( .A(N37), .Y(n41) );
  NAND2X2M U13 ( .A(deser_en), .B(n19), .Y(n26) );
  AO21XLM U14 ( .A0(N37), .A1(strt_chk_en), .B0(deser_en), .Y(n29) );
  INVX2M U15 ( .A(stp_chk_en), .Y(n35) );
  NOR2X2M U16 ( .A(n21), .B(strt_chk_en), .Y(n24) );
  INVX2M U17 ( .A(par_chk_en), .Y(n36) );
  OAI221XLM U18 ( .A0(RX_IN), .A1(n23), .B0(N37), .B1(n24), .C0(n25), .Y(
        next_state[0]) );
  AOI22X1M U19 ( .A0(n21), .A1(n19), .B0(strt_chk_en), .B1(n42), .Y(n25) );
  AOI32XLM U20 ( .A0(n37), .A1(n38), .A2(n34), .B0(stp_chk_en), .B1(N37), .Y(
        n23) );
  OAI32X1M U21 ( .A0(n26), .A1(n33), .A2(n39), .B0(n28), .B1(n40), .Y(n31) );
  INVX2M U22 ( .A(data_counter[2]), .Y(n40) );
  AND2X2M U23 ( .A(n26), .B(n27), .Y(n28) );
  OAI32X1M U24 ( .A0(n26), .A1(data_counter[1]), .A2(n33), .B0(n27), .B1(n39), 
        .Y(n30) );
  OAI21BX1M U25 ( .A0(n41), .A1(n36), .B0N(n18), .Y(next_state[2]) );
  OAI32XLM U26 ( .A0(n19), .A1(PAR_EN), .A2(n20), .B0(N37), .B1(n35), .Y(n18)
         );
  OAI22X1M U27 ( .A0(n33), .A1(n29), .B0(data_counter[0]), .B1(n26), .Y(n32)
         );
  OA21X2M U28 ( .A0(data_counter[0]), .A1(n26), .B0(n29), .Y(n27) );
  NOR3X4M U29 ( .A(n34), .B(current_state[2]), .C(n37), .Y(n21) );
  NOR3X4M U30 ( .A(n37), .B(current_state[0]), .C(n38), .Y(stp_chk_en) );
  NOR3X2M U31 ( .A(current_state[0]), .B(current_state[2]), .C(n37), .Y(
        par_chk_en) );
  INVX2M U32 ( .A(current_state[1]), .Y(n37) );
  INVX2M U33 ( .A(current_state[0]), .Y(n34) );
  INVX2M U34 ( .A(current_state[2]), .Y(n38) );
  NAND3X2M U35 ( .A(data_counter[1]), .B(data_counter[0]), .C(data_counter[2]), 
        .Y(n19) );
  INVX2M U36 ( .A(data_counter[0]), .Y(n33) );
  INVX2M U37 ( .A(data_counter[1]), .Y(n39) );
  INVX2M U38 ( .A(strt_glitch), .Y(n42) );
  OR2X2M U39 ( .A(prescale[1]), .B(prescale[0]), .Y(n4) );
  INVX2M U40 ( .A(prescale[3]), .Y(n8) );
  BUFX2M U41 ( .A(dat_samp_en), .Y(enable) );
  NAND3X2M U42 ( .A(n36), .B(n35), .C(n24), .Y(dat_samp_en) );
  CLKINVX1M U43 ( .A(prescale[0]), .Y(N31) );
  OAI2BB1X1M U44 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n4), .Y(N32) );
  NOR2X1M U45 ( .A(n4), .B(prescale[2]), .Y(n5) );
  AO21XLM U46 ( .A0(n4), .A1(prescale[2]), .B0(n5), .Y(N33) );
  CLKNAND2X2M U47 ( .A(n5), .B(n8), .Y(n6) );
  OAI21X1M U48 ( .A0(n5), .A1(n8), .B0(n6), .Y(N34) );
  XNOR2X1M U49 ( .A(prescale[4]), .B(n6), .Y(N35) );
  NOR2X1M U50 ( .A(prescale[4]), .B(n6), .Y(n7) );
  CLKXOR2X2M U51 ( .A(prescale[5]), .B(n7), .Y(N36) );
  NOR2BX1M U52 ( .AN(edge_cnt[0]), .B(N31), .Y(n9) );
  OAI2B2X1M U53 ( .A1N(N32), .A0(n9), .B0(edge_cnt[1]), .B1(n9), .Y(n13) );
  NOR2BX1M U54 ( .AN(N31), .B(edge_cnt[0]), .Y(n10) );
  OAI2B2X1M U55 ( .A1N(edge_cnt[1]), .A0(n10), .B0(N32), .B1(n10), .Y(n12) );
  XNOR2X1M U56 ( .A(N36), .B(edge_cnt[5]), .Y(n11) );
  NAND3X1M U57 ( .A(n13), .B(n12), .C(n11), .Y(n17) );
  CLKXOR2X2M U58 ( .A(N35), .B(edge_cnt[4]), .Y(n16) );
  CLKXOR2X2M U59 ( .A(N33), .B(edge_cnt[2]), .Y(n15) );
  CLKXOR2X2M U60 ( .A(N34), .B(edge_cnt[3]), .Y(n14) );
endmodule


module UART_RX ( RX_IN, clk, rst, PAR_EN, PAR_TYP, prescale, P_DATA, 
        data_valid, par_err, stp_err );
  input [5:0] prescale;
  output [7:0] P_DATA;
  input RX_IN, clk, rst, PAR_EN, PAR_TYP;
  output data_valid, par_err, stp_err;
  wire   par_chk_en, majority_bit, strt_chk_en, strt_glitch, stp_chk_en,
         dat_samp_en, deser_en, enable, n1, n2;
  wire   [5:0] edge_cnt;

  parity_checker U0 ( .par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), 
        .PAR_TYP(PAR_TYP), .rst(n1), .clk(clk), .majority_bit(majority_bit), 
        .P_DATA(P_DATA), .edge_cnt(edge_cnt), .prescale(prescale), .par_err(
        par_err) );
  strt_checker U1 ( .strt_chk_en(strt_chk_en), .majority_bit(majority_bit), 
        .clk(clk), .rst(n1), .strt_glitch(strt_glitch) );
  stop_checker U2 ( .stp_chk_en(stp_chk_en), .strt_chk_en(strt_chk_en), .clk(
        clk), .rst(n1), .majority_bit(majority_bit), .prescale(prescale), 
        .edge_cnt(edge_cnt), .stp_err(stp_err) );
  data_sampling U3 ( .edge_cnt(edge_cnt), .prescale(prescale), .dat_samp_en(
        dat_samp_en), .clk(clk), .rst(n1), .RX_IN(RX_IN), .majority_bit(
        majority_bit) );
  deserializer U4 ( .deser_en(deser_en), .majority_bit(majority_bit), .clk(clk), .rst(n1), .P_DATA(P_DATA) );
  edge_bit_counter U5 ( .enable(enable), .clk(clk), .rst(n1), .prescale(
        prescale), .edge_cnt(edge_cnt) );
  FSM_RX U6 ( .PAR_EN(PAR_EN), .RX_IN(RX_IN), .strt_glitch(strt_glitch), .clk(
        clk), .rst(n1), .prescale(prescale), .edge_cnt(edge_cnt), 
        .dat_samp_en(dat_samp_en), .par_chk_en(par_chk_en), .strt_chk_en(
        strt_chk_en), .stp_chk_en(stp_chk_en), .data_valid(data_valid), 
        .deser_en(deser_en), .enable(enable) );
  INVX2M U7 ( .A(n2), .Y(n1) );
  INVX2M U8 ( .A(rst), .Y(n2) );
endmodule


module UART ( RST, TX_CLK, RX_CLK, RX_IN_S, parity_enable, parity_type, 
        TX_IN_V, Prescale, TX_IN_P, RX_OUT_P, RX_OUT_V, TX_OUT_S, TX_OUT_V, 
        parity_error, framing_error );
  input [5:0] Prescale;
  input [7:0] TX_IN_P;
  output [7:0] RX_OUT_P;
  input RST, TX_CLK, RX_CLK, RX_IN_S, parity_enable, parity_type, TX_IN_V;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V, parity_error, framing_error;
  wire   n1, n2;

  UART_TX U0_UART_TX ( .Data_Valid(TX_IN_V), .PAR_EN(parity_enable), .PAR_TYP(
        parity_type), .clk(TX_CLK), .rst(n1), .P_DATA(TX_IN_P), .TX_OUT(
        TX_OUT_S), .busy(TX_OUT_V) );
  UART_RX U0_UART_RX ( .RX_IN(RX_IN_S), .clk(RX_CLK), .rst(n1), .PAR_EN(
        parity_enable), .PAR_TYP(parity_type), .prescale(Prescale), .P_DATA(
        RX_OUT_P), .data_valid(RX_OUT_V), .par_err(parity_error), .stp_err(
        framing_error) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module DATA_SYNC ( clk, rst, bus_enable, unsync_bus, sync_bus, enable_pulse );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input clk, rst, bus_enable;
  output enable_pulse;
  wire   enable_flop, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12;
  wire   [0:1] multi_flops;

  DFFRQX2M enable_flop_reg ( .D(multi_flops[1]), .CK(clk), .RN(n10), .Q(
        enable_flop) );
  DFFRQX2M \multi_flops_reg[1]  ( .D(multi_flops[0]), .CK(clk), .RN(n10), .Q(
        multi_flops[1]) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(clk), .RN(n10), .Q(sync_bus[7]) );
  DFFRQX2M \sync_bus_reg[4]  ( .D(n6), .CK(clk), .RN(n10), .Q(sync_bus[4]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(clk), .RN(n10), .Q(sync_bus[5]) );
  DFFRQX2M \sync_bus_reg[6]  ( .D(n8), .CK(clk), .RN(n10), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(clk), .RN(n10), .Q(sync_bus[3]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(clk), .RN(n10), .Q(sync_bus[1]) );
  DFFRQX2M \sync_bus_reg[2]  ( .D(n4), .CK(clk), .RN(n10), .Q(sync_bus[2]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(clk), .RN(n10), .Q(sync_bus[0]) );
  DFFRQX2M enable_pulse_reg ( .D(n12), .CK(clk), .RN(n10), .Q(enable_pulse) );
  DFFRQX2M \multi_flops_reg[0]  ( .D(bus_enable), .CK(clk), .RN(n10), .Q(
        multi_flops[0]) );
  NAND2BX2M U3 ( .AN(enable_flop), .B(multi_flops[1]), .Y(n1) );
  INVX2M U4 ( .A(n1), .Y(n12) );
  INVX4M U5 ( .A(n11), .Y(n10) );
  INVX2M U6 ( .A(rst), .Y(n11) );
  AO22X1M U7 ( .A0(unsync_bus[0]), .A1(n12), .B0(sync_bus[0]), .B1(n1), .Y(n2)
         );
  AO22X1M U8 ( .A0(unsync_bus[6]), .A1(n12), .B0(sync_bus[6]), .B1(n1), .Y(n8)
         );
  AO22X1M U9 ( .A0(unsync_bus[2]), .A1(n12), .B0(sync_bus[2]), .B1(n1), .Y(n4)
         );
  AO22X1M U10 ( .A0(unsync_bus[1]), .A1(n12), .B0(sync_bus[1]), .B1(n1), .Y(n3) );
  AO22X1M U11 ( .A0(unsync_bus[3]), .A1(n12), .B0(sync_bus[3]), .B1(n1), .Y(n5) );
  AO22X1M U12 ( .A0(unsync_bus[4]), .A1(n12), .B0(sync_bus[4]), .B1(n1), .Y(n6) );
  AO22X1M U13 ( .A0(unsync_bus[5]), .A1(n12), .B0(sync_bus[5]), .B1(n1), .Y(n7) );
  AO22X1M U14 ( .A0(unsync_bus[7]), .A1(n12), .B0(sync_bus[7]), .B1(n1), .Y(n9) );
endmodule


module SYS_CTRL ( Rd_D, sync_bus, Rd_D_Vld, clk, rst, out_valid, enable_pulse, 
        FIFO_FULL, ALU_OUT, Addr, FUN, en, WrEn, RdEn, Gate_EN, WR_INC, 
        clk_div_en, Wr_D, WR_DATA );
  input [7:0] Rd_D;
  input [7:0] sync_bus;
  input [15:0] ALU_OUT;
  output [3:0] Addr;
  output [3:0] FUN;
  output [7:0] Wr_D;
  output [7:0] WR_DATA;
  input Rd_D_Vld, clk, rst, out_valid, enable_pulse, FIFO_FULL;
  output en, WrEn, RdEn, Gate_EN, WR_INC, clk_div_en;
  wire   n1, n2, n3, n4, n12, n13, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n8, n9, n10, n11, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n94, n95, n96, n97, n98, n99, n100, n101;
  wire   [3:0] current_state;
  wire   [7:0] command;
  wire   [3:0] next_state;

  OAI222X4M U81 ( .A0(n24), .A1(n51), .B0(n73), .B1(n4), .C0(n101), .C1(n72), 
        .Y(Addr[0]) );
  DFFRX1M \addr_reg_reg[3]  ( .D(n82), .CK(clk), .RN(n11), .QN(n1) );
  DFFRX1M \addr_reg_reg[2]  ( .D(n83), .CK(clk), .RN(n11), .QN(n2) );
  DFFRX1M \addr_reg_reg[0]  ( .D(n85), .CK(clk), .RN(n11), .QN(n4) );
  DFFRX1M \addr_reg_reg[1]  ( .D(n84), .CK(clk), .RN(n11), .QN(n3) );
  DFFRQX2M \command_reg[1]  ( .D(n87), .CK(clk), .RN(n11), .Q(command[1]) );
  DFFRQX2M \command_reg[3]  ( .D(n89), .CK(clk), .RN(n14), .Q(command[3]) );
  DFFRQX2M \command_reg[0]  ( .D(n86), .CK(clk), .RN(n11), .Q(command[0]) );
  DFFRQX2M \command_reg[4]  ( .D(n90), .CK(clk), .RN(n14), .Q(command[4]) );
  DFFRQX2M \command_reg[2]  ( .D(n88), .CK(clk), .RN(n11), .Q(command[2]) );
  DFFRQX2M \command_reg[6]  ( .D(n92), .CK(clk), .RN(n14), .Q(command[6]) );
  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(n11), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(n11), .Q(
        current_state[0]) );
  DFFRX1M \command_reg[7]  ( .D(n93), .CK(clk), .RN(n11), .QN(n12) );
  DFFRX1M \command_reg[5]  ( .D(n91), .CK(clk), .RN(n11), .QN(n13) );
  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(n11), .Q(
        current_state[2]) );
  DFFRQX2M \current_state_reg[3]  ( .D(next_state[3]), .CK(clk), .RN(n11), .Q(
        current_state[3]) );
  INVX2M U3 ( .A(1'b0), .Y(clk_div_en) );
  OAI22X4M U5 ( .A0(n99), .A1(n72), .B0(n73), .B1(n2), .Y(Addr[2]) );
  OAI22X1M U6 ( .A0(n50), .A1(n49), .B0(n29), .B1(n24), .Y(WrEn) );
  BUFX2M U7 ( .A(n57), .Y(n10) );
  INVX2M U8 ( .A(n34), .Y(n20) );
  INVX2M U9 ( .A(WrEn), .Y(n16) );
  INVX2M U10 ( .A(n72), .Y(RdEn) );
  INVX2M U11 ( .A(n10), .Y(n23) );
  INVX4M U12 ( .A(n15), .Y(n11) );
  INVX2M U13 ( .A(n15), .Y(n14) );
  NOR2X4M U14 ( .A(n98), .B(n27), .Y(FUN[3]) );
  NAND2X2M U15 ( .A(n74), .B(n49), .Y(n40) );
  NAND2X2M U16 ( .A(n49), .B(n40), .Y(n48) );
  NOR2X4M U17 ( .A(n101), .B(n27), .Y(FUN[0]) );
  NOR2X2M U18 ( .A(n99), .B(n27), .Y(FUN[2]) );
  NOR2X2M U19 ( .A(n100), .B(n27), .Y(FUN[1]) );
  NAND2BX2M U20 ( .AN(n74), .B(n39), .Y(n72) );
  NAND2X2M U21 ( .A(n71), .B(n77), .Y(n34) );
  AND2X2M U22 ( .A(n60), .B(n71), .Y(n39) );
  AND2X2M U23 ( .A(n41), .B(n51), .Y(n29) );
  NOR2X2M U24 ( .A(n16), .B(n97), .Y(Wr_D[4]) );
  NOR2X2M U25 ( .A(n16), .B(n96), .Y(Wr_D[5]) );
  NOR2X2M U26 ( .A(n16), .B(n94), .Y(Wr_D[7]) );
  NOR2X2M U27 ( .A(n16), .B(n95), .Y(Wr_D[6]) );
  NOR2X2M U28 ( .A(n16), .B(n101), .Y(Wr_D[0]) );
  NOR2X2M U29 ( .A(n16), .B(n100), .Y(Wr_D[1]) );
  NOR2X2M U30 ( .A(n16), .B(n99), .Y(Wr_D[2]) );
  NOR2X2M U31 ( .A(n16), .B(n98), .Y(Wr_D[3]) );
  OR3X2M U32 ( .A(n61), .B(n8), .C(n9), .Y(WR_INC) );
  BUFX2M U33 ( .A(n62), .Y(n9) );
  NOR2BX2M U34 ( .AN(n42), .B(n43), .Y(n62) );
  NOR3X2M U35 ( .A(n98), .B(n24), .C(n94), .Y(n36) );
  INVX2M U36 ( .A(n56), .Y(n18) );
  NAND4X2M U37 ( .A(n35), .B(n36), .C(n100), .D(n96), .Y(n33) );
  OAI22X1M U38 ( .A0(n101), .A1(n10), .B0(n23), .B1(n17), .Y(n86) );
  NAND3X2M U39 ( .A(n35), .B(n54), .C(n36), .Y(n57) );
  NAND3X2M U40 ( .A(n28), .B(n29), .C(n30), .Y(next_state[2]) );
  AOI211X2M U41 ( .A0(n31), .A1(n24), .B0(RdEn), .C0(n32), .Y(n30) );
  NOR4X1M U42 ( .A(n33), .B(n95), .C(n34), .D(n99), .Y(n32) );
  NAND3BX2M U43 ( .AN(n37), .B(n28), .C(n38), .Y(next_state[1]) );
  AOI2BB2XLM U44 ( .B0(n39), .B1(n40), .A0N(n41), .A1N(n24), .Y(n38) );
  INVX2M U45 ( .A(n25), .Y(n21) );
  AOI2BB1X2M U46 ( .A0N(n42), .A1N(n43), .B0(n44), .Y(n28) );
  INVX2M U47 ( .A(rst), .Y(n15) );
  NOR3BX2M U48 ( .AN(n77), .B(current_state[1]), .C(n22), .Y(n31) );
  NAND2X2M U49 ( .A(enable_pulse), .B(n31), .Y(n27) );
  NAND3X2M U50 ( .A(n79), .B(n17), .C(n80), .Y(n49) );
  NOR3X2M U51 ( .A(command[2]), .B(command[6]), .C(command[4]), .Y(n80) );
  NOR2X2M U52 ( .A(current_state[3]), .B(current_state[0]), .Y(n77) );
  AND4X2M U53 ( .A(n50), .B(n43), .C(n75), .D(n76), .Y(n73) );
  AOI21X2M U54 ( .A0(n39), .A1(n48), .B0(n24), .Y(n75) );
  NOR4X1M U55 ( .A(current_state[3]), .B(n20), .C(n31), .D(n44), .Y(n76) );
  INVX2M U56 ( .A(current_state[2]), .Y(n22) );
  AND4X2M U57 ( .A(command[1]), .B(enable_pulse), .C(command[3]), .D(n81), .Y(
        n79) );
  NOR2X2M U58 ( .A(n13), .B(n12), .Y(n81) );
  OAI22X4M U59 ( .A0(n100), .A1(n72), .B0(n73), .B1(n3), .Y(Addr[1]) );
  OAI22X4M U60 ( .A0(n98), .A1(n72), .B0(n73), .B1(n1), .Y(Addr[3]) );
  NOR2X2M U61 ( .A(n19), .B(current_state[3]), .Y(n60) );
  NOR2X2M U62 ( .A(current_state[2]), .B(current_state[1]), .Y(n71) );
  NAND3X2M U63 ( .A(n60), .B(n22), .C(current_state[1]), .Y(n50) );
  NAND3X2M U64 ( .A(current_state[2]), .B(n77), .C(current_state[1]), .Y(n43)
         );
  NAND3X2M U65 ( .A(n60), .B(current_state[2]), .C(current_state[1]), .Y(n51)
         );
  INVX2M U66 ( .A(enable_pulse), .Y(n24) );
  AND3X2M U67 ( .A(n77), .B(n22), .C(current_state[1]), .Y(n44) );
  NAND4X2M U68 ( .A(command[4]), .B(command[0]), .C(n78), .D(n79), .Y(n74) );
  NOR2X2M U69 ( .A(command[6]), .B(command[2]), .Y(n78) );
  INVX2M U70 ( .A(current_state[0]), .Y(n19) );
  INVX2M U71 ( .A(command[0]), .Y(n17) );
  INVX2M U72 ( .A(sync_bus[2]), .Y(n99) );
  INVX2M U73 ( .A(sync_bus[1]), .Y(n100) );
  NAND3BX2M U74 ( .AN(current_state[1]), .B(current_state[2]), .C(n60), .Y(n41) );
  INVX2M U75 ( .A(sync_bus[0]), .Y(n101) );
  INVX2M U76 ( .A(sync_bus[3]), .Y(n98) );
  NOR2X4M U77 ( .A(n25), .B(FIFO_FULL), .Y(n61) );
  NAND3X2M U78 ( .A(current_state[3]), .B(n71), .C(current_state[0]), .Y(n25)
         );
  NAND3X2M U79 ( .A(n71), .B(n19), .C(current_state[3]), .Y(n26) );
  NOR2BX2M U80 ( .AN(Rd_D_Vld), .B(FIFO_FULL), .Y(n42) );
  OAI2BB1X2M U82 ( .A0N(ALU_OUT[9]), .A1N(n8), .B0(n69), .Y(WR_DATA[1]) );
  BUFX2M U83 ( .A(n45), .Y(n8) );
  NOR3BX2M U84 ( .AN(out_valid), .B(n26), .C(FIFO_FULL), .Y(n45) );
  NAND2X2M U85 ( .A(n39), .B(enable_pulse), .Y(n56) );
  NOR3BX2M U86 ( .AN(n54), .B(sync_bus[4]), .C(sync_bus[0]), .Y(n53) );
  CLKXOR2X2M U87 ( .A(n97), .B(sync_bus[0]), .Y(n35) );
  OAI2B2X1M U88 ( .A1N(n49), .A0(n50), .B0(enable_pulse), .B1(n51), .Y(n37) );
  OAI2BB1X2M U89 ( .A0N(ALU_OUT[8]), .A1N(n8), .B0(n70), .Y(WR_DATA[0]) );
  AOI22X1M U90 ( .A0(Rd_D[0]), .A1(n9), .B0(ALU_OUT[0]), .B1(n61), .Y(n70) );
  OAI2BB1X2M U91 ( .A0N(ALU_OUT[10]), .A1N(n8), .B0(n68), .Y(WR_DATA[2]) );
  AOI22X1M U92 ( .A0(Rd_D[2]), .A1(n9), .B0(ALU_OUT[2]), .B1(n61), .Y(n68) );
  OAI2BB1X2M U93 ( .A0N(ALU_OUT[11]), .A1N(n8), .B0(n67), .Y(WR_DATA[3]) );
  AOI22X1M U94 ( .A0(Rd_D[3]), .A1(n9), .B0(ALU_OUT[3]), .B1(n61), .Y(n67) );
  OAI2BB1X2M U95 ( .A0N(ALU_OUT[12]), .A1N(n8), .B0(n66), .Y(WR_DATA[4]) );
  AOI22X1M U96 ( .A0(Rd_D[4]), .A1(n9), .B0(ALU_OUT[4]), .B1(n61), .Y(n66) );
  OAI2BB1X2M U97 ( .A0N(ALU_OUT[13]), .A1N(n8), .B0(n65), .Y(WR_DATA[5]) );
  AOI22X1M U98 ( .A0(Rd_D[5]), .A1(n9), .B0(ALU_OUT[5]), .B1(n61), .Y(n65) );
  OAI2BB1X2M U99 ( .A0N(ALU_OUT[14]), .A1N(n8), .B0(n64), .Y(WR_DATA[6]) );
  AOI22X1M U100 ( .A0(Rd_D[6]), .A1(n9), .B0(ALU_OUT[6]), .B1(n61), .Y(n64) );
  OAI2BB1X2M U101 ( .A0N(ALU_OUT[15]), .A1N(n8), .B0(n63), .Y(WR_DATA[7]) );
  AOI22X1M U102 ( .A0(Rd_D[7]), .A1(n9), .B0(ALU_OUT[7]), .B1(n61), .Y(n63) );
  OAI2B11X2M U103 ( .A1N(FIFO_FULL), .A0(n25), .B0(n26), .C0(n27), .Y(
        next_state[3]) );
  INVX2M U104 ( .A(sync_bus[6]), .Y(n95) );
  OAI22X1M U105 ( .A0(n96), .A1(n10), .B0(n23), .B1(n13), .Y(n91) );
  OAI22X1M U106 ( .A0(n101), .A1(n56), .B0(n18), .B1(n4), .Y(n85) );
  OAI22X1M U107 ( .A0(n100), .A1(n56), .B0(n18), .B1(n3), .Y(n84) );
  OAI22X1M U108 ( .A0(n99), .A1(n56), .B0(n18), .B1(n2), .Y(n83) );
  OAI22X1M U109 ( .A0(n98), .A1(n56), .B0(n18), .B1(n1), .Y(n82) );
  INVX2M U110 ( .A(sync_bus[4]), .Y(n97) );
  INVX2M U111 ( .A(sync_bus[5]), .Y(n96) );
  OAI2BB2X1M U112 ( .B0(n99), .B1(n10), .A0N(n10), .A1N(command[2]), .Y(n88)
         );
  OAI2BB2X1M U113 ( .B0(n100), .B1(n10), .A0N(n10), .A1N(command[1]), .Y(n87)
         );
  NAND2X2M U114 ( .A(n58), .B(n59), .Y(n54) );
  NAND4X2M U115 ( .A(sync_bus[6]), .B(sync_bus[2]), .C(n100), .D(n96), .Y(n59)
         );
  NAND4X2M U116 ( .A(sync_bus[5]), .B(sync_bus[1]), .C(n99), .D(n95), .Y(n58)
         );
  OAI2BB2X1M U117 ( .B0(n95), .B1(n10), .A0N(n10), .A1N(command[6]), .Y(n92)
         );
  NAND4BX1M U118 ( .AN(n8), .B(n41), .C(n46), .D(n47), .Y(next_state[0]) );
  OAI211X2M U119 ( .A0(n52), .A1(n53), .B0(n36), .C0(n20), .Y(n46) );
  AOI221XLM U120 ( .A0(n39), .A1(n48), .B0(FIFO_FULL), .B1(n21), .C0(n37), .Y(
        n47) );
  NOR4X1M U121 ( .A(n55), .B(n97), .C(sync_bus[6]), .D(sync_bus[2]), .Y(n52)
         );
  OAI2BB2X1M U122 ( .B0(n97), .B1(n10), .A0N(n10), .A1N(command[4]), .Y(n90)
         );
  INVX2M U123 ( .A(sync_bus[7]), .Y(n94) );
  NAND2X2M U124 ( .A(n10), .B(n12), .Y(n93) );
  OR2X2M U125 ( .A(command[3]), .B(n23), .Y(n89) );
  NAND3X2M U126 ( .A(sync_bus[1]), .B(sync_bus[0]), .C(sync_bus[5]), .Y(n55)
         );
  AOI22X1M U127 ( .A0(Rd_D[1]), .A1(n9), .B0(ALU_OUT[1]), .B1(n61), .Y(n69) );
  BUFX2M U128 ( .A(Gate_EN), .Y(en) );
  INVX2M U129 ( .A(n27), .Y(Gate_EN) );
endmodule


module regfile ( WrEn, RdEn, clk, rst, WrData, Address, RdData, Rd_Data_Valid, 
        REG0, REG1, REG2, REG3 );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input WrEn, RdEn, clk, rst;
  output Rd_Data_Valid;
  wire   N10, N11, N12, N13, n330, n331, n332, \Registers[15][7] ,
         \Registers[15][6] , \Registers[15][5] , \Registers[15][4] ,
         \Registers[15][3] , \Registers[15][2] , \Registers[15][1] ,
         \Registers[15][0] , \Registers[14][7] , \Registers[14][6] ,
         \Registers[14][5] , \Registers[14][4] , \Registers[14][3] ,
         \Registers[14][2] , \Registers[14][1] , \Registers[14][0] ,
         \Registers[13][7] , \Registers[13][6] , \Registers[13][5] ,
         \Registers[13][4] , \Registers[13][3] , \Registers[13][2] ,
         \Registers[13][1] , \Registers[13][0] , \Registers[12][7] ,
         \Registers[12][6] , \Registers[12][5] , \Registers[12][4] ,
         \Registers[12][3] , \Registers[12][2] , \Registers[12][1] ,
         \Registers[12][0] , \Registers[11][7] , \Registers[11][6] ,
         \Registers[11][5] , \Registers[11][4] , \Registers[11][3] ,
         \Registers[11][2] , \Registers[11][1] , \Registers[11][0] ,
         \Registers[10][7] , \Registers[10][6] , \Registers[10][5] ,
         \Registers[10][4] , \Registers[10][3] , \Registers[10][2] ,
         \Registers[10][1] , \Registers[10][0] , \Registers[9][7] ,
         \Registers[9][6] , \Registers[9][5] , \Registers[9][4] ,
         \Registers[9][3] , \Registers[9][2] , \Registers[9][1] ,
         \Registers[9][0] , \Registers[8][7] , \Registers[8][6] ,
         \Registers[8][5] , \Registers[8][4] , \Registers[8][3] ,
         \Registers[8][2] , \Registers[8][1] , \Registers[8][0] ,
         \Registers[7][7] , \Registers[7][6] , \Registers[7][5] ,
         \Registers[7][4] , \Registers[7][3] , \Registers[7][2] ,
         \Registers[7][1] , \Registers[7][0] , \Registers[6][7] ,
         \Registers[6][6] , \Registers[6][5] , \Registers[6][4] ,
         \Registers[6][3] , \Registers[6][2] , \Registers[6][1] ,
         \Registers[6][0] , \Registers[5][7] , \Registers[5][6] ,
         \Registers[5][5] , \Registers[5][4] , \Registers[5][3] ,
         \Registers[5][2] , \Registers[5][1] , \Registers[5][0] ,
         \Registers[4][7] , \Registers[4][6] , \Registers[4][5] ,
         \Registers[4][4] , \Registers[4][3] , \Registers[4][2] ,
         \Registers[4][1] , \Registers[4][0] , N35, N36, N37, N38, N39, N40,
         N41, N42, n12, n13, n14, n15, n16, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n2, n3, n5, n6, n7, n8, n9, n10, n11, n17,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329;
  assign N10 = Address[0];
  assign N11 = Address[1];
  assign N12 = Address[2];
  assign N13 = Address[3];

  DFFRHQX8M \Registers_reg[1][5]  ( .D(n62), .CK(clk), .RN(n308), .Q(REG1[5])
         );
  DFFRHQX8M \Registers_reg[1][0]  ( .D(n57), .CK(clk), .RN(n307), .Q(REG1[0])
         );
  DFFRHQX8M \Registers_reg[1][4]  ( .D(n61), .CK(clk), .RN(n307), .Q(REG1[4])
         );
  DFFRHQX4M \Registers_reg[0][7]  ( .D(n56), .CK(clk), .RN(n307), .Q(n330) );
  DFFRQX2M \RdData_reg[1]  ( .D(n41), .CK(clk), .RN(n306), .Q(RdData[1]) );
  DFFRQX2M \RdData_reg[7]  ( .D(n47), .CK(clk), .RN(n307), .Q(RdData[7]) );
  DFFRQX2M \RdData_reg[6]  ( .D(n46), .CK(clk), .RN(n306), .Q(RdData[6]) );
  DFFRQX2M \RdData_reg[5]  ( .D(n45), .CK(clk), .RN(n306), .Q(RdData[5]) );
  DFFRQX2M \RdData_reg[4]  ( .D(n44), .CK(clk), .RN(n306), .Q(RdData[4]) );
  DFFRQX2M \RdData_reg[3]  ( .D(n43), .CK(clk), .RN(n306), .Q(RdData[3]) );
  DFFRQX2M \RdData_reg[2]  ( .D(n42), .CK(clk), .RN(n306), .Q(RdData[2]) );
  DFFRQX2M \RdData_reg[0]  ( .D(n40), .CK(clk), .RN(n311), .Q(RdData[0]) );
  DFFRQX2M \Registers_reg[15][7]  ( .D(n176), .CK(clk), .RN(n306), .Q(
        \Registers[15][7] ) );
  DFFRQX2M \Registers_reg[15][6]  ( .D(n175), .CK(clk), .RN(n316), .Q(
        \Registers[15][6] ) );
  DFFRQX2M \Registers_reg[15][5]  ( .D(n174), .CK(clk), .RN(n316), .Q(
        \Registers[15][5] ) );
  DFFRQX2M \Registers_reg[15][4]  ( .D(n173), .CK(clk), .RN(n316), .Q(
        \Registers[15][4] ) );
  DFFRQX2M \Registers_reg[15][3]  ( .D(n172), .CK(clk), .RN(n316), .Q(
        \Registers[15][3] ) );
  DFFRQX2M \Registers_reg[15][2]  ( .D(n171), .CK(clk), .RN(n316), .Q(
        \Registers[15][2] ) );
  DFFRQX2M \Registers_reg[15][1]  ( .D(n170), .CK(clk), .RN(n316), .Q(
        \Registers[15][1] ) );
  DFFRQX2M \Registers_reg[15][0]  ( .D(n169), .CK(clk), .RN(n316), .Q(
        \Registers[15][0] ) );
  DFFRQX2M \Registers_reg[13][7]  ( .D(n160), .CK(clk), .RN(n315), .Q(
        \Registers[13][7] ) );
  DFFRQX2M \Registers_reg[13][6]  ( .D(n159), .CK(clk), .RN(n315), .Q(
        \Registers[13][6] ) );
  DFFRQX2M \Registers_reg[13][5]  ( .D(n158), .CK(clk), .RN(n315), .Q(
        \Registers[13][5] ) );
  DFFRQX2M \Registers_reg[13][4]  ( .D(n157), .CK(clk), .RN(n315), .Q(
        \Registers[13][4] ) );
  DFFRQX2M \Registers_reg[13][3]  ( .D(n156), .CK(clk), .RN(n315), .Q(
        \Registers[13][3] ) );
  DFFRQX2M \Registers_reg[13][2]  ( .D(n155), .CK(clk), .RN(n314), .Q(
        \Registers[13][2] ) );
  DFFRQX2M \Registers_reg[13][1]  ( .D(n154), .CK(clk), .RN(n314), .Q(
        \Registers[13][1] ) );
  DFFRQX2M \Registers_reg[13][0]  ( .D(n153), .CK(clk), .RN(n314), .Q(
        \Registers[13][0] ) );
  DFFRQX2M \Registers_reg[11][7]  ( .D(n144), .CK(clk), .RN(n314), .Q(
        \Registers[11][7] ) );
  DFFRQX2M \Registers_reg[11][6]  ( .D(n143), .CK(clk), .RN(n314), .Q(
        \Registers[11][6] ) );
  DFFRQX2M \Registers_reg[11][5]  ( .D(n142), .CK(clk), .RN(n313), .Q(
        \Registers[11][5] ) );
  DFFRQX2M \Registers_reg[11][4]  ( .D(n141), .CK(clk), .RN(n313), .Q(
        \Registers[11][4] ) );
  DFFRQX2M \Registers_reg[11][3]  ( .D(n140), .CK(clk), .RN(n313), .Q(
        \Registers[11][3] ) );
  DFFRQX2M \Registers_reg[11][2]  ( .D(n139), .CK(clk), .RN(n313), .Q(
        \Registers[11][2] ) );
  DFFRQX2M \Registers_reg[11][1]  ( .D(n138), .CK(clk), .RN(n313), .Q(
        \Registers[11][1] ) );
  DFFRQX2M \Registers_reg[11][0]  ( .D(n137), .CK(clk), .RN(n313), .Q(
        \Registers[11][0] ) );
  DFFRQX2M \Registers_reg[9][7]  ( .D(n128), .CK(clk), .RN(n312), .Q(
        \Registers[9][7] ) );
  DFFRQX2M \Registers_reg[9][6]  ( .D(n127), .CK(clk), .RN(n312), .Q(
        \Registers[9][6] ) );
  DFFRQX2M \Registers_reg[9][5]  ( .D(n126), .CK(clk), .RN(n312), .Q(
        \Registers[9][5] ) );
  DFFRQX2M \Registers_reg[9][4]  ( .D(n125), .CK(clk), .RN(n312), .Q(
        \Registers[9][4] ) );
  DFFRQX2M \Registers_reg[9][3]  ( .D(n124), .CK(clk), .RN(n312), .Q(
        \Registers[9][3] ) );
  DFFRQX2M \Registers_reg[9][2]  ( .D(n123), .CK(clk), .RN(n312), .Q(
        \Registers[9][2] ) );
  DFFRQX2M \Registers_reg[9][1]  ( .D(n122), .CK(clk), .RN(n312), .Q(
        \Registers[9][1] ) );
  DFFRQX2M \Registers_reg[9][0]  ( .D(n121), .CK(clk), .RN(n312), .Q(
        \Registers[9][0] ) );
  DFFRQX2M \Registers_reg[7][7]  ( .D(n112), .CK(clk), .RN(n311), .Q(
        \Registers[7][7] ) );
  DFFRQX2M \Registers_reg[7][6]  ( .D(n111), .CK(clk), .RN(n311), .Q(
        \Registers[7][6] ) );
  DFFRQX2M \Registers_reg[7][5]  ( .D(n110), .CK(clk), .RN(n311), .Q(
        \Registers[7][5] ) );
  DFFRQX2M \Registers_reg[7][4]  ( .D(n109), .CK(clk), .RN(n311), .Q(
        \Registers[7][4] ) );
  DFFRQX2M \Registers_reg[7][3]  ( .D(n108), .CK(clk), .RN(n311), .Q(
        \Registers[7][3] ) );
  DFFRQX2M \Registers_reg[7][2]  ( .D(n107), .CK(clk), .RN(n311), .Q(
        \Registers[7][2] ) );
  DFFRQX2M \Registers_reg[7][1]  ( .D(n106), .CK(clk), .RN(n311), .Q(
        \Registers[7][1] ) );
  DFFRQX2M \Registers_reg[7][0]  ( .D(n105), .CK(clk), .RN(n311), .Q(
        \Registers[7][0] ) );
  DFFRQX2M \Registers_reg[5][7]  ( .D(n96), .CK(clk), .RN(n310), .Q(
        \Registers[5][7] ) );
  DFFRQX2M \Registers_reg[5][6]  ( .D(n95), .CK(clk), .RN(n310), .Q(
        \Registers[5][6] ) );
  DFFRQX2M \Registers_reg[5][5]  ( .D(n94), .CK(clk), .RN(n310), .Q(
        \Registers[5][5] ) );
  DFFRQX2M \Registers_reg[5][4]  ( .D(n93), .CK(clk), .RN(n310), .Q(
        \Registers[5][4] ) );
  DFFRQX2M \Registers_reg[5][3]  ( .D(n92), .CK(clk), .RN(n310), .Q(
        \Registers[5][3] ) );
  DFFRQX2M \Registers_reg[5][2]  ( .D(n91), .CK(clk), .RN(n309), .Q(
        \Registers[5][2] ) );
  DFFRQX2M \Registers_reg[5][1]  ( .D(n90), .CK(clk), .RN(n309), .Q(
        \Registers[5][1] ) );
  DFFRQX2M \Registers_reg[5][0]  ( .D(n89), .CK(clk), .RN(n309), .Q(
        \Registers[5][0] ) );
  DFFRQX2M \Registers_reg[14][7]  ( .D(n168), .CK(clk), .RN(n315), .Q(
        \Registers[14][7] ) );
  DFFRQX2M \Registers_reg[14][6]  ( .D(n167), .CK(clk), .RN(n315), .Q(
        \Registers[14][6] ) );
  DFFRQX2M \Registers_reg[14][5]  ( .D(n166), .CK(clk), .RN(n315), .Q(
        \Registers[14][5] ) );
  DFFRQX2M \Registers_reg[14][4]  ( .D(n165), .CK(clk), .RN(n315), .Q(
        \Registers[14][4] ) );
  DFFRQX2M \Registers_reg[14][3]  ( .D(n164), .CK(clk), .RN(n315), .Q(
        \Registers[14][3] ) );
  DFFRQX2M \Registers_reg[14][2]  ( .D(n163), .CK(clk), .RN(n315), .Q(
        \Registers[14][2] ) );
  DFFRQX2M \Registers_reg[14][1]  ( .D(n162), .CK(clk), .RN(n315), .Q(
        \Registers[14][1] ) );
  DFFRQX2M \Registers_reg[14][0]  ( .D(n161), .CK(clk), .RN(n315), .Q(
        \Registers[14][0] ) );
  DFFRQX2M \Registers_reg[12][7]  ( .D(n152), .CK(clk), .RN(n314), .Q(
        \Registers[12][7] ) );
  DFFRQX2M \Registers_reg[12][6]  ( .D(n151), .CK(clk), .RN(n314), .Q(
        \Registers[12][6] ) );
  DFFRQX2M \Registers_reg[12][5]  ( .D(n150), .CK(clk), .RN(n314), .Q(
        \Registers[12][5] ) );
  DFFRQX2M \Registers_reg[12][4]  ( .D(n149), .CK(clk), .RN(n314), .Q(
        \Registers[12][4] ) );
  DFFRQX2M \Registers_reg[12][3]  ( .D(n148), .CK(clk), .RN(n314), .Q(
        \Registers[12][3] ) );
  DFFRQX2M \Registers_reg[12][2]  ( .D(n147), .CK(clk), .RN(n314), .Q(
        \Registers[12][2] ) );
  DFFRQX2M \Registers_reg[12][1]  ( .D(n146), .CK(clk), .RN(n314), .Q(
        \Registers[12][1] ) );
  DFFRQX2M \Registers_reg[12][0]  ( .D(n145), .CK(clk), .RN(n314), .Q(
        \Registers[12][0] ) );
  DFFRQX2M \Registers_reg[10][7]  ( .D(n136), .CK(clk), .RN(n313), .Q(
        \Registers[10][7] ) );
  DFFRQX2M \Registers_reg[10][6]  ( .D(n135), .CK(clk), .RN(n313), .Q(
        \Registers[10][6] ) );
  DFFRQX2M \Registers_reg[10][5]  ( .D(n134), .CK(clk), .RN(n313), .Q(
        \Registers[10][5] ) );
  DFFRQX2M \Registers_reg[10][4]  ( .D(n133), .CK(clk), .RN(n313), .Q(
        \Registers[10][4] ) );
  DFFRQX2M \Registers_reg[10][3]  ( .D(n132), .CK(clk), .RN(n313), .Q(
        \Registers[10][3] ) );
  DFFRQX2M \Registers_reg[10][2]  ( .D(n131), .CK(clk), .RN(n313), .Q(
        \Registers[10][2] ) );
  DFFRQX2M \Registers_reg[10][1]  ( .D(n130), .CK(clk), .RN(n313), .Q(
        \Registers[10][1] ) );
  DFFRQX2M \Registers_reg[10][0]  ( .D(n129), .CK(clk), .RN(n312), .Q(
        \Registers[10][0] ) );
  DFFRQX2M \Registers_reg[8][7]  ( .D(n120), .CK(clk), .RN(n312), .Q(
        \Registers[8][7] ) );
  DFFRQX2M \Registers_reg[8][6]  ( .D(n119), .CK(clk), .RN(n312), .Q(
        \Registers[8][6] ) );
  DFFRQX2M \Registers_reg[8][5]  ( .D(n118), .CK(clk), .RN(n312), .Q(
        \Registers[8][5] ) );
  DFFRQX2M \Registers_reg[8][4]  ( .D(n117), .CK(clk), .RN(n312), .Q(
        \Registers[8][4] ) );
  DFFRQX2M \Registers_reg[8][3]  ( .D(n116), .CK(clk), .RN(n311), .Q(
        \Registers[8][3] ) );
  DFFRQX2M \Registers_reg[8][2]  ( .D(n115), .CK(clk), .RN(n311), .Q(
        \Registers[8][2] ) );
  DFFRQX2M \Registers_reg[8][1]  ( .D(n114), .CK(clk), .RN(n311), .Q(
        \Registers[8][1] ) );
  DFFRQX2M \Registers_reg[8][0]  ( .D(n113), .CK(clk), .RN(n311), .Q(
        \Registers[8][0] ) );
  DFFRQX2M \Registers_reg[6][7]  ( .D(n104), .CK(clk), .RN(n310), .Q(
        \Registers[6][7] ) );
  DFFRQX2M \Registers_reg[6][6]  ( .D(n103), .CK(clk), .RN(n310), .Q(
        \Registers[6][6] ) );
  DFFRQX2M \Registers_reg[6][5]  ( .D(n102), .CK(clk), .RN(n310), .Q(
        \Registers[6][5] ) );
  DFFRQX2M \Registers_reg[6][4]  ( .D(n101), .CK(clk), .RN(n310), .Q(
        \Registers[6][4] ) );
  DFFRQX2M \Registers_reg[6][3]  ( .D(n100), .CK(clk), .RN(n310), .Q(
        \Registers[6][3] ) );
  DFFRQX2M \Registers_reg[6][2]  ( .D(n99), .CK(clk), .RN(n310), .Q(
        \Registers[6][2] ) );
  DFFRQX2M \Registers_reg[6][1]  ( .D(n98), .CK(clk), .RN(n310), .Q(
        \Registers[6][1] ) );
  DFFRQX2M \Registers_reg[6][0]  ( .D(n97), .CK(clk), .RN(n310), .Q(
        \Registers[6][0] ) );
  DFFRQX2M \Registers_reg[4][7]  ( .D(n88), .CK(clk), .RN(n309), .Q(
        \Registers[4][7] ) );
  DFFRQX2M \Registers_reg[4][6]  ( .D(n87), .CK(clk), .RN(n309), .Q(
        \Registers[4][6] ) );
  DFFRQX2M \Registers_reg[4][5]  ( .D(n86), .CK(clk), .RN(n309), .Q(
        \Registers[4][5] ) );
  DFFRQX2M \Registers_reg[4][4]  ( .D(n85), .CK(clk), .RN(n309), .Q(
        \Registers[4][4] ) );
  DFFRQX2M \Registers_reg[4][3]  ( .D(n84), .CK(clk), .RN(n309), .Q(
        \Registers[4][3] ) );
  DFFRQX2M \Registers_reg[4][2]  ( .D(n83), .CK(clk), .RN(n309), .Q(
        \Registers[4][2] ) );
  DFFRQX2M \Registers_reg[4][1]  ( .D(n82), .CK(clk), .RN(n309), .Q(
        \Registers[4][1] ) );
  DFFRQX2M \Registers_reg[4][0]  ( .D(n81), .CK(clk), .RN(n309), .Q(
        \Registers[4][0] ) );
  DFFSQX2M \Registers_reg[2][0]  ( .D(n65), .CK(clk), .SN(n306), .Q(REG2[0])
         );
  DFFSQX2M \Registers_reg[3][5]  ( .D(n78), .CK(clk), .SN(n306), .Q(REG3[5])
         );
  DFFRQX2M \Registers_reg[2][1]  ( .D(n66), .CK(clk), .RN(n308), .Q(REG2[1])
         );
  DFFRQX2M \Registers_reg[3][0]  ( .D(n73), .CK(clk), .RN(n308), .Q(REG3[0])
         );
  DFFRQX2M \Registers_reg[3][2]  ( .D(n75), .CK(clk), .RN(n308), .Q(REG3[2])
         );
  DFFRQX2M \Registers_reg[3][3]  ( .D(n76), .CK(clk), .RN(n308), .Q(REG3[3])
         );
  DFFRQX2M \Registers_reg[3][4]  ( .D(n77), .CK(clk), .RN(n308), .Q(REG3[4])
         );
  DFFRQX2M \Registers_reg[3][7]  ( .D(n80), .CK(clk), .RN(n309), .Q(REG3[7])
         );
  DFFRQX2M \Registers_reg[3][6]  ( .D(n79), .CK(clk), .RN(n309), .Q(REG3[6])
         );
  DFFRQX2M \Registers_reg[3][1]  ( .D(n74), .CK(clk), .RN(n308), .Q(REG3[1])
         );
  DFFRQX4M \Registers_reg[2][2]  ( .D(n67), .CK(clk), .RN(n308), .Q(REG2[2])
         );
  DFFRQX4M \Registers_reg[2][5]  ( .D(n70), .CK(clk), .RN(n308), .Q(REG2[5])
         );
  DFFRQX4M \Registers_reg[2][4]  ( .D(n69), .CK(clk), .RN(n308), .Q(REG2[4])
         );
  DFFRQX4M \Registers_reg[2][6]  ( .D(n71), .CK(clk), .RN(n308), .Q(REG2[6])
         );
  DFFRQX4M \Registers_reg[2][3]  ( .D(n68), .CK(clk), .RN(n308), .Q(REG2[3])
         );
  DFFRQX2M Rd_Data_Valid_reg ( .D(n48), .CK(clk), .RN(n306), .Q(Rd_Data_Valid)
         );
  DFFRQX2M \Registers_reg[0][3]  ( .D(n52), .CK(clk), .RN(n307), .Q(REG0[3])
         );
  DFFSQX2M \Registers_reg[2][7]  ( .D(n72), .CK(clk), .SN(n306), .Q(REG2[7])
         );
  DFFRQX2M \Registers_reg[0][2]  ( .D(n51), .CK(clk), .RN(n307), .Q(REG0[2])
         );
  DFFRQX2M \Registers_reg[0][1]  ( .D(n50), .CK(clk), .RN(n306), .Q(REG0[1])
         );
  DFFRHQX4M \Registers_reg[1][7]  ( .D(n64), .CK(clk), .RN(n307), .Q(n331) );
  DFFRHQX8M \Registers_reg[1][3]  ( .D(n60), .CK(clk), .RN(n307), .Q(REG1[3])
         );
  DFFRQX4M \Registers_reg[0][5]  ( .D(n54), .CK(clk), .RN(n307), .Q(REG0[5])
         );
  DFFRQX2M \Registers_reg[0][4]  ( .D(n53), .CK(clk), .RN(n307), .Q(REG0[4])
         );
  DFFRHQX4M \Registers_reg[0][6]  ( .D(n55), .CK(clk), .RN(n307), .Q(REG0[6])
         );
  DFFRQX4M \Registers_reg[0][0]  ( .D(n49), .CK(clk), .RN(n306), .Q(REG0[0])
         );
  DFFRHQX4M \Registers_reg[1][2]  ( .D(n59), .CK(clk), .RN(n307), .Q(n332) );
  DFFRHQX8M \Registers_reg[1][6]  ( .D(n63), .CK(clk), .RN(n308), .Q(REG1[6])
         );
  DFFRHQX8M \Registers_reg[1][1]  ( .D(n58), .CK(clk), .RN(n307), .Q(REG1[1])
         );
  CLKBUFX32M U3 ( .A(n331), .Y(REG1[7]) );
  BUFX18M U4 ( .A(n332), .Y(REG1[2]) );
  AOI22XLM U5 ( .A0(REG0[1]), .A1(n289), .B0(REG1[1]), .B1(n286), .Y(n186) );
  CLKINVX32M U6 ( .A(n290), .Y(REG0[7]) );
  INVX6M U7 ( .A(n330), .Y(n290) );
  AOI22XLM U8 ( .A0(REG0[2]), .A1(n289), .B0(REG1[2]), .B1(n286), .Y(n198) );
  AOI22XLM U9 ( .A0(REG0[0]), .A1(n289), .B0(REG1[0]), .B1(n286), .Y(n10) );
  INVXLM U10 ( .A(REG1[7]), .Y(n2) );
  INVX2M U11 ( .A(n2), .Y(n3) );
  NOR2BX2M U12 ( .AN(n38), .B(N10), .Y(n30) );
  NOR2BX2M U13 ( .AN(n27), .B(N10), .Y(n16) );
  NOR2BX2M U14 ( .AN(N12), .B(n276), .Y(n26) );
  NOR2X2M U15 ( .A(n276), .B(N12), .Y(n20) );
  NOR2X2M U16 ( .A(N11), .B(N12), .Y(n15) );
  NOR2BX2M U17 ( .AN(N12), .B(N11), .Y(n23) );
  OAI2BB2XLM U18 ( .B0(n14), .B1(n329), .A0N(REG0[0]), .A1N(n14), .Y(n49) );
  OAI2BB2XLM U19 ( .B0(n14), .B1(n328), .A0N(REG0[1]), .A1N(n14), .Y(n50) );
  OAI2BB2XLM U20 ( .B0(n14), .B1(n327), .A0N(REG0[2]), .A1N(n14), .Y(n51) );
  MX2XLM U21 ( .A(REG0[4]), .B(WrData[4]), .S0(n320), .Y(n53) );
  BUFX2M U22 ( .A(n263), .Y(n280) );
  BUFX2M U23 ( .A(n263), .Y(n279) );
  BUFX2M U24 ( .A(n263), .Y(n278) );
  INVX2M U25 ( .A(n14), .Y(n320) );
  BUFX2M U26 ( .A(n19), .Y(n305) );
  BUFX2M U27 ( .A(n22), .Y(n303) );
  BUFX2M U28 ( .A(n25), .Y(n301) );
  BUFX2M U29 ( .A(n29), .Y(n299) );
  BUFX2M U30 ( .A(n33), .Y(n297) );
  BUFX2M U31 ( .A(n34), .Y(n296) );
  BUFX2M U32 ( .A(n31), .Y(n298) );
  BUFX2M U33 ( .A(n36), .Y(n294) );
  BUFX2M U34 ( .A(n21), .Y(n304) );
  BUFX2M U35 ( .A(n24), .Y(n302) );
  BUFX2M U36 ( .A(n28), .Y(n300) );
  INVX2M U37 ( .A(n12), .Y(n321) );
  BUFX4M U38 ( .A(n317), .Y(n309) );
  BUFX4M U39 ( .A(n319), .Y(n310) );
  BUFX4M U40 ( .A(n317), .Y(n311) );
  BUFX4M U41 ( .A(n317), .Y(n312) );
  BUFX4M U42 ( .A(n319), .Y(n313) );
  BUFX4M U43 ( .A(n318), .Y(n314) );
  BUFX4M U44 ( .A(n318), .Y(n315) );
  BUFX4M U45 ( .A(n319), .Y(n308) );
  BUFX4M U46 ( .A(n317), .Y(n307) );
  BUFX2M U47 ( .A(n319), .Y(n316) );
  BUFX2M U48 ( .A(n265), .Y(n286) );
  BUFX2M U49 ( .A(n265), .Y(n285) );
  BUFX2M U50 ( .A(n265), .Y(n284) );
  AND2X2M U51 ( .A(n18), .B(n15), .Y(n5) );
  NOR2BX2M U52 ( .AN(n27), .B(n277), .Y(n18) );
  BUFX2M U53 ( .A(n266), .Y(n289) );
  BUFX2M U54 ( .A(n264), .Y(n283) );
  BUFX2M U55 ( .A(n266), .Y(n288) );
  BUFX2M U56 ( .A(n264), .Y(n282) );
  BUFX2M U57 ( .A(n264), .Y(n281) );
  BUFX2M U58 ( .A(n266), .Y(n287) );
  NOR2BX2M U59 ( .AN(n38), .B(n277), .Y(n32) );
  NAND2X2M U60 ( .A(n16), .B(n15), .Y(n14) );
  NOR2BX2M U61 ( .AN(WrEn), .B(RdEn), .Y(n13) );
  BUFX4M U62 ( .A(n35), .Y(n295) );
  NAND2X2M U63 ( .A(n30), .B(n23), .Y(n35) );
  BUFX4M U64 ( .A(n37), .Y(n293) );
  NAND2X2M U65 ( .A(n30), .B(n26), .Y(n37) );
  BUFX4M U66 ( .A(n39), .Y(n292) );
  NAND2X2M U67 ( .A(n32), .B(n26), .Y(n39) );
  NAND2X2M U68 ( .A(n30), .B(n15), .Y(n29) );
  NAND2X2M U69 ( .A(n30), .B(n20), .Y(n33) );
  NAND2X2M U70 ( .A(n23), .B(n16), .Y(n22) );
  NAND2X2M U71 ( .A(n23), .B(n18), .Y(n24) );
  NAND2X2M U72 ( .A(n26), .B(n16), .Y(n25) );
  NAND2X2M U73 ( .A(n26), .B(n18), .Y(n28) );
  NAND2X2M U74 ( .A(n32), .B(n15), .Y(n31) );
  NAND2X2M U75 ( .A(n32), .B(n20), .Y(n34) );
  NAND2X2M U76 ( .A(n32), .B(n23), .Y(n36) );
  NAND2X2M U77 ( .A(n20), .B(n16), .Y(n19) );
  NAND2X2M U78 ( .A(n20), .B(n18), .Y(n21) );
  MX2X2M U79 ( .A(REG0[7]), .B(WrData[7]), .S0(n320), .Y(n56) );
  INVX4M U80 ( .A(WrData[0]), .Y(n329) );
  INVX4M U81 ( .A(WrData[1]), .Y(n328) );
  INVX4M U82 ( .A(WrData[2]), .Y(n327) );
  INVX4M U83 ( .A(WrData[3]), .Y(n326) );
  NAND2BX2M U84 ( .AN(WrEn), .B(RdEn), .Y(n12) );
  INVX4M U85 ( .A(WrData[4]), .Y(n325) );
  INVX4M U86 ( .A(WrData[5]), .Y(n324) );
  INVX4M U87 ( .A(WrData[6]), .Y(n323) );
  INVX4M U88 ( .A(WrData[7]), .Y(n322) );
  BUFX4M U89 ( .A(n318), .Y(n306) );
  BUFX2M U90 ( .A(n317), .Y(n318) );
  BUFX2M U91 ( .A(n319), .Y(n317) );
  INVX2M U92 ( .A(N10), .Y(n277) );
  INVX2M U93 ( .A(N11), .Y(n276) );
  NOR2BX2M U94 ( .AN(n13), .B(N13), .Y(n27) );
  INVX2M U95 ( .A(N12), .Y(n275) );
  INVX2M U96 ( .A(N13), .Y(n274) );
  AND2X2M U97 ( .A(N13), .B(n13), .Y(n38) );
  BUFX2M U98 ( .A(rst), .Y(n319) );
  AO22X1M U99 ( .A0(N42), .A1(n321), .B0(RdData[0]), .B1(n12), .Y(n40) );
  AO22X1M U100 ( .A0(N41), .A1(n321), .B0(RdData[1]), .B1(n12), .Y(n41) );
  AO22X1M U101 ( .A0(N40), .A1(n321), .B0(RdData[2]), .B1(n12), .Y(n42) );
  AO22X1M U102 ( .A0(N39), .A1(n321), .B0(RdData[3]), .B1(n12), .Y(n43) );
  AO22X1M U103 ( .A0(N38), .A1(n321), .B0(RdData[4]), .B1(n12), .Y(n44) );
  AO22X1M U104 ( .A0(N37), .A1(n321), .B0(RdData[5]), .B1(n12), .Y(n45) );
  AO22X1M U105 ( .A0(N36), .A1(n321), .B0(RdData[6]), .B1(n12), .Y(n46) );
  AO22X1M U106 ( .A0(N35), .A1(n321), .B0(RdData[7]), .B1(n12), .Y(n47) );
  MX2XLM U107 ( .A(REG1[2]), .B(WrData[2]), .S0(n5), .Y(n59) );
  MX2XLM U108 ( .A(REG1[3]), .B(WrData[3]), .S0(n5), .Y(n60) );
  MX2XLM U109 ( .A(REG1[4]), .B(WrData[4]), .S0(n5), .Y(n61) );
  MX2XLM U110 ( .A(REG1[0]), .B(WrData[0]), .S0(n5), .Y(n57) );
  MX2XLM U111 ( .A(REG1[5]), .B(WrData[5]), .S0(n5), .Y(n62) );
  MX2XLM U112 ( .A(REG1[1]), .B(WrData[1]), .S0(n5), .Y(n58) );
  OAI2BB2X1M U113 ( .B0(n14), .B1(n326), .A0N(REG0[3]), .A1N(n14), .Y(n52) );
  OAI2BB2X1M U114 ( .B0(n328), .B1(n19), .A0N(REG2[1]), .A1N(n305), .Y(n66) );
  OAI2BB2X1M U115 ( .B0(n327), .B1(n19), .A0N(REG2[2]), .A1N(n305), .Y(n67) );
  OAI2BB2X1M U116 ( .B0(n326), .B1(n19), .A0N(REG2[3]), .A1N(n305), .Y(n68) );
  OAI2BB2X1M U117 ( .B0(n325), .B1(n305), .A0N(REG2[4]), .A1N(n305), .Y(n69)
         );
  OAI2BB2X1M U118 ( .B0(n324), .B1(n305), .A0N(REG2[5]), .A1N(n305), .Y(n70)
         );
  OAI2BB2X1M U119 ( .B0(n323), .B1(n19), .A0N(REG2[6]), .A1N(n305), .Y(n71) );
  OAI2BB2X1M U120 ( .B0(n329), .B1(n304), .A0N(REG3[0]), .A1N(n304), .Y(n73)
         );
  OAI2BB2X1M U121 ( .B0(n328), .B1(n21), .A0N(REG3[1]), .A1N(n304), .Y(n74) );
  OAI2BB2X1M U122 ( .B0(n327), .B1(n21), .A0N(REG3[2]), .A1N(n304), .Y(n75) );
  OAI2BB2X1M U123 ( .B0(n326), .B1(n21), .A0N(REG3[3]), .A1N(n304), .Y(n76) );
  OAI2BB2X1M U124 ( .B0(n325), .B1(n304), .A0N(REG3[4]), .A1N(n304), .Y(n77)
         );
  OAI2BB2X1M U125 ( .B0(n323), .B1(n21), .A0N(REG3[6]), .A1N(n304), .Y(n79) );
  OAI2BB2X1M U126 ( .B0(n322), .B1(n304), .A0N(REG3[7]), .A1N(n304), .Y(n80)
         );
  OAI2BB2X1M U127 ( .B0(n329), .B1(n303), .A0N(\Registers[4][0] ), .A1N(n303), 
        .Y(n81) );
  OAI2BB2X1M U128 ( .B0(n328), .B1(n22), .A0N(\Registers[4][1] ), .A1N(n303), 
        .Y(n82) );
  OAI2BB2X1M U129 ( .B0(n327), .B1(n22), .A0N(\Registers[4][2] ), .A1N(n303), 
        .Y(n83) );
  OAI2BB2X1M U130 ( .B0(n326), .B1(n22), .A0N(\Registers[4][3] ), .A1N(n303), 
        .Y(n84) );
  OAI2BB2X1M U131 ( .B0(n325), .B1(n303), .A0N(\Registers[4][4] ), .A1N(n303), 
        .Y(n85) );
  OAI2BB2X1M U132 ( .B0(n324), .B1(n22), .A0N(\Registers[4][5] ), .A1N(n303), 
        .Y(n86) );
  OAI2BB2X1M U133 ( .B0(n323), .B1(n22), .A0N(\Registers[4][6] ), .A1N(n303), 
        .Y(n87) );
  OAI2BB2X1M U134 ( .B0(n322), .B1(n303), .A0N(\Registers[4][7] ), .A1N(n303), 
        .Y(n88) );
  OAI2BB2X1M U135 ( .B0(n329), .B1(n302), .A0N(\Registers[5][0] ), .A1N(n302), 
        .Y(n89) );
  OAI2BB2X1M U136 ( .B0(n328), .B1(n24), .A0N(\Registers[5][1] ), .A1N(n302), 
        .Y(n90) );
  OAI2BB2X1M U137 ( .B0(n327), .B1(n24), .A0N(\Registers[5][2] ), .A1N(n302), 
        .Y(n91) );
  OAI2BB2X1M U138 ( .B0(n326), .B1(n24), .A0N(\Registers[5][3] ), .A1N(n302), 
        .Y(n92) );
  OAI2BB2X1M U139 ( .B0(n325), .B1(n302), .A0N(\Registers[5][4] ), .A1N(n302), 
        .Y(n93) );
  OAI2BB2X1M U140 ( .B0(n324), .B1(n24), .A0N(\Registers[5][5] ), .A1N(n302), 
        .Y(n94) );
  OAI2BB2X1M U141 ( .B0(n323), .B1(n24), .A0N(\Registers[5][6] ), .A1N(n302), 
        .Y(n95) );
  OAI2BB2X1M U142 ( .B0(n322), .B1(n302), .A0N(\Registers[5][7] ), .A1N(n302), 
        .Y(n96) );
  OAI2BB2X1M U143 ( .B0(n329), .B1(n301), .A0N(\Registers[6][0] ), .A1N(n301), 
        .Y(n97) );
  OAI2BB2X1M U144 ( .B0(n328), .B1(n25), .A0N(\Registers[6][1] ), .A1N(n301), 
        .Y(n98) );
  OAI2BB2X1M U145 ( .B0(n327), .B1(n25), .A0N(\Registers[6][2] ), .A1N(n301), 
        .Y(n99) );
  OAI2BB2X1M U146 ( .B0(n326), .B1(n25), .A0N(\Registers[6][3] ), .A1N(n301), 
        .Y(n100) );
  OAI2BB2X1M U147 ( .B0(n325), .B1(n301), .A0N(\Registers[6][4] ), .A1N(n301), 
        .Y(n101) );
  OAI2BB2X1M U148 ( .B0(n324), .B1(n25), .A0N(\Registers[6][5] ), .A1N(n301), 
        .Y(n102) );
  OAI2BB2X1M U149 ( .B0(n323), .B1(n25), .A0N(\Registers[6][6] ), .A1N(n301), 
        .Y(n103) );
  OAI2BB2X1M U150 ( .B0(n322), .B1(n301), .A0N(\Registers[6][7] ), .A1N(n301), 
        .Y(n104) );
  OAI2BB2X1M U151 ( .B0(n329), .B1(n300), .A0N(\Registers[7][0] ), .A1N(n300), 
        .Y(n105) );
  OAI2BB2X1M U152 ( .B0(n328), .B1(n28), .A0N(\Registers[7][1] ), .A1N(n300), 
        .Y(n106) );
  OAI2BB2X1M U153 ( .B0(n327), .B1(n28), .A0N(\Registers[7][2] ), .A1N(n300), 
        .Y(n107) );
  OAI2BB2X1M U154 ( .B0(n326), .B1(n28), .A0N(\Registers[7][3] ), .A1N(n300), 
        .Y(n108) );
  OAI2BB2X1M U155 ( .B0(n325), .B1(n300), .A0N(\Registers[7][4] ), .A1N(n300), 
        .Y(n109) );
  OAI2BB2X1M U156 ( .B0(n324), .B1(n28), .A0N(\Registers[7][5] ), .A1N(n300), 
        .Y(n110) );
  OAI2BB2X1M U157 ( .B0(n323), .B1(n28), .A0N(\Registers[7][6] ), .A1N(n300), 
        .Y(n111) );
  OAI2BB2X1M U158 ( .B0(n322), .B1(n300), .A0N(\Registers[7][7] ), .A1N(n300), 
        .Y(n112) );
  OAI2BB2X1M U159 ( .B0(n329), .B1(n299), .A0N(\Registers[8][0] ), .A1N(n299), 
        .Y(n113) );
  OAI2BB2X1M U160 ( .B0(n328), .B1(n29), .A0N(\Registers[8][1] ), .A1N(n299), 
        .Y(n114) );
  OAI2BB2X1M U161 ( .B0(n327), .B1(n29), .A0N(\Registers[8][2] ), .A1N(n299), 
        .Y(n115) );
  OAI2BB2X1M U162 ( .B0(n326), .B1(n29), .A0N(\Registers[8][3] ), .A1N(n299), 
        .Y(n116) );
  OAI2BB2X1M U163 ( .B0(n325), .B1(n299), .A0N(\Registers[8][4] ), .A1N(n299), 
        .Y(n117) );
  OAI2BB2X1M U164 ( .B0(n324), .B1(n299), .A0N(\Registers[8][5] ), .A1N(n299), 
        .Y(n118) );
  OAI2BB2X1M U165 ( .B0(n323), .B1(n29), .A0N(\Registers[8][6] ), .A1N(n299), 
        .Y(n119) );
  OAI2BB2X1M U166 ( .B0(n322), .B1(n299), .A0N(\Registers[8][7] ), .A1N(n299), 
        .Y(n120) );
  OAI2BB2X1M U167 ( .B0(n329), .B1(n298), .A0N(\Registers[9][0] ), .A1N(n298), 
        .Y(n121) );
  OAI2BB2X1M U168 ( .B0(n328), .B1(n31), .A0N(\Registers[9][1] ), .A1N(n298), 
        .Y(n122) );
  OAI2BB2X1M U169 ( .B0(n327), .B1(n31), .A0N(\Registers[9][2] ), .A1N(n298), 
        .Y(n123) );
  OAI2BB2X1M U170 ( .B0(n326), .B1(n31), .A0N(\Registers[9][3] ), .A1N(n298), 
        .Y(n124) );
  OAI2BB2X1M U171 ( .B0(n325), .B1(n298), .A0N(\Registers[9][4] ), .A1N(n298), 
        .Y(n125) );
  OAI2BB2X1M U172 ( .B0(n324), .B1(n298), .A0N(\Registers[9][5] ), .A1N(n298), 
        .Y(n126) );
  OAI2BB2X1M U173 ( .B0(n323), .B1(n31), .A0N(\Registers[9][6] ), .A1N(n298), 
        .Y(n127) );
  OAI2BB2X1M U174 ( .B0(n322), .B1(n298), .A0N(\Registers[9][7] ), .A1N(n298), 
        .Y(n128) );
  OAI2BB2X1M U175 ( .B0(n329), .B1(n297), .A0N(\Registers[10][0] ), .A1N(n297), 
        .Y(n129) );
  OAI2BB2X1M U176 ( .B0(n328), .B1(n33), .A0N(\Registers[10][1] ), .A1N(n297), 
        .Y(n130) );
  OAI2BB2X1M U177 ( .B0(n327), .B1(n33), .A0N(\Registers[10][2] ), .A1N(n297), 
        .Y(n131) );
  OAI2BB2X1M U178 ( .B0(n326), .B1(n33), .A0N(\Registers[10][3] ), .A1N(n297), 
        .Y(n132) );
  OAI2BB2X1M U179 ( .B0(n325), .B1(n297), .A0N(\Registers[10][4] ), .A1N(n297), 
        .Y(n133) );
  OAI2BB2X1M U180 ( .B0(n324), .B1(n297), .A0N(\Registers[10][5] ), .A1N(n297), 
        .Y(n134) );
  OAI2BB2X1M U181 ( .B0(n323), .B1(n33), .A0N(\Registers[10][6] ), .A1N(n297), 
        .Y(n135) );
  OAI2BB2X1M U182 ( .B0(n322), .B1(n297), .A0N(\Registers[10][7] ), .A1N(n297), 
        .Y(n136) );
  OAI2BB2X1M U183 ( .B0(n329), .B1(n296), .A0N(\Registers[11][0] ), .A1N(n296), 
        .Y(n137) );
  OAI2BB2X1M U184 ( .B0(n328), .B1(n34), .A0N(\Registers[11][1] ), .A1N(n296), 
        .Y(n138) );
  OAI2BB2X1M U185 ( .B0(n327), .B1(n34), .A0N(\Registers[11][2] ), .A1N(n296), 
        .Y(n139) );
  OAI2BB2X1M U186 ( .B0(n326), .B1(n34), .A0N(\Registers[11][3] ), .A1N(n296), 
        .Y(n140) );
  OAI2BB2X1M U187 ( .B0(n325), .B1(n296), .A0N(\Registers[11][4] ), .A1N(n296), 
        .Y(n141) );
  OAI2BB2X1M U188 ( .B0(n324), .B1(n296), .A0N(\Registers[11][5] ), .A1N(n296), 
        .Y(n142) );
  OAI2BB2X1M U189 ( .B0(n323), .B1(n34), .A0N(\Registers[11][6] ), .A1N(n296), 
        .Y(n143) );
  OAI2BB2X1M U190 ( .B0(n322), .B1(n296), .A0N(\Registers[11][7] ), .A1N(n296), 
        .Y(n144) );
  OAI2BB2X1M U191 ( .B0(n329), .B1(n294), .A0N(\Registers[13][0] ), .A1N(n294), 
        .Y(n153) );
  OAI2BB2X1M U192 ( .B0(n328), .B1(n36), .A0N(\Registers[13][1] ), .A1N(n294), 
        .Y(n154) );
  OAI2BB2X1M U193 ( .B0(n327), .B1(n36), .A0N(\Registers[13][2] ), .A1N(n294), 
        .Y(n155) );
  OAI2BB2X1M U194 ( .B0(n326), .B1(n36), .A0N(\Registers[13][3] ), .A1N(n294), 
        .Y(n156) );
  OAI2BB2X1M U195 ( .B0(n325), .B1(n294), .A0N(\Registers[13][4] ), .A1N(n294), 
        .Y(n157) );
  OAI2BB2X1M U196 ( .B0(n324), .B1(n294), .A0N(\Registers[13][5] ), .A1N(n294), 
        .Y(n158) );
  OAI2BB2X1M U197 ( .B0(n323), .B1(n36), .A0N(\Registers[13][6] ), .A1N(n294), 
        .Y(n159) );
  OAI2BB2X1M U198 ( .B0(n322), .B1(n294), .A0N(\Registers[13][7] ), .A1N(n294), 
        .Y(n160) );
  OAI2BB2X1M U199 ( .B0(n329), .B1(n295), .A0N(\Registers[12][0] ), .A1N(n295), 
        .Y(n145) );
  OAI2BB2X1M U200 ( .B0(n328), .B1(n295), .A0N(\Registers[12][1] ), .A1N(n295), 
        .Y(n146) );
  OAI2BB2X1M U201 ( .B0(n327), .B1(n295), .A0N(\Registers[12][2] ), .A1N(n295), 
        .Y(n147) );
  OAI2BB2X1M U202 ( .B0(n326), .B1(n295), .A0N(\Registers[12][3] ), .A1N(n295), 
        .Y(n148) );
  OAI2BB2X1M U203 ( .B0(n325), .B1(n295), .A0N(\Registers[12][4] ), .A1N(n295), 
        .Y(n149) );
  OAI2BB2X1M U204 ( .B0(n324), .B1(n295), .A0N(\Registers[12][5] ), .A1N(n295), 
        .Y(n150) );
  OAI2BB2X1M U205 ( .B0(n323), .B1(n295), .A0N(\Registers[12][6] ), .A1N(n295), 
        .Y(n151) );
  OAI2BB2X1M U206 ( .B0(n322), .B1(n295), .A0N(\Registers[12][7] ), .A1N(n295), 
        .Y(n152) );
  OAI2BB2X1M U207 ( .B0(n329), .B1(n293), .A0N(\Registers[14][0] ), .A1N(n293), 
        .Y(n161) );
  OAI2BB2X1M U208 ( .B0(n328), .B1(n293), .A0N(\Registers[14][1] ), .A1N(n293), 
        .Y(n162) );
  OAI2BB2X1M U209 ( .B0(n327), .B1(n293), .A0N(\Registers[14][2] ), .A1N(n293), 
        .Y(n163) );
  OAI2BB2X1M U210 ( .B0(n326), .B1(n293), .A0N(\Registers[14][3] ), .A1N(n293), 
        .Y(n164) );
  OAI2BB2X1M U211 ( .B0(n325), .B1(n293), .A0N(\Registers[14][4] ), .A1N(n293), 
        .Y(n165) );
  OAI2BB2X1M U212 ( .B0(n324), .B1(n293), .A0N(\Registers[14][5] ), .A1N(n293), 
        .Y(n166) );
  OAI2BB2X1M U213 ( .B0(n323), .B1(n293), .A0N(\Registers[14][6] ), .A1N(n293), 
        .Y(n167) );
  OAI2BB2X1M U214 ( .B0(n322), .B1(n293), .A0N(\Registers[14][7] ), .A1N(n293), 
        .Y(n168) );
  OAI2BB2X1M U215 ( .B0(n329), .B1(n292), .A0N(\Registers[15][0] ), .A1N(n292), 
        .Y(n169) );
  OAI2BB2X1M U216 ( .B0(n328), .B1(n292), .A0N(\Registers[15][1] ), .A1N(n292), 
        .Y(n170) );
  OAI2BB2X1M U217 ( .B0(n327), .B1(n292), .A0N(\Registers[15][2] ), .A1N(n292), 
        .Y(n171) );
  OAI2BB2X1M U218 ( .B0(n326), .B1(n292), .A0N(\Registers[15][3] ), .A1N(n292), 
        .Y(n172) );
  OAI2BB2X1M U219 ( .B0(n325), .B1(n292), .A0N(\Registers[15][4] ), .A1N(n292), 
        .Y(n173) );
  OAI2BB2X1M U220 ( .B0(n324), .B1(n292), .A0N(\Registers[15][5] ), .A1N(n292), 
        .Y(n174) );
  OAI2BB2X1M U221 ( .B0(n323), .B1(n292), .A0N(\Registers[15][6] ), .A1N(n292), 
        .Y(n175) );
  OAI2BB2X1M U222 ( .B0(n322), .B1(n292), .A0N(\Registers[15][7] ), .A1N(n292), 
        .Y(n176) );
  OAI2BB2X1M U223 ( .B0(n329), .B1(n305), .A0N(REG2[0]), .A1N(n305), .Y(n65)
         );
  OAI2BB2X1M U224 ( .B0(n322), .B1(n19), .A0N(REG2[7]), .A1N(n305), .Y(n72) );
  OAI2BB2X1M U225 ( .B0(n324), .B1(n21), .A0N(REG3[5]), .A1N(n304), .Y(n78) );
  MX2XLM U226 ( .A(REG0[5]), .B(WrData[5]), .S0(n320), .Y(n54) );
  MX2XLM U227 ( .A(REG0[6]), .B(WrData[6]), .S0(n320), .Y(n55) );
  OAI2BB1X2M U228 ( .A0N(Rd_Data_Valid), .A1N(n13), .B0(n12), .Y(n48) );
  NOR2X1M U229 ( .A(n276), .B(N10), .Y(n264) );
  NOR2X1M U230 ( .A(n276), .B(n277), .Y(n263) );
  AOI22X1M U231 ( .A0(\Registers[10][0] ), .A1(n283), .B0(\Registers[11][0] ), 
        .B1(n280), .Y(n7) );
  NOR2X1M U232 ( .A(N10), .B(N11), .Y(n266) );
  NOR2X1M U233 ( .A(n277), .B(N11), .Y(n265) );
  AOI22X1M U234 ( .A0(\Registers[8][0] ), .A1(n289), .B0(\Registers[9][0] ), 
        .B1(n286), .Y(n6) );
  CLKNAND2X2M U235 ( .A(N13), .B(n275), .Y(n254) );
  AOI21X1M U236 ( .A0(n7), .A1(n6), .B0(n254), .Y(n181) );
  AOI22X1M U237 ( .A0(\Registers[14][0] ), .A1(n283), .B0(\Registers[15][0] ), 
        .B1(n280), .Y(n9) );
  AOI22X1M U238 ( .A0(\Registers[12][0] ), .A1(n289), .B0(\Registers[13][0] ), 
        .B1(n286), .Y(n8) );
  CLKNAND2X2M U239 ( .A(N13), .B(N12), .Y(n257) );
  AOI21X1M U240 ( .A0(n9), .A1(n8), .B0(n257), .Y(n180) );
  AOI22X1M U241 ( .A0(REG2[0]), .A1(n283), .B0(REG3[0]), .B1(n280), .Y(n11) );
  CLKNAND2X2M U242 ( .A(n275), .B(n274), .Y(n260) );
  AOI21X1M U243 ( .A0(n11), .A1(n10), .B0(n260), .Y(n179) );
  AOI22X1M U244 ( .A0(\Registers[6][0] ), .A1(n283), .B0(\Registers[7][0] ), 
        .B1(n280), .Y(n177) );
  AOI22X1M U245 ( .A0(\Registers[4][0] ), .A1(n289), .B0(\Registers[5][0] ), 
        .B1(n286), .Y(n17) );
  CLKNAND2X2M U246 ( .A(N12), .B(n274), .Y(n267) );
  AOI21X1M U247 ( .A0(n177), .A1(n17), .B0(n267), .Y(n178) );
  OR4X1M U248 ( .A(n181), .B(n180), .C(n179), .D(n178), .Y(N42) );
  AOI22X1M U249 ( .A0(\Registers[10][1] ), .A1(n283), .B0(\Registers[11][1] ), 
        .B1(n280), .Y(n183) );
  AOI22X1M U250 ( .A0(\Registers[8][1] ), .A1(n289), .B0(\Registers[9][1] ), 
        .B1(n286), .Y(n182) );
  AOI21X1M U251 ( .A0(n183), .A1(n182), .B0(n254), .Y(n193) );
  AOI22X1M U252 ( .A0(\Registers[14][1] ), .A1(n283), .B0(\Registers[15][1] ), 
        .B1(n280), .Y(n185) );
  AOI22X1M U253 ( .A0(\Registers[12][1] ), .A1(n289), .B0(\Registers[13][1] ), 
        .B1(n286), .Y(n184) );
  AOI21X1M U254 ( .A0(n185), .A1(n184), .B0(n257), .Y(n192) );
  AOI22X1M U255 ( .A0(REG2[1]), .A1(n283), .B0(REG3[1]), .B1(n280), .Y(n187)
         );
  AOI21X1M U256 ( .A0(n187), .A1(n186), .B0(n260), .Y(n191) );
  AOI22X1M U257 ( .A0(\Registers[6][1] ), .A1(n283), .B0(\Registers[7][1] ), 
        .B1(n280), .Y(n189) );
  AOI22X1M U258 ( .A0(\Registers[4][1] ), .A1(n289), .B0(\Registers[5][1] ), 
        .B1(n286), .Y(n188) );
  AOI21X1M U259 ( .A0(n189), .A1(n188), .B0(n267), .Y(n190) );
  OR4X1M U260 ( .A(n193), .B(n192), .C(n191), .D(n190), .Y(N41) );
  AOI22X1M U261 ( .A0(\Registers[10][2] ), .A1(n283), .B0(\Registers[11][2] ), 
        .B1(n280), .Y(n195) );
  AOI22X1M U262 ( .A0(\Registers[8][2] ), .A1(n289), .B0(\Registers[9][2] ), 
        .B1(n286), .Y(n194) );
  AOI21X1M U263 ( .A0(n195), .A1(n194), .B0(n254), .Y(n205) );
  AOI22X1M U264 ( .A0(\Registers[14][2] ), .A1(n283), .B0(\Registers[15][2] ), 
        .B1(n280), .Y(n197) );
  AOI22X1M U265 ( .A0(\Registers[12][2] ), .A1(n289), .B0(\Registers[13][2] ), 
        .B1(n286), .Y(n196) );
  AOI21X1M U266 ( .A0(n197), .A1(n196), .B0(n257), .Y(n204) );
  AOI22X1M U267 ( .A0(REG2[2]), .A1(n283), .B0(REG3[2]), .B1(n280), .Y(n199)
         );
  AOI21X1M U268 ( .A0(n199), .A1(n198), .B0(n260), .Y(n203) );
  AOI22X1M U269 ( .A0(\Registers[6][2] ), .A1(n283), .B0(\Registers[7][2] ), 
        .B1(n280), .Y(n201) );
  AOI22X1M U270 ( .A0(\Registers[4][2] ), .A1(n289), .B0(\Registers[5][2] ), 
        .B1(n286), .Y(n200) );
  AOI21X1M U271 ( .A0(n201), .A1(n200), .B0(n267), .Y(n202) );
  OR4X1M U272 ( .A(n205), .B(n204), .C(n203), .D(n202), .Y(N40) );
  AOI22X1M U273 ( .A0(\Registers[10][3] ), .A1(n282), .B0(\Registers[11][3] ), 
        .B1(n279), .Y(n207) );
  AOI22X1M U274 ( .A0(\Registers[8][3] ), .A1(n288), .B0(\Registers[9][3] ), 
        .B1(n285), .Y(n206) );
  AOI21X1M U275 ( .A0(n207), .A1(n206), .B0(n254), .Y(n217) );
  AOI22X1M U276 ( .A0(\Registers[14][3] ), .A1(n282), .B0(\Registers[15][3] ), 
        .B1(n279), .Y(n209) );
  AOI22X1M U277 ( .A0(\Registers[12][3] ), .A1(n288), .B0(\Registers[13][3] ), 
        .B1(n285), .Y(n208) );
  AOI21X1M U278 ( .A0(n209), .A1(n208), .B0(n257), .Y(n216) );
  AOI22X1M U279 ( .A0(REG2[3]), .A1(n282), .B0(REG3[3]), .B1(n279), .Y(n211)
         );
  AOI22X1M U280 ( .A0(REG0[3]), .A1(n288), .B0(REG1[3]), .B1(n285), .Y(n210)
         );
  AOI21X1M U281 ( .A0(n211), .A1(n210), .B0(n260), .Y(n215) );
  AOI22X1M U282 ( .A0(\Registers[6][3] ), .A1(n282), .B0(\Registers[7][3] ), 
        .B1(n279), .Y(n213) );
  AOI22X1M U283 ( .A0(\Registers[4][3] ), .A1(n288), .B0(\Registers[5][3] ), 
        .B1(n285), .Y(n212) );
  AOI21X1M U284 ( .A0(n213), .A1(n212), .B0(n267), .Y(n214) );
  OR4X1M U285 ( .A(n217), .B(n216), .C(n215), .D(n214), .Y(N39) );
  AOI22X1M U286 ( .A0(\Registers[10][4] ), .A1(n282), .B0(\Registers[11][4] ), 
        .B1(n279), .Y(n219) );
  AOI22X1M U287 ( .A0(\Registers[8][4] ), .A1(n288), .B0(\Registers[9][4] ), 
        .B1(n285), .Y(n218) );
  AOI21X1M U288 ( .A0(n219), .A1(n218), .B0(n254), .Y(n229) );
  AOI22X1M U289 ( .A0(\Registers[14][4] ), .A1(n282), .B0(\Registers[15][4] ), 
        .B1(n279), .Y(n221) );
  AOI22X1M U290 ( .A0(\Registers[12][4] ), .A1(n288), .B0(\Registers[13][4] ), 
        .B1(n285), .Y(n220) );
  AOI21X1M U291 ( .A0(n221), .A1(n220), .B0(n257), .Y(n228) );
  AOI22X1M U292 ( .A0(REG2[4]), .A1(n282), .B0(REG3[4]), .B1(n279), .Y(n223)
         );
  AOI22X1M U293 ( .A0(REG0[4]), .A1(n288), .B0(REG1[4]), .B1(n285), .Y(n222)
         );
  AOI21X1M U294 ( .A0(n223), .A1(n222), .B0(n260), .Y(n227) );
  AOI22X1M U295 ( .A0(\Registers[6][4] ), .A1(n282), .B0(\Registers[7][4] ), 
        .B1(n279), .Y(n225) );
  AOI22X1M U296 ( .A0(\Registers[4][4] ), .A1(n288), .B0(\Registers[5][4] ), 
        .B1(n285), .Y(n224) );
  AOI21X1M U297 ( .A0(n225), .A1(n224), .B0(n267), .Y(n226) );
  OR4X1M U298 ( .A(n229), .B(n228), .C(n227), .D(n226), .Y(N38) );
  AOI22X1M U299 ( .A0(\Registers[10][5] ), .A1(n282), .B0(\Registers[11][5] ), 
        .B1(n279), .Y(n231) );
  AOI22X1M U300 ( .A0(\Registers[8][5] ), .A1(n288), .B0(\Registers[9][5] ), 
        .B1(n285), .Y(n230) );
  AOI21X1M U301 ( .A0(n231), .A1(n230), .B0(n254), .Y(n241) );
  AOI22X1M U302 ( .A0(\Registers[14][5] ), .A1(n282), .B0(\Registers[15][5] ), 
        .B1(n279), .Y(n233) );
  AOI22X1M U303 ( .A0(\Registers[12][5] ), .A1(n288), .B0(\Registers[13][5] ), 
        .B1(n285), .Y(n232) );
  AOI21X1M U304 ( .A0(n233), .A1(n232), .B0(n257), .Y(n240) );
  AOI22X1M U305 ( .A0(REG2[5]), .A1(n282), .B0(REG3[5]), .B1(n279), .Y(n235)
         );
  AOI22X1M U306 ( .A0(REG0[5]), .A1(n288), .B0(REG1[5]), .B1(n285), .Y(n234)
         );
  AOI21X1M U307 ( .A0(n235), .A1(n234), .B0(n260), .Y(n239) );
  AOI22X1M U308 ( .A0(\Registers[6][5] ), .A1(n282), .B0(\Registers[7][5] ), 
        .B1(n279), .Y(n237) );
  AOI22X1M U309 ( .A0(\Registers[4][5] ), .A1(n288), .B0(\Registers[5][5] ), 
        .B1(n285), .Y(n236) );
  AOI21X1M U310 ( .A0(n237), .A1(n236), .B0(n267), .Y(n238) );
  OR4X1M U311 ( .A(n241), .B(n240), .C(n239), .D(n238), .Y(N37) );
  AOI22X1M U312 ( .A0(\Registers[10][6] ), .A1(n281), .B0(\Registers[11][6] ), 
        .B1(n278), .Y(n243) );
  AOI22X1M U313 ( .A0(\Registers[8][6] ), .A1(n287), .B0(\Registers[9][6] ), 
        .B1(n284), .Y(n242) );
  AOI21X1M U314 ( .A0(n243), .A1(n242), .B0(n254), .Y(n253) );
  AOI22X1M U315 ( .A0(\Registers[14][6] ), .A1(n281), .B0(\Registers[15][6] ), 
        .B1(n278), .Y(n245) );
  AOI22X1M U316 ( .A0(\Registers[12][6] ), .A1(n287), .B0(\Registers[13][6] ), 
        .B1(n284), .Y(n244) );
  AOI21X1M U317 ( .A0(n245), .A1(n244), .B0(n257), .Y(n252) );
  AOI22X1M U318 ( .A0(REG2[6]), .A1(n281), .B0(REG3[6]), .B1(n278), .Y(n247)
         );
  AOI21X1M U319 ( .A0(n247), .A1(n246), .B0(n260), .Y(n251) );
  AOI22X1M U320 ( .A0(\Registers[6][6] ), .A1(n281), .B0(\Registers[7][6] ), 
        .B1(n278), .Y(n249) );
  AOI22X1M U321 ( .A0(\Registers[4][6] ), .A1(n287), .B0(\Registers[5][6] ), 
        .B1(n284), .Y(n248) );
  AOI21X1M U322 ( .A0(n249), .A1(n248), .B0(n267), .Y(n250) );
  OR4X1M U323 ( .A(n253), .B(n252), .C(n251), .D(n250), .Y(N36) );
  AOI22X1M U324 ( .A0(\Registers[10][7] ), .A1(n281), .B0(\Registers[11][7] ), 
        .B1(n278), .Y(n256) );
  AOI22X1M U325 ( .A0(\Registers[8][7] ), .A1(n287), .B0(\Registers[9][7] ), 
        .B1(n284), .Y(n255) );
  AOI21X1M U326 ( .A0(n256), .A1(n255), .B0(n254), .Y(n273) );
  AOI22X1M U327 ( .A0(\Registers[14][7] ), .A1(n281), .B0(\Registers[15][7] ), 
        .B1(n278), .Y(n259) );
  AOI22X1M U328 ( .A0(\Registers[12][7] ), .A1(n287), .B0(\Registers[13][7] ), 
        .B1(n284), .Y(n258) );
  AOI21X1M U329 ( .A0(n259), .A1(n258), .B0(n257), .Y(n272) );
  AOI22X1M U330 ( .A0(REG2[7]), .A1(n281), .B0(REG3[7]), .B1(n278), .Y(n262)
         );
  AOI21X1M U331 ( .A0(n262), .A1(n261), .B0(n260), .Y(n271) );
  AOI22X1M U332 ( .A0(\Registers[6][7] ), .A1(n281), .B0(\Registers[7][7] ), 
        .B1(n278), .Y(n269) );
  AOI22X1M U333 ( .A0(\Registers[4][7] ), .A1(n287), .B0(\Registers[5][7] ), 
        .B1(n284), .Y(n268) );
  AOI21X1M U334 ( .A0(n269), .A1(n268), .B0(n267), .Y(n270) );
  OR4X1M U335 ( .A(n273), .B(n272), .C(n271), .D(n270), .Y(N35) );
  AOI22XLM U336 ( .A0(REG0[7]), .A1(n287), .B0(n3), .B1(n284), .Y(n261) );
  AOI22XLM U337 ( .A0(REG0[6]), .A1(n287), .B0(REG1[6]), .B1(n284), .Y(n246)
         );
  MX2XLM U338 ( .A(REG1[6]), .B(WrData[6]), .S0(n5), .Y(n63) );
  MX2XLM U339 ( .A(n3), .B(WrData[7]), .S0(n5), .Y(n64) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFX2M U2_5 ( .A(A[5]), .B(n4), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n6), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n8), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  NAND2XLM U1 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  XNOR2XLM U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVXLM U3 ( .A(A[0]), .Y(n1) );
  INVXLM U4 ( .A(B[0]), .Y(n9) );
  INVXLM U5 ( .A(B[1]), .Y(n8) );
  INVXLM U6 ( .A(B[2]), .Y(n7) );
  INVXLM U7 ( .A(B[3]), .Y(n6) );
  INVXLM U8 ( .A(B[4]), .Y(n5) );
  INVXLM U9 ( .A(B[5]), .Y(n4) );
  INVXLM U10 ( .A(B[6]), .Y(n3) );
  INVXLM U11 ( .A(B[7]), .Y(n2) );
  CLKINVX1M U12 ( .A(carry[8]), .Y(DIFF[8]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2XLM U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28;

  OAI21X2M U2 ( .A0(n21), .A1(n22), .B0(n2), .Y(n1) );
  NOR2X2M U3 ( .A(B[8]), .B(A[8]), .Y(n16) );
  INVX2M U4 ( .A(n23), .Y(n2) );
  OA21X2M U5 ( .A0(n25), .A1(n26), .B0(n27), .Y(n22) );
  OA21X2M U6 ( .A0(n15), .A1(n16), .B0(n17), .Y(n10) );
  AOI2BB1X2M U7 ( .A0N(n10), .A1N(n13), .B0(n12), .Y(n26) );
  NAND2X2M U8 ( .A(A[7]), .B(B[7]), .Y(n15) );
  OAI21BX1M U9 ( .A0(n21), .A1(n22), .B0N(n23), .Y(n19) );
  OAI2BB1X2M U10 ( .A0N(n1), .A1N(A[12]), .B0(n20), .Y(n18) );
  NOR2XLM U11 ( .A(n12), .B(n13), .Y(n11) );
  XOR2XLM U12 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  OAI21X2M U13 ( .A0(A[12]), .A1(n19), .B0(B[12]), .Y(n20) );
  CLKXOR2X2M U14 ( .A(B[13]), .B(n18), .Y(SUM[13]) );
  INVX2M U15 ( .A(n9), .Y(SUM[6]) );
  INVX2M U16 ( .A(A[6]), .Y(n9) );
  BUFX2M U17 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U18 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U19 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U20 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U21 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U22 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U23 ( .A(n10), .B(n11), .Y(SUM[9]) );
  CLKXOR2X2M U24 ( .A(n14), .B(n15), .Y(SUM[8]) );
  NAND2BX1M U25 ( .AN(n16), .B(n17), .Y(n14) );
  XOR3XLM U26 ( .A(B[12]), .B(A[12]), .C(n1), .Y(SUM[12]) );
  XNOR2X1M U27 ( .A(n22), .B(n24), .Y(SUM[11]) );
  NOR2X1M U28 ( .A(n23), .B(n21), .Y(n24) );
  NOR2X1M U29 ( .A(B[11]), .B(A[11]), .Y(n21) );
  AND2X1M U30 ( .A(B[11]), .B(A[11]), .Y(n23) );
  CLKXOR2X2M U31 ( .A(n28), .B(n26), .Y(SUM[10]) );
  AND2X1M U32 ( .A(B[9]), .B(A[9]), .Y(n12) );
  NOR2X1M U33 ( .A(B[9]), .B(A[9]), .Y(n13) );
  CLKNAND2X2M U34 ( .A(B[8]), .B(A[8]), .Y(n17) );
  NAND2BX1M U35 ( .AN(n25), .B(n27), .Y(n28) );
  CLKNAND2X2M U36 ( .A(B[10]), .B(A[10]), .Y(n27) );
  NOR2X1M U37 ( .A(B[10]), .B(A[10]), .Y(n25) );
endmodule


module ALU_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38;

  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n22, n21, n20, n19, n18, n17, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n9), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n6), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n5), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n7), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n8), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n4), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n3), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  CLKINVX2M U2 ( .A(B[0]), .Y(n30) );
  CLKINVX2M U3 ( .A(A[6]), .Y(n32) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n3) );
  AND2X2M U5 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n4) );
  AND2X2M U6 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n5) );
  AND2X2M U7 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n6) );
  AND2X2M U8 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n7) );
  AND2X2M U9 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n8) );
  AND2X2M U10 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n9) );
  INVX2M U11 ( .A(B[6]), .Y(n24) );
  AND2X2M U12 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  INVXLM U13 ( .A(n31), .Y(n11) );
  INVX2M U14 ( .A(n11), .Y(n12) );
  INVXLM U15 ( .A(A[7]), .Y(n31) );
  INVX2M U16 ( .A(B[7]), .Y(n23) );
  AND2X2M U17 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n18) );
  NAND2X2M U18 ( .A(\CARRYB[7][1] ), .B(n14), .Y(n15) );
  NAND2X2M U19 ( .A(n15), .B(n16), .Y(\A1[7] ) );
  NAND2X1M U20 ( .A(n13), .B(\SUMB[7][2] ), .Y(n16) );
  INVX2M U21 ( .A(\CARRYB[7][1] ), .Y(n13) );
  CLKINVX1M U22 ( .A(\SUMB[7][2] ), .Y(n14) );
  INVX2M U23 ( .A(A[1]), .Y(n37) );
  INVX2M U24 ( .A(A[0]), .Y(n38) );
  NOR2X2M U25 ( .A(n30), .B(n37), .Y(\ab[1][0] ) );
  XOR2X2M U26 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  XOR2X2M U27 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Y(\SUMB[1][4] ) );
  NOR2X2M U28 ( .A(n27), .B(n37), .Y(\ab[1][3] ) );
  XOR2XLM U29 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(\A1[6] ) );
  NOR2XLM U30 ( .A(n24), .B(n37), .Y(\ab[1][6] ) );
  NOR2XLM U31 ( .A(n12), .B(n24), .Y(\ab[7][6] ) );
  XOR2X2M U32 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  AND2X1M U33 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n20) );
  AND2X1M U34 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n19) );
  NOR2XLM U35 ( .A(n24), .B(n35), .Y(\ab[3][6] ) );
  NOR2XLM U36 ( .A(n24), .B(n34), .Y(\ab[4][6] ) );
  NOR2XLM U37 ( .A(n24), .B(n33), .Y(\ab[5][6] ) );
  NOR2XLM U38 ( .A(n24), .B(n32), .Y(\ab[6][6] ) );
  XOR2XLM U39 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  CLKINVX2M U40 ( .A(B[1]), .Y(n29) );
  NOR2XLM U41 ( .A(n25), .B(n37), .Y(\ab[1][5] ) );
  NOR2X2M U42 ( .A(n26), .B(n38), .Y(\ab[0][4] ) );
  NOR2X2M U43 ( .A(n25), .B(n38), .Y(\ab[0][5] ) );
  XOR2X2M U44 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Y(\SUMB[1][5] ) );
  XOR2X2M U45 ( .A(\ab[1][6] ), .B(\ab[0][7] ), .Y(\SUMB[1][6] ) );
  CLKINVX2M U46 ( .A(A[5]), .Y(n33) );
  NOR2XLM U47 ( .A(n30), .B(n38), .Y(PRODUCT[0]) );
  AND2X2M U48 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n17) );
  CLKXOR2X2M U49 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U50 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Y(\SUMB[1][1] ) );
  CLKXOR2X2M U51 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Y(\SUMB[1][2] ) );
  CLKXOR2X2M U52 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U53 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  AND2X2M U54 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n21) );
  AND2X2M U55 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n22) );
  CLKXOR2X2M U56 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Y(\SUMB[1][3] ) );
  INVX2M U57 ( .A(A[2]), .Y(n36) );
  INVX2M U58 ( .A(A[3]), .Y(n35) );
  INVX2M U59 ( .A(A[4]), .Y(n34) );
  CLKINVX2M U60 ( .A(B[2]), .Y(n28) );
  CLKINVX2M U61 ( .A(B[3]), .Y(n27) );
  CLKINVX2M U62 ( .A(B[4]), .Y(n26) );
  CLKINVX2M U63 ( .A(B[5]), .Y(n25) );
  NOR2X1M U65 ( .A(n12), .B(n23), .Y(\ab[7][7] ) );
  NOR2X1M U66 ( .A(n12), .B(n25), .Y(\ab[7][5] ) );
  NOR2X1M U67 ( .A(n12), .B(n26), .Y(\ab[7][4] ) );
  NOR2X1M U68 ( .A(n12), .B(n27), .Y(\ab[7][3] ) );
  NOR2X1M U69 ( .A(n12), .B(n28), .Y(\ab[7][2] ) );
  NOR2X1M U70 ( .A(n12), .B(n29), .Y(\ab[7][1] ) );
  NOR2X1M U71 ( .A(n12), .B(n30), .Y(\ab[7][0] ) );
  NOR2X1M U72 ( .A(n23), .B(n32), .Y(\ab[6][7] ) );
  NOR2X1M U73 ( .A(n25), .B(n32), .Y(\ab[6][5] ) );
  NOR2X1M U74 ( .A(n26), .B(n32), .Y(\ab[6][4] ) );
  NOR2X1M U75 ( .A(n27), .B(n32), .Y(\ab[6][3] ) );
  NOR2X1M U76 ( .A(n28), .B(n32), .Y(\ab[6][2] ) );
  NOR2X1M U77 ( .A(n29), .B(n32), .Y(\ab[6][1] ) );
  NOR2X1M U78 ( .A(n30), .B(n32), .Y(\ab[6][0] ) );
  NOR2X1M U79 ( .A(n23), .B(n33), .Y(\ab[5][7] ) );
  NOR2X1M U80 ( .A(n25), .B(n33), .Y(\ab[5][5] ) );
  NOR2X1M U81 ( .A(n26), .B(n33), .Y(\ab[5][4] ) );
  NOR2X1M U82 ( .A(n27), .B(n33), .Y(\ab[5][3] ) );
  NOR2X1M U83 ( .A(n28), .B(n33), .Y(\ab[5][2] ) );
  NOR2X1M U84 ( .A(n29), .B(n33), .Y(\ab[5][1] ) );
  NOR2X1M U85 ( .A(n30), .B(n33), .Y(\ab[5][0] ) );
  NOR2X1M U86 ( .A(n23), .B(n34), .Y(\ab[4][7] ) );
  NOR2X1M U87 ( .A(n25), .B(n34), .Y(\ab[4][5] ) );
  NOR2X1M U88 ( .A(n26), .B(n34), .Y(\ab[4][4] ) );
  NOR2X1M U89 ( .A(n27), .B(n34), .Y(\ab[4][3] ) );
  NOR2X1M U90 ( .A(n28), .B(n34), .Y(\ab[4][2] ) );
  NOR2X1M U91 ( .A(n29), .B(n34), .Y(\ab[4][1] ) );
  NOR2X1M U92 ( .A(n30), .B(n34), .Y(\ab[4][0] ) );
  NOR2X1M U93 ( .A(n23), .B(n35), .Y(\ab[3][7] ) );
  NOR2X1M U94 ( .A(n25), .B(n35), .Y(\ab[3][5] ) );
  NOR2X1M U95 ( .A(n26), .B(n35), .Y(\ab[3][4] ) );
  NOR2X1M U96 ( .A(n27), .B(n35), .Y(\ab[3][3] ) );
  NOR2X1M U97 ( .A(n28), .B(n35), .Y(\ab[3][2] ) );
  NOR2X1M U98 ( .A(n29), .B(n35), .Y(\ab[3][1] ) );
  NOR2X1M U99 ( .A(n30), .B(n35), .Y(\ab[3][0] ) );
  NOR2X1M U100 ( .A(n23), .B(n36), .Y(\ab[2][7] ) );
  NOR2X1M U101 ( .A(n24), .B(n36), .Y(\ab[2][6] ) );
  NOR2X1M U102 ( .A(n25), .B(n36), .Y(\ab[2][5] ) );
  NOR2X1M U103 ( .A(n26), .B(n36), .Y(\ab[2][4] ) );
  NOR2X1M U104 ( .A(n27), .B(n36), .Y(\ab[2][3] ) );
  NOR2X1M U105 ( .A(n28), .B(n36), .Y(\ab[2][2] ) );
  NOR2X1M U106 ( .A(n29), .B(n36), .Y(\ab[2][1] ) );
  NOR2X1M U107 ( .A(n30), .B(n36), .Y(\ab[2][0] ) );
  NOR2X1M U108 ( .A(n23), .B(n37), .Y(\ab[1][7] ) );
  NOR2X1M U109 ( .A(n26), .B(n37), .Y(\ab[1][4] ) );
  NOR2X1M U110 ( .A(n28), .B(n37), .Y(\ab[1][2] ) );
  NOR2X1M U111 ( .A(n29), .B(n37), .Y(\ab[1][1] ) );
  NOR2X1M U112 ( .A(n23), .B(n38), .Y(\ab[0][7] ) );
  NOR2X1M U113 ( .A(n24), .B(n38), .Y(\ab[0][6] ) );
  NOR2X1M U114 ( .A(n27), .B(n38), .Y(\ab[0][3] ) );
  NOR2X1M U115 ( .A(n28), .B(n38), .Y(\ab[0][2] ) );
  NOR2X1M U116 ( .A(n29), .B(n38), .Y(\ab[0][1] ) );
endmodule


module ALU_DW_div_uns_1 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   n173, n174, \u_div/SumTmp[1][0] , \u_div/SumTmp[1][3] ,
         \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] , \u_div/SumTmp[1][6] ,
         \u_div/SumTmp[2][0] , \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] ,
         \u_div/SumTmp[2][4] , \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] ,
         \u_div/SumTmp[3][1] , \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] ,
         \u_div/SumTmp[3][4] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] ,
         \u_div/SumTmp[6][1] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
         \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] ,
         \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] ,
         \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] ,
         \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] ,
         \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] ,
         \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] ,
         \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] ,
         \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] ,
         \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] ,
         \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] ,
         \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] ,
         \u_div/PartRem[1][1] , \u_div/PartRem[1][3] , \u_div/PartRem[1][4] ,
         \u_div/PartRem[1][5] , \u_div/PartRem[1][6] , \u_div/PartRem[1][7] ,
         \u_div/PartRem[2][4] , \u_div/PartRem[2][5] , \u_div/PartRem[2][6] ,
         \u_div/PartRem[3][2] , \u_div/PartRem[4][2] , n1, n2, n3, n4, n5, n6,
         n7, n8, n9, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172;
  wire   [7:0] \u_div/BInv ;

  ADDFHX8M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), 
        .S(\u_div/SumTmp[1][6] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/BInv [4]), .B(n128), .CI(
        \u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/BInv [3]), .B(n125), .CI(
        \u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(
        \u_div/BInv [5]), .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), 
        .S(\u_div/SumTmp[1][5] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/BInv [3]), .B(n40), .CI(
        \u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), 
        .S(\u_div/SumTmp[1][4] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_3  ( .A(n90), .B(\u_div/BInv [3]), .CI(
        \u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/CryTmp[6][1] ), .B(
        \u_div/BInv [1]), .CI(n139), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_2_4  ( .A(n127), .B(\u_div/BInv [4]), .CI(
        \u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_2_5  ( .A(n129), .B(\u_div/BInv [5]), .CI(
        \u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] )
         );
  ADDFHX8M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(
        \u_div/BInv [5]), .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] )
         );
  ADDFHX8M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] )
         );
  ADDFHX8M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(
        \u_div/BInv [7]), .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_0  ( .A(a[3]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[3][1] ), .S(\u_div/SumTmp[3][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_0  ( .A(a[2]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[2][1] ), .S(\u_div/SumTmp[2][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_0  ( .A(a[1]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[1][1] ), .S(\u_div/SumTmp[1][0] ) );
  NAND2X4M U1 ( .A(n1), .B(n2), .Y(\u_div/CryTmp[0][1] ) );
  CLKINVX8M U2 ( .A(\u_div/BInv [0]), .Y(n1) );
  CLKINVX8M U3 ( .A(a[0]), .Y(n2) );
  XOR3XLM U4 ( .A(a[6]), .B(\u_div/BInv [0]), .C(1'b1), .Y(
        \u_div/SumTmp[6][0] ) );
  CLKINVX8M U5 ( .A(\u_div/BInv [0]), .Y(n14) );
  NAND2X2M U6 ( .A(a[6]), .B(1'b1), .Y(n15) );
  NOR2X8M U7 ( .A(n162), .B(n163), .Y(n161) );
  NAND2X8M U8 ( .A(\u_div/CryTmp[1][1] ), .B(n7), .Y(n84) );
  NAND2X8M U9 ( .A(n7), .B(\u_div/BInv [1]), .Y(n85) );
  NAND2X8M U10 ( .A(n124), .B(\u_div/CryTmp[0][3] ), .Y(n78) );
  XOR2XLM U11 ( .A(n126), .B(\u_div/BInv [3]), .Y(n3) );
  XOR2XLM U12 ( .A(\u_div/CryTmp[2][3] ), .B(n3), .Y(\u_div/SumTmp[2][3] ) );
  NAND2X6M U13 ( .A(\u_div/CryTmp[2][3] ), .B(n126), .Y(n4) );
  NAND2X8M U14 ( .A(\u_div/CryTmp[2][3] ), .B(\u_div/BInv [3]), .Y(n5) );
  NAND2X6M U15 ( .A(n126), .B(\u_div/BInv [3]), .Y(n6) );
  NAND3X12M U16 ( .A(n4), .B(n5), .C(n6), .Y(\u_div/CryTmp[2][4] ) );
  MX2X12M U17 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(n174), 
        .Y(n126) );
  CLKINVX20M U18 ( .A(b[3]), .Y(\u_div/BInv [3]) );
  INVX14M U19 ( .A(n171), .Y(n174) );
  INVX8M U20 ( .A(n174), .Y(n102) );
  OR2X6M U21 ( .A(n160), .B(n159), .Y(n171) );
  MXI2X12M U22 ( .A(n8), .B(n9), .S0(n161), .Y(n7) );
  CLKINVX40M U23 ( .A(a[2]), .Y(n8) );
  CLKINVX40M U24 ( .A(\u_div/SumTmp[2][0] ), .Y(n9) );
  CLKNAND2X8M U25 ( .A(\u_div/PartRem[3][2] ), .B(n87), .Y(n88) );
  INVX6M U26 ( .A(quotient[2]), .Y(n87) );
  INVX12M U27 ( .A(n172), .Y(quotient[2]) );
  INVX12M U28 ( .A(n102), .Y(quotient[3]) );
  XNOR2X2M U29 ( .A(n57), .B(n120), .Y(n33) );
  CLKNAND2X16M U30 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/BInv [2]), .Y(n109)
         );
  NAND2BX12M U31 ( .AN(b[2]), .B(\u_div/CryTmp[2][2] ), .Y(n111) );
  INVXLM U32 ( .A(n7), .Y(n11) );
  CLKAND2X12M U33 ( .A(n81), .B(n82), .Y(n19) );
  CLKNAND2X8M U34 ( .A(n20), .B(\u_div/BInv [2]), .Y(n117) );
  AND2X8M U35 ( .A(n76), .B(n77), .Y(n20) );
  DLY1X1M U36 ( .A(n41), .Y(n12) );
  NAND2X4M U37 ( .A(\u_div/BInv [1]), .B(\u_div/CryTmp[5][1] ), .Y(n123) );
  NAND2X4M U38 ( .A(\u_div/BInv [0]), .B(a[6]), .Y(n13) );
  NAND3X4M U39 ( .A(n13), .B(n14), .C(n15), .Y(\u_div/CryTmp[6][1] ) );
  INVX14M U40 ( .A(b[0]), .Y(\u_div/BInv [0]) );
  CLKINVX40M U41 ( .A(b[7]), .Y(n29) );
  NAND2X5M U42 ( .A(n27), .B(b[0]), .Y(\u_div/CryTmp[7][1] ) );
  NAND2XLM U43 ( .A(n122), .B(n119), .Y(\u_div/CryTmp[5][2] ) );
  MXI2X8M U44 ( .A(n32), .B(n33), .S0(quotient[5]), .Y(n132) );
  CLKAND2X6M U45 ( .A(\u_div/CryTmp[6][2] ), .B(n68), .Y(quotient[6]) );
  CLKNAND2X16M U46 ( .A(\u_div/CryTmp[0][2] ), .B(\u_div/BInv [2]), .Y(n116)
         );
  NAND2X8M U47 ( .A(\u_div/CryTmp[0][3] ), .B(\u_div/BInv [3]), .Y(n80) );
  NAND2X12M U48 ( .A(\u_div/PartRem[1][1] ), .B(\u_div/CryTmp[0][1] ), .Y(n112) );
  BUFX10M U49 ( .A(n168), .Y(n38) );
  INVX12M U50 ( .A(b[6]), .Y(n28) );
  CLKINVX1M U51 ( .A(b[6]), .Y(\u_div/BInv [6]) );
  INVX32M U52 ( .A(b[1]), .Y(\u_div/BInv [1]) );
  MX2X4M U53 ( .A(n51), .B(\u_div/SumTmp[5][2] ), .S0(quotient[5]), .Y(n130)
         );
  MXI2X8M U54 ( .A(n140), .B(n17), .S0(n173), .Y(n139) );
  NAND2X3M U55 ( .A(\u_div/SumTmp[2][2] ), .B(quotient[2]), .Y(n89) );
  INVX12M U56 ( .A(a[7]), .Y(n27) );
  ADDFHX4M U57 ( .A(\u_div/BInv [3]), .B(n40), .CI(\u_div/CryTmp[4][3] ), .CO(
        n31) );
  NAND2X12M U58 ( .A(n141), .B(\u_div/CryTmp[3][1] ), .Y(n96) );
  NAND2X8M U59 ( .A(n141), .B(\u_div/BInv [1]), .Y(n95) );
  NAND2X12M U60 ( .A(\u_div/CryTmp[4][4] ), .B(n44), .Y(n143) );
  CLKMX2X12M U61 ( .A(\u_div/SumTmp[4][2] ), .B(n132), .S0(n169), .Y(n125) );
  INVX14M U62 ( .A(n169), .Y(quotient[4]) );
  NAND2X6M U63 ( .A(n31), .B(n44), .Y(n169) );
  NAND2X12M U64 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/BInv [2]), .Y(n99) );
  INVX20M U65 ( .A(n154), .Y(\u_div/PartRem[4][2] ) );
  INVXLM U66 ( .A(a[6]), .Y(n134) );
  XNOR2X4M U67 ( .A(n51), .B(b[2]), .Y(n58) );
  NAND2X12M U68 ( .A(n133), .B(\u_div/BInv [1]), .Y(n121) );
  NAND2X12M U69 ( .A(n63), .B(\u_div/CryTmp[2][1] ), .Y(n106) );
  XOR2X4M U70 ( .A(\u_div/CryTmp[5][2] ), .B(n58), .Y(\u_div/SumTmp[5][2] ) );
  XOR2X2M U71 ( .A(\u_div/BInv [1]), .B(\u_div/CryTmp[5][1] ), .Y(n120) );
  INVX2M U72 ( .A(n57), .Y(n32) );
  NAND2XLM U73 ( .A(\u_div/BInv [1]), .B(\u_div/CryTmp[3][1] ), .Y(n97) );
  NAND2XLM U74 ( .A(\u_div/BInv [1]), .B(\u_div/CryTmp[2][1] ), .Y(n107) );
  INVX4M U75 ( .A(n19), .Y(\u_div/PartRem[2][4] ) );
  CLKNAND2X12M U76 ( .A(\u_div/CryTmp[1][7] ), .B(n29), .Y(n24) );
  CLKXOR2X2M U77 ( .A(\u_div/BInv [0]), .B(a[5]), .Y(n36) );
  INVX2M U78 ( .A(a[3]), .Y(n64) );
  INVX2M U79 ( .A(\u_div/SumTmp[3][0] ), .Y(n65) );
  NAND2X2M U80 ( .A(\u_div/CryTmp[0][1] ), .B(\u_div/BInv [1]), .Y(n114) );
  BUFX6M U81 ( .A(n130), .Y(n40) );
  INVX2M U82 ( .A(n50), .Y(n44) );
  MX2X4M U83 ( .A(n145), .B(\u_div/SumTmp[6][1] ), .S0(quotient[6]), .Y(n51)
         );
  INVX2M U84 ( .A(a[7]), .Y(n140) );
  INVX2M U85 ( .A(n53), .Y(n43) );
  INVX2M U86 ( .A(\u_div/SumTmp[1][3] ), .Y(n156) );
  INVX4M U87 ( .A(n146), .Y(\u_div/PartRem[2][6] ) );
  CLKINVX16M U88 ( .A(b[2]), .Y(n167) );
  INVX2M U89 ( .A(n147), .Y(\u_div/PartRem[2][5] ) );
  INVX2M U90 ( .A(\u_div/SumTmp[1][4] ), .Y(n153) );
  NAND2X8M U91 ( .A(n62), .B(n51), .Y(n59) );
  MX2X3M U92 ( .A(n145), .B(\u_div/SumTmp[6][1] ), .S0(quotient[6]), .Y(n131)
         );
  NAND2X5M U93 ( .A(\u_div/CryTmp[5][1] ), .B(n133), .Y(n122) );
  INVX12M U94 ( .A(n118), .Y(n119) );
  NAND2X8M U95 ( .A(n63), .B(\u_div/BInv [1]), .Y(n105) );
  MXI2X8M U96 ( .A(n55), .B(n42), .S0(quotient[2]), .Y(n41) );
  OR2X4M U97 ( .A(n163), .B(n162), .Y(n172) );
  NAND2BX1M U98 ( .AN(n162), .B(\u_div/BInv [5]), .Y(n159) );
  INVX16M U99 ( .A(n162), .Y(n26) );
  NAND2BX1M U100 ( .AN(n162), .B(n170), .Y(n50) );
  NAND2X6M U101 ( .A(\u_div/CryTmp[3][2] ), .B(\u_div/PartRem[4][2] ), .Y(n100) );
  XNOR2XLM U102 ( .A(\u_div/CryTmp[4][2] ), .B(b[2]), .Y(n16) );
  NAND2X5M U103 ( .A(n132), .B(\u_div/BInv [2]), .Y(n74) );
  MXI2X12M U104 ( .A(n47), .B(\u_div/SumTmp[4][1] ), .S0(quotient[4]), .Y(n154) );
  INVX20M U105 ( .A(n157), .Y(\u_div/PartRem[3][2] ) );
  NAND2X12M U106 ( .A(\u_div/CryTmp[4][2] ), .B(\u_div/BInv [2]), .Y(n75) );
  NAND2X6M U107 ( .A(\u_div/CryTmp[1][2] ), .B(n41), .Y(n92) );
  XNOR2XLM U108 ( .A(n12), .B(n91), .Y(n18) );
  NAND2X2M U109 ( .A(n11), .B(n23), .Y(n76) );
  INVX2M U110 ( .A(n30), .Y(n54) );
  CLKINVX6M U111 ( .A(b[2]), .Y(\u_div/BInv [2]) );
  INVX2M U112 ( .A(n55), .Y(n56) );
  INVX4M U113 ( .A(a[5]), .Y(n35) );
  XNOR2X2M U114 ( .A(b[0]), .B(a[7]), .Y(n17) );
  INVX10M U115 ( .A(n23), .Y(quotient[1]) );
  NAND2X12M U116 ( .A(n48), .B(n29), .Y(n23) );
  CLKXOR2X2M U117 ( .A(\u_div/BInv [0]), .B(a[4]), .Y(n21) );
  XNOR2X2M U118 ( .A(n83), .B(n7), .Y(n22) );
  BUFX2M U119 ( .A(n45), .Y(n53) );
  INVX4M U120 ( .A(b[3]), .Y(n25) );
  MXI2X1M U121 ( .A(n146), .B(n150), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][7] ) );
  INVX12M U122 ( .A(n24), .Y(n166) );
  NAND3X12M U123 ( .A(n25), .B(n26), .C(n170), .Y(n155) );
  NAND2X12M U124 ( .A(n119), .B(n122), .Y(n62) );
  CLKNAND2X16M U125 ( .A(n167), .B(n38), .Y(n152) );
  NAND2X12M U126 ( .A(n28), .B(n29), .Y(n162) );
  MX2X1M U127 ( .A(n40), .B(\u_div/SumTmp[4][3] ), .S0(quotient[4]), .Y(n128)
         );
  CLKINVX4M U128 ( .A(n46), .Y(n47) );
  XOR2X1M U129 ( .A(n16), .B(n132), .Y(\u_div/SumTmp[4][2] ) );
  NAND2BX12M U130 ( .AN(b[1]), .B(n34), .Y(n71) );
  MX2X1M U131 ( .A(n21), .B(n142), .S0(n143), .Y(n30) );
  NAND2X2M U132 ( .A(\u_div/SumTmp[3][3] ), .B(quotient[3]), .Y(n104) );
  MXI2X8M U133 ( .A(n54), .B(\u_div/SumTmp[3][1] ), .S0(n174), .Y(n157) );
  MX2X1M U134 ( .A(n128), .B(\u_div/SumTmp[3][4] ), .S0(quotient[3]), .Y(n129)
         );
  MXI2X1M U135 ( .A(n19), .B(n153), .S0(quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  NAND2X8M U136 ( .A(n34), .B(\u_div/CryTmp[4][1] ), .Y(n70) );
  NAND2X12M U137 ( .A(\u_div/CryTmp[5][3] ), .B(n43), .Y(n37) );
  AND2X8M U138 ( .A(\u_div/CryTmp[5][3] ), .B(n43), .Y(quotient[5]) );
  MXI2X12M U139 ( .A(n36), .B(n35), .S0(n37), .Y(n34) );
  INVX1M U140 ( .A(n155), .Y(n168) );
  CLKXOR2X2M U141 ( .A(n47), .B(n69), .Y(\u_div/SumTmp[4][1] ) );
  NAND2X3M U142 ( .A(n126), .B(n87), .Y(n81) );
  CLKINVX16M U143 ( .A(\u_div/CryTmp[2][6] ), .Y(n163) );
  CLKNAND2X8M U144 ( .A(n41), .B(\u_div/BInv [2]), .Y(n93) );
  XNOR3XLM U145 ( .A(n56), .B(\u_div/BInv [1]), .C(\u_div/CryTmp[2][1] ), .Y(
        n42) );
  INVXLM U146 ( .A(n12), .Y(n149) );
  CLKINVX32M U147 ( .A(n152), .Y(n68) );
  INVXLM U148 ( .A(n38), .Y(n45) );
  XNOR2X2M U149 ( .A(n98), .B(n52), .Y(\u_div/SumTmp[3][2] ) );
  NAND2X8M U150 ( .A(n103), .B(n104), .Y(n127) );
  INVXLM U151 ( .A(n34), .Y(n46) );
  ADDFHX8M U152 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/BInv [6]), .CI(
        \u_div/CryTmp[1][6] ), .CO(n48) );
  NAND3XLM U153 ( .A(\u_div/BInv [1]), .B(n167), .C(\u_div/CryTmp[7][1] ), .Y(
        n49) );
  NAND3X12M U154 ( .A(\u_div/BInv [1]), .B(n167), .C(\u_div/CryTmp[7][1] ), 
        .Y(n67) );
  INVXLM U155 ( .A(\u_div/CryTmp[3][2] ), .Y(n52) );
  CLKNAND2X8M U156 ( .A(\u_div/CryTmp[0][2] ), .B(n20), .Y(n115) );
  NAND2X8M U157 ( .A(\u_div/CryTmp[2][2] ), .B(\u_div/PartRem[3][2] ), .Y(n110) );
  NAND2X12M U158 ( .A(n121), .B(n123), .Y(n118) );
  INVXLM U159 ( .A(n63), .Y(n55) );
  BUFX2M U160 ( .A(n133), .Y(n57) );
  XOR2XLM U161 ( .A(\u_div/CryTmp[1][2] ), .B(\u_div/BInv [2]), .Y(n91) );
  NAND2X12M U162 ( .A(n62), .B(\u_div/BInv [2]), .Y(n60) );
  NAND2X4M U163 ( .A(n131), .B(\u_div/BInv [2]), .Y(n61) );
  NAND3X12M U164 ( .A(n59), .B(n60), .C(n61), .Y(\u_div/CryTmp[5][3] ) );
  NAND2X12M U165 ( .A(\u_div/CryTmp[3][2] ), .B(\u_div/BInv [2]), .Y(n101) );
  MXI2X12M U166 ( .A(n64), .B(n65), .S0(n158), .Y(n63) );
  MXI2X1M U167 ( .A(n127), .B(\u_div/SumTmp[2][4] ), .S0(quotient[2]), .Y(n147) );
  NAND2X1M U168 ( .A(\u_div/SumTmp[2][3] ), .B(quotient[2]), .Y(n82) );
  NAND2X12M U169 ( .A(\u_div/CryTmp[6][2] ), .B(n68), .Y(n136) );
  NOR2XLM U170 ( .A(n53), .B(n49), .Y(quotient[7]) );
  NOR2X12M U171 ( .A(n155), .B(n67), .Y(n173) );
  INVXLM U172 ( .A(n90), .Y(n148) );
  CLKNAND2X12M U173 ( .A(\u_div/CryTmp[1][2] ), .B(\u_div/BInv [2]), .Y(n94)
         );
  MXI2X1M U174 ( .A(n148), .B(n156), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][4] ) );
  NAND3X12M U175 ( .A(n73), .B(n75), .C(n74), .Y(\u_div/CryTmp[4][3] ) );
  NAND2X6M U176 ( .A(\u_div/CryTmp[4][2] ), .B(n132), .Y(n73) );
  NAND2X12M U177 ( .A(\u_div/PartRem[1][1] ), .B(\u_div/BInv [1]), .Y(n113) );
  NAND2X4M U178 ( .A(n22), .B(quotient[1]), .Y(n77) );
  NAND2X4M U179 ( .A(n124), .B(\u_div/BInv [3]), .Y(n79) );
  NAND3X12M U180 ( .A(n100), .B(n101), .C(n99), .Y(\u_div/CryTmp[3][3] ) );
  XOR2XLM U181 ( .A(\u_div/CryTmp[4][1] ), .B(\u_div/BInv [1]), .Y(n69) );
  NAND2X2M U182 ( .A(\u_div/CryTmp[4][1] ), .B(\u_div/BInv [1]), .Y(n72) );
  NAND3X12M U183 ( .A(n70), .B(n71), .C(n72), .Y(\u_div/CryTmp[4][2] ) );
  OR2X2M U184 ( .A(\u_div/BInv [0]), .B(a[4]), .Y(\u_div/CryTmp[4][1] ) );
  NAND3X12M U185 ( .A(n78), .B(n80), .C(n79), .Y(\u_div/CryTmp[0][4] ) );
  BUFX4M U186 ( .A(\u_div/PartRem[1][3] ), .Y(n124) );
  XOR2XLM U187 ( .A(\u_div/CryTmp[1][1] ), .B(\u_div/BInv [1]), .Y(n83) );
  CLKNAND2X2M U188 ( .A(\u_div/CryTmp[1][1] ), .B(\u_div/BInv [1]), .Y(n86) );
  NAND3X12M U189 ( .A(n84), .B(n85), .C(n86), .Y(\u_div/CryTmp[1][2] ) );
  NAND2X8M U190 ( .A(n88), .B(n89), .Y(n90) );
  NAND3X12M U191 ( .A(n92), .B(n94), .C(n93), .Y(\u_div/CryTmp[1][3] ) );
  XOR3XLM U192 ( .A(n54), .B(\u_div/BInv [1]), .C(\u_div/CryTmp[3][1] ), .Y(
        \u_div/SumTmp[3][1] ) );
  NAND3X12M U193 ( .A(n95), .B(n96), .C(n97), .Y(\u_div/CryTmp[3][2] ) );
  XOR2XLM U194 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/BInv [2]), .Y(n98) );
  NAND2X4M U195 ( .A(n125), .B(n102), .Y(n103) );
  NAND3X12M U196 ( .A(n105), .B(n106), .C(n107), .Y(\u_div/CryTmp[2][2] ) );
  XOR2X2M U197 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/BInv [2]), .Y(n108) );
  XOR2XLM U198 ( .A(n108), .B(\u_div/CryTmp[2][2] ), .Y(\u_div/SumTmp[2][2] )
         );
  NAND3X12M U199 ( .A(n110), .B(n111), .C(n109), .Y(\u_div/CryTmp[2][3] ) );
  NAND3X12M U200 ( .A(n112), .B(n113), .C(n114), .Y(\u_div/CryTmp[0][2] ) );
  NAND3X12M U201 ( .A(n115), .B(n116), .C(n117), .Y(\u_div/CryTmp[0][3] ) );
  NAND2X2M U202 ( .A(n138), .B(n35), .Y(\u_div/CryTmp[5][1] ) );
  MXI2X12M U203 ( .A(n164), .B(n165), .S0(n166), .Y(\u_div/PartRem[1][1] ) );
  MXI2XLM U204 ( .A(n129), .B(\u_div/SumTmp[2][5] ), .S0(quotient[2]), .Y(n146) );
  NOR2X12M U205 ( .A(n160), .B(n159), .Y(n158) );
  MXI2X12M U206 ( .A(n135), .B(n134), .S0(n136), .Y(n133) );
  INVX4M U207 ( .A(\u_div/SumTmp[6][0] ), .Y(n135) );
  MXI2X1M U208 ( .A(n149), .B(n18), .S0(quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  INVX4M U209 ( .A(\u_div/SumTmp[1][6] ), .Y(n150) );
  INVX2M U210 ( .A(a[1]), .Y(n164) );
  INVX2M U211 ( .A(\u_div/SumTmp[1][0] ), .Y(n165) );
  INVX2M U212 ( .A(a[4]), .Y(n142) );
  MXI2X1M U213 ( .A(n147), .B(n151), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][6] ) );
  INVX4M U214 ( .A(\u_div/SumTmp[1][5] ), .Y(n151) );
  INVXLM U215 ( .A(\u_div/BInv [0]), .Y(n138) );
  CLKINVX2M U216 ( .A(b[4]), .Y(\u_div/BInv [4]) );
  CLKINVX2M U217 ( .A(b[5]), .Y(\u_div/BInv [5]) );
  INVXLM U218 ( .A(b[7]), .Y(\u_div/BInv [7]) );
  MXI2X12M U219 ( .A(n21), .B(n142), .S0(n143), .Y(n141) );
  INVXLM U220 ( .A(n139), .Y(n144) );
  INVX3M U221 ( .A(n144), .Y(n145) );
  NOR2X12M U222 ( .A(b[4]), .B(b[5]), .Y(n170) );
  CLKINVX16M U223 ( .A(\u_div/CryTmp[3][5] ), .Y(n160) );
endmodule


module ALU ( A, B, ALU_FUN, clk, en, rst, ALU_OUT, out_valid );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input clk, en, rst;
  output out_valid;
  wire   out_valid_comb, N68, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78,
         N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90, N91, N92,
         N93, N94, N95, N96, N97, N98, N99, N100, N101, N104, N105, N106, N107,
         N108, N109, N110, N111, n37, n38, n39, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n58, n61, n62, n63, n64, n68, n69, n70, n71,
         n75, n76, n77, n78, n82, n83, n84, n85, n89, n90, n91, n92, n106,
         n114, n116, n123, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n40, n41, n42, n54, n55, n56,
         n57, n59, n60, n65, n66, n67, n72, n73, n74, n79, n80, n81, n86, n87,
         n88, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n107, n108, n109, n110, n111, n112, n113, n115, n117, n118,
         n119, n120, n121, n122, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n172, n173, n174,
         n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191;
  wire   [15:0] ALU_OUT_comb;

  ALU_DW01_sub_0 sub_37 ( .A({1'b0, A[7], n33, n5, n31, n30, n29, n28, A[0]}), 
        .B({1'b0, n13, n14, B[5:2], n27, n26}), .CI(1'b0), .DIFF({N85, N84, 
        N83, N82, N81, N80, N79, N78, N77}) );
  ALU_DW01_add_0 add_33 ( .A({1'b0, A[7], n33, n4, n31, n30, n29, n28, A[0]}), 
        .B({1'b0, n13, n14, B[5:2], n27, n9}), .CI(1'b0), .SUM({N76, N75, N74, 
        N73, N72, N71, N70, N69, N68}) );
  ALU_DW02_mult_0 mult_41 ( .A({A[7], n33, n5, n31, n30, n29, n28, A[0]}), .B(
        {n13, n14, B[5:3], n16, n27, n26}), .TC(1'b0), .PRODUCT({N101, N100, 
        N99, N98, N97, N96, N95, N94, N93, N92, N91, N90, N89, N88, N87, N86})
         );
  ALU_DW_div_uns_1 div_46 ( .a({A[7], n33, n3, n31, n30, n29, n28, A[0]}), .b(
        {B[7:3], n16, n27, n26}), .quotient({N111, N110, N109, N108, N107, 
        N106, N105, N104}) );
  DFFRQX1M \ALU_OUT_reg[0]  ( .D(ALU_OUT_comb[0]), .CK(clk), .RN(rst), .Q(
        ALU_OUT[0]) );
  DFFRQX1M \ALU_OUT_reg[1]  ( .D(ALU_OUT_comb[1]), .CK(clk), .RN(n35), .Q(
        ALU_OUT[1]) );
  DFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_comb[15]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[15]) );
  DFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_comb[14]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[14]) );
  DFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_comb[13]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[13]) );
  DFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_comb[12]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[12]) );
  DFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_comb[11]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[11]) );
  DFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_comb[10]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[10]) );
  DFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_comb[9]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[9]) );
  DFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_comb[8]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[8]) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_comb[7]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_comb[6]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_comb[5]), .CK(clk), .RN(n34), .Q(
        ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_comb[4]), .CK(clk), .RN(n35), .Q(
        ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_comb[3]), .CK(clk), .RN(n35), .Q(
        ALU_OUT[3]) );
  DFFRQX2M out_valid_reg ( .D(out_valid_comb), .CK(clk), .RN(n34), .Q(
        out_valid) );
  DFFRQX1M \ALU_OUT_reg[2]  ( .D(ALU_OUT_comb[2]), .CK(clk), .RN(n35), .Q(
        ALU_OUT[2]) );
  CLKBUFX32M U3 ( .A(A[6]), .Y(n33) );
  BUFX32M U4 ( .A(B[1]), .Y(n27) );
  BUFX4M U5 ( .A(n32), .Y(n3) );
  BUFX2M U8 ( .A(n32), .Y(n4) );
  BUFX2M U9 ( .A(n32), .Y(n5) );
  INVXLM U10 ( .A(n33), .Y(n154) );
  AOI32XLM U11 ( .A0(n180), .A1(n179), .A2(n178), .B0(n33), .B1(n156), .Y(n181) );
  MX2X2M U12 ( .A(n48), .B(n98), .S0(n97), .Y(n100) );
  BUFX2M U13 ( .A(B[7]), .Y(n13) );
  BUFX4M U14 ( .A(A[5]), .Y(n32) );
  OR4X1M U15 ( .A(n105), .B(n104), .C(n103), .D(n102), .Y(n12) );
  INVX20M U16 ( .A(B[2]), .Y(n15) );
  CLKINVX20M U17 ( .A(n15), .Y(n16) );
  AND2X2M U18 ( .A(n18), .B(n123), .Y(n6) );
  AND2X2M U19 ( .A(n114), .B(n123), .Y(n7) );
  AND3X2M U20 ( .A(n106), .B(ALU_FUN[3]), .C(n73), .Y(n8) );
  BUFX4M U21 ( .A(A[4]), .Y(n31) );
  INVX2M U22 ( .A(n159), .Y(n9) );
  INVXLM U23 ( .A(n153), .Y(n10) );
  INVX2M U24 ( .A(n10), .Y(n11) );
  BUFX2M U25 ( .A(B[6]), .Y(n14) );
  AOI2BB1X8M U26 ( .A0N(N104), .A1N(n12), .B0(n113), .Y(ALU_OUT_comb[0]) );
  INVXLM U27 ( .A(A[7]), .Y(n153) );
  NAND2XLM U28 ( .A(A[7]), .B(n56), .Y(n94) );
  MXI2XLM U29 ( .A(n150), .B(n149), .S0(n14), .Y(n22) );
  BUFX4M U30 ( .A(A[1]), .Y(n28) );
  BUFX4M U31 ( .A(A[2]), .Y(n29) );
  AOI222XLM U32 ( .A0(N91), .A1(n17), .B0(n189), .B1(n184), .C0(n5), .C1(n188), 
        .Y(n69) );
  MX2XLM U33 ( .A(n25), .B(n147), .S0(n27), .Y(n117) );
  MX2XLM U34 ( .A(n145), .B(n25), .S0(n27), .Y(n115) );
  AOI21XLM U35 ( .A0(n160), .A1(n155), .B0(n27), .Y(n161) );
  MX2XLM U36 ( .A(n43), .B(n44), .S0(n27), .Y(n128) );
  INVXLM U37 ( .A(n4), .Y(n184) );
  MX2XLM U38 ( .A(n86), .B(n81), .S0(A[0]), .Y(n101) );
  OAI221XLM U39 ( .A0(n31), .A1(n145), .B0(n185), .B1(n25), .C0(n43), .Y(n140)
         );
  AOI222XLM U40 ( .A0(N78), .A1(n6), .B0(n190), .B1(n29), .C0(A[0]), .C1(n8), 
        .Y(n126) );
  NAND2XLM U41 ( .A(A[0]), .B(n159), .Y(n169) );
  NOR2XLM U42 ( .A(n159), .B(A[0]), .Y(n160) );
  INVX2M U43 ( .A(n74), .Y(n145) );
  INVX2M U44 ( .A(n43), .Y(n189) );
  INVX2M U45 ( .A(n44), .Y(n188) );
  INVX2M U46 ( .A(n47), .Y(n147) );
  INVX2M U47 ( .A(n50), .Y(n190) );
  NAND3X2M U48 ( .A(n43), .B(n44), .C(n45), .Y(n39) );
  OAI2BB1X2M U49 ( .A0N(N100), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[14]) );
  OAI2BB1X2M U50 ( .A0N(N101), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[15]) );
  OAI2BB1X2M U51 ( .A0N(N99), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[13]) );
  OAI2BB1X2M U52 ( .A0N(N98), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[12]) );
  OAI2BB1X2M U53 ( .A0N(N96), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[10]) );
  OAI2BB1X2M U54 ( .A0N(N97), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[11]) );
  INVX2M U55 ( .A(n88), .Y(n152) );
  NAND2X4M U56 ( .A(n19), .B(n18), .Y(n44) );
  NAND2X2M U57 ( .A(n106), .B(n114), .Y(n43) );
  OAI2BB1X2M U58 ( .A0N(N95), .A1N(n51), .B0(n52), .Y(ALU_OUT_comb[9]) );
  AND2X2M U59 ( .A(n152), .B(n114), .Y(n17) );
  AOI21X2M U60 ( .A0(n37), .A1(n38), .B0(n191), .Y(out_valid_comb) );
  NOR3X2M U61 ( .A(n46), .B(n8), .C(n47), .Y(n37) );
  NOR4X1M U62 ( .A(n39), .B(n6), .C(n7), .D(n152), .Y(n38) );
  NAND3X2M U63 ( .A(n48), .B(n25), .C(n50), .Y(n46) );
  INVX2M U64 ( .A(n48), .Y(n124) );
  AND2X2M U65 ( .A(n17), .B(en), .Y(n51) );
  INVX2M U66 ( .A(n25), .Y(n42) );
  INVX2M U67 ( .A(en), .Y(n191) );
  OAI2B1X2M U68 ( .A1N(n112), .A0(n111), .B0(en), .Y(n113) );
  INVX2M U69 ( .A(ALU_FUN[3]), .Y(n93) );
  AND2X2M U70 ( .A(ALU_FUN[0]), .B(n93), .Y(n18) );
  INVX2M U71 ( .A(n105), .Y(n112) );
  NOR2X2M U72 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n123) );
  NOR2X2M U73 ( .A(ALU_FUN[3]), .B(ALU_FUN[0]), .Y(n114) );
  NOR2BX2M U74 ( .AN(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n19) );
  INVX2M U75 ( .A(ALU_FUN[0]), .Y(n73) );
  NAND3X2M U76 ( .A(ALU_FUN[0]), .B(n123), .C(ALU_FUN[3]), .Y(n116) );
  OAI2BB2X1M U77 ( .B0(n11), .B1(n44), .A0N(N93), .A1N(n17), .Y(n58) );
  OR4X1M U78 ( .A(n93), .B(n88), .C(ALU_FUN[0]), .D(n120), .Y(n98) );
  INVX2M U79 ( .A(n125), .Y(n97) );
  BUFX4M U80 ( .A(n49), .Y(n25) );
  NAND3X2M U81 ( .A(ALU_FUN[3]), .B(n123), .C(n73), .Y(n49) );
  INVX2M U82 ( .A(ALU_FUN[2]), .Y(n40) );
  AND2X2M U83 ( .A(ALU_FUN[1]), .B(ALU_FUN[2]), .Y(n106) );
  AND3X2M U84 ( .A(n152), .B(n120), .C(n20), .Y(n121) );
  NAND3X2M U85 ( .A(n6), .B(en), .C(N85), .Y(n52) );
  AND2X2M U86 ( .A(ALU_FUN[3]), .B(ALU_FUN[0]), .Y(n20) );
  INVX2M U87 ( .A(n107), .Y(n102) );
  MX2X2M U88 ( .A(n189), .B(n47), .S0(n57), .Y(n59) );
  NOR2X2M U89 ( .A(n11), .B(n56), .Y(n57) );
  INVX4M U90 ( .A(n36), .Y(n34) );
  INVX2M U91 ( .A(n36), .Y(n35) );
  AOI22X1M U92 ( .A0(n125), .A1(n124), .B0(N87), .B1(n17), .Y(n130) );
  AND3X2M U93 ( .A(n128), .B(n127), .C(n126), .Y(n129) );
  AOI31X2M U94 ( .A0(n89), .A1(n90), .A2(n91), .B0(n191), .Y(ALU_OUT_comb[2])
         );
  AOI22X1M U95 ( .A0(N79), .A1(n6), .B0(N70), .B1(n7), .Y(n89) );
  AOI222X1M U96 ( .A0(N88), .A1(n17), .B0(n189), .B1(n187), .C0(n29), .C1(n188), .Y(n90) );
  AOI221XLM U97 ( .A0(n28), .A1(n8), .B0(n30), .B1(n190), .C0(n92), .Y(n91) );
  NAND4BX1M U98 ( .AN(n101), .B(n21), .C(n100), .D(n99), .Y(n105) );
  MXI2XLM U99 ( .A(n189), .B(n188), .S0(n9), .Y(n21) );
  AOI31X2M U100 ( .A0(n82), .A1(n83), .A2(n84), .B0(n191), .Y(ALU_OUT_comb[3])
         );
  AOI22X1M U101 ( .A0(N80), .A1(n6), .B0(N71), .B1(n7), .Y(n82) );
  AOI222X1M U102 ( .A0(N89), .A1(n17), .B0(n189), .B1(n186), .C0(n30), .C1(
        n188), .Y(n83) );
  AOI221XLM U103 ( .A0(n29), .A1(n8), .B0(n31), .B1(n190), .C0(n85), .Y(n84)
         );
  OAI2BB1XLM U104 ( .A0N(N110), .A1N(n151), .B0(n22), .Y(n64) );
  AOI31X2M U105 ( .A0(n61), .A1(n62), .A2(n63), .B0(n191), .Y(ALU_OUT_comb[6])
         );
  AOI22X1M U106 ( .A0(N83), .A1(n6), .B0(N74), .B1(n7), .Y(n61) );
  AOI222X1M U107 ( .A0(N92), .A1(n17), .B0(n189), .B1(n154), .C0(n188), .C1(
        n33), .Y(n62) );
  AOI221XLM U108 ( .A0(n4), .A1(n8), .B0(n190), .B1(A[7]), .C0(n64), .Y(n63)
         );
  MX2XLM U109 ( .A(n145), .B(n25), .S0(n9), .Y(n79) );
  MX2X2M U110 ( .A(n145), .B(n25), .S0(n33), .Y(n146) );
  MX2X2M U111 ( .A(n119), .B(n118), .S0(n28), .Y(n122) );
  INVX2M U112 ( .A(n170), .Y(n183) );
  INVX2M U113 ( .A(n160), .Y(n182) );
  INVX2M U114 ( .A(n109), .Y(n151) );
  OAI2B1X2M U115 ( .A1N(n94), .A0(n96), .B0(n95), .Y(n125) );
  OAI21X2M U116 ( .A0(n181), .A1(n87), .B0(n94), .Y(n120) );
  INVX2M U117 ( .A(n95), .Y(n87) );
  AOI22X1M U118 ( .A0(n8), .A1(n33), .B0(N84), .B1(n6), .Y(n67) );
  NOR4BBX1M U119 ( .AN(n65), .BN(n60), .C(n58), .D(n59), .Y(n66) );
  AOI31X2M U120 ( .A0(n75), .A1(n76), .A2(n77), .B0(n191), .Y(ALU_OUT_comb[4])
         );
  AOI22X1M U121 ( .A0(N81), .A1(n6), .B0(N72), .B1(n7), .Y(n75) );
  AOI222X1M U122 ( .A0(N90), .A1(n17), .B0(n189), .B1(n185), .C0(n31), .C1(
        n188), .Y(n76) );
  AOI221XLM U123 ( .A0(n30), .A1(n8), .B0(n190), .B1(n5), .C0(n78), .Y(n77) );
  AOI31X2M U124 ( .A0(n68), .A1(n69), .A2(n70), .B0(n191), .Y(ALU_OUT_comb[5])
         );
  AOI22X1M U125 ( .A0(N82), .A1(n6), .B0(N73), .B1(n7), .Y(n68) );
  AOI221XLM U126 ( .A0(n31), .A1(n8), .B0(n190), .B1(n33), .C0(n71), .Y(n70)
         );
  INVX2M U127 ( .A(n28), .Y(n155) );
  INVXLM U128 ( .A(n26), .Y(n159) );
  MX2X2M U129 ( .A(n145), .B(n25), .S0(n29), .Y(n132) );
  MX2X2M U130 ( .A(n25), .B(n147), .S0(n29), .Y(n133) );
  MX2X2M U131 ( .A(n25), .B(n147), .S0(n33), .Y(n148) );
  OAI21X2M U132 ( .A0(n53), .A1(n191), .B0(n52), .Y(ALU_OUT_comb[8]) );
  AOI222X1M U133 ( .A0(N76), .A1(n7), .B0(A[7]), .B1(n8), .C0(N94), .C1(n17), 
        .Y(n53) );
  NAND4X2M U134 ( .A(n110), .B(n109), .C(n108), .D(n107), .Y(n111) );
  INVX2M U135 ( .A(n110), .Y(n103) );
  INVX2M U136 ( .A(n108), .Y(n104) );
  INVXLM U137 ( .A(n13), .Y(n56) );
  INVX2M U138 ( .A(n31), .Y(n185) );
  INVX2M U139 ( .A(n30), .Y(n186) );
  INVX2M U140 ( .A(n29), .Y(n187) );
  INVX2M U141 ( .A(rst), .Y(n36) );
  OAI2BB1XLM U142 ( .A0N(N106), .A1N(n151), .B0(n23), .Y(n92) );
  MXI2XLM U143 ( .A(n135), .B(n134), .S0(B[2]), .Y(n23) );
  BUFX4M U144 ( .A(A[3]), .Y(n30) );
  AO21XLM U145 ( .A0(N107), .A1(n151), .B0(n138), .Y(n85) );
  MX2XLM U146 ( .A(n137), .B(n136), .S0(B[3]), .Y(n138) );
  OAI221X1M U147 ( .A0(n25), .A1(n30), .B0(n147), .B1(n186), .C0(n44), .Y(n136) );
  OAI221X1M U148 ( .A0(n30), .A1(n145), .B0(n186), .B1(n25), .C0(n43), .Y(n137) );
  MX2XLM U149 ( .A(n25), .B(n147), .S0(n9), .Y(n80) );
  OAI211X2M U150 ( .A0(n24), .A1(n41), .B0(n152), .C0(n18), .Y(n109) );
  OR4X1M U151 ( .A(B[2]), .B(B[3]), .C(n14), .D(n9), .Y(n24) );
  INVXLM U152 ( .A(B[2]), .Y(n158) );
  MX2XLM U153 ( .A(n140), .B(n139), .S0(B[4]), .Y(n141) );
  OAI221X1M U154 ( .A0(n25), .A1(A[4]), .B0(n147), .B1(n185), .C0(n44), .Y(
        n139) );
  MX2XLM U155 ( .A(n143), .B(n142), .S0(B[5]), .Y(n144) );
  OAI221X1M U156 ( .A0(n25), .A1(n5), .B0(n147), .B1(n184), .C0(n44), .Y(n142)
         );
  OAI221XLM U157 ( .A0(n4), .A1(n145), .B0(n184), .B1(n25), .C0(n43), .Y(n143)
         );
  INVXLM U158 ( .A(B[3]), .Y(n157) );
  INVXLM U159 ( .A(n14), .Y(n156) );
  AOI22XLM U160 ( .A0(n54), .A1(n42), .B0(N111), .B1(n151), .Y(n72) );
  AO21XLM U161 ( .A0(N109), .A1(n151), .B0(n144), .Y(n71) );
  AO21XLM U162 ( .A0(N108), .A1(n151), .B0(n141), .Y(n78) );
  AOI32XLM U163 ( .A0(n175), .A1(n178), .A2(n166), .B0(n14), .B1(n154), .Y(n96) );
  XNOR2XLM U164 ( .A(n33), .B(n14), .Y(n178) );
  MX2XLM U165 ( .A(n55), .B(n44), .S0(n13), .Y(n60) );
  NAND2XLM U166 ( .A(n13), .B(n11), .Y(n95) );
  BUFX32M U167 ( .A(B[0]), .Y(n26) );
  AOI211XLM U168 ( .A0(N105), .A1(n151), .B0(n122), .C0(n121), .Y(n131) );
  OR4X1M U169 ( .A(B[4]), .B(n27), .C(B[5]), .D(n13), .Y(n41) );
  OAI2BB1X2M U170 ( .A0N(n19), .A1N(n114), .B0(n116), .Y(n47) );
  NAND2X2M U171 ( .A(n106), .B(n18), .Y(n45) );
  NAND2X2M U172 ( .A(n95), .B(n94), .Y(n54) );
  NAND2X2M U173 ( .A(ALU_FUN[1]), .B(n40), .Y(n88) );
  NAND2X2M U174 ( .A(N75), .B(n7), .Y(n65) );
  NAND2X2M U175 ( .A(n116), .B(n45), .Y(n74) );
  NAND2X2M U176 ( .A(n74), .B(n11), .Y(n55) );
  AOI31X2M U177 ( .A0(n72), .A1(n67), .A2(n66), .B0(n191), .Y(ALU_OUT_comb[7])
         );
  NAND2X2M U178 ( .A(n20), .B(n19), .Y(n50) );
  NAND3X2M U179 ( .A(n19), .B(ALU_FUN[3]), .C(n73), .Y(n48) );
  NAND2X2M U180 ( .A(n79), .B(n43), .Y(n86) );
  NAND2X2M U181 ( .A(n80), .B(n44), .Y(n81) );
  NAND2X2M U182 ( .A(N86), .B(n17), .Y(n99) );
  NAND2X2M U183 ( .A(N77), .B(n6), .Y(n108) );
  NAND2X2M U184 ( .A(N68), .B(n7), .Y(n110) );
  NAND2X2M U185 ( .A(n28), .B(n190), .Y(n107) );
  NAND2X2M U186 ( .A(n115), .B(n43), .Y(n119) );
  NAND2X2M U187 ( .A(n117), .B(n44), .Y(n118) );
  NAND2X2M U188 ( .A(N69), .B(n7), .Y(n127) );
  AOI31X2M U189 ( .A0(n131), .A1(n130), .A2(n129), .B0(n191), .Y(
        ALU_OUT_comb[1]) );
  NAND2X2M U190 ( .A(n132), .B(n43), .Y(n135) );
  NAND2X2M U191 ( .A(n133), .B(n44), .Y(n134) );
  NAND2X2M U192 ( .A(n146), .B(n43), .Y(n150) );
  NAND2X2M U193 ( .A(n148), .B(n44), .Y(n149) );
  NAND2BX1M U194 ( .AN(B[4]), .B(n31), .Y(n174) );
  NAND2BX1M U195 ( .AN(n31), .B(B[4]), .Y(n164) );
  CLKNAND2X2M U196 ( .A(n174), .B(n164), .Y(n176) );
  NOR2X1M U197 ( .A(n157), .B(n30), .Y(n171) );
  NOR2X1M U198 ( .A(n158), .B(n29), .Y(n163) );
  CLKNAND2X2M U199 ( .A(n29), .B(n158), .Y(n173) );
  NAND2BX1M U200 ( .AN(n163), .B(n173), .Y(n168) );
  AOI211X1M U201 ( .A0(n28), .A1(n182), .B0(n168), .C0(n161), .Y(n162) );
  CLKNAND2X2M U202 ( .A(n30), .B(n157), .Y(n172) );
  OAI31X1M U203 ( .A0(n171), .A1(n163), .A2(n162), .B0(n172), .Y(n165) );
  NAND2BX1M U204 ( .AN(n5), .B(B[5]), .Y(n179) );
  OAI211X1M U205 ( .A0(n176), .A1(n165), .B0(n164), .C0(n179), .Y(n166) );
  NAND2BX1M U206 ( .AN(B[5]), .B(n4), .Y(n175) );
  OA21X1M U207 ( .A0(n169), .A1(n155), .B0(n27), .Y(n167) );
  AOI211X1M U208 ( .A0(n169), .A1(n155), .B0(n168), .C0(n167), .Y(n170) );
  AOI31X1M U209 ( .A0(n183), .A1(n173), .A2(n172), .B0(n171), .Y(n177) );
  OAI2B11X1M U210 ( .A1N(n177), .A0(n176), .B0(n175), .C0(n174), .Y(n180) );
endmodule


module FIFO_RD ( rinc, rclk, rrst_n, rq2_wptr, rempty, raddr, rptr_gray );
  input [3:0] rq2_wptr;
  output [2:0] raddr;
  output [3:0] rptr_gray;
  input rinc, rclk, rrst_n;
  output rempty;
  wire   \rcounter[3] , N9, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n1, n2, n3;

  DFFSQX2M rempty_reg_reg ( .D(N9), .CK(rclk), .SN(n2), .Q(rempty) );
  DFFRQX1M \rptr_gray_reg_reg[0]  ( .D(n32), .CK(rclk), .RN(n2), .Q(
        rptr_gray[0]) );
  DFFRQX1M \rptr_gray_reg_reg[3]  ( .D(n27), .CK(rclk), .RN(n2), .Q(
        rptr_gray[3]) );
  DFFRQX1M \rptr_gray_reg_reg[2]  ( .D(n26), .CK(rclk), .RN(n2), .Q(
        rptr_gray[2]) );
  DFFRQX1M \rptr_gray_reg_reg[1]  ( .D(n25), .CK(rclk), .RN(n2), .Q(
        rptr_gray[1]) );
  DFFRQX1M \rcounter_reg[3]  ( .D(n28), .CK(rclk), .RN(n2), .Q(\rcounter[3] )
         );
  DFFRQX1M \rcounter_reg[0]  ( .D(n31), .CK(rclk), .RN(n2), .Q(raddr[0]) );
  DFFRQX1M \rcounter_reg[2]  ( .D(n29), .CK(rclk), .RN(n2), .Q(raddr[2]) );
  DFFRQX1M \rcounter_reg[1]  ( .D(n30), .CK(rclk), .RN(n2), .Q(raddr[1]) );
  INVX2M U3 ( .A(n3), .Y(n2) );
  INVX2M U4 ( .A(rrst_n), .Y(n3) );
  XNOR2X2M U5 ( .A(n10), .B(n11), .Y(n6) );
  XNOR2X2M U6 ( .A(n9), .B(n10), .Y(n8) );
  BUFX2M U7 ( .A(n7), .Y(n1) );
  CLKXOR2X2M U8 ( .A(n21), .B(raddr[2]), .Y(n10) );
  XNOR2X2M U9 ( .A(raddr[1]), .B(raddr[0]), .Y(n11) );
  OAI31X1M U10 ( .A0(n14), .A1(n15), .A2(n16), .B0(n13), .Y(N9) );
  NAND3X2M U11 ( .A(rinc), .B(n22), .C(n23), .Y(n14) );
  XNOR2X2M U12 ( .A(rq2_wptr[1]), .B(n6), .Y(n16) );
  XNOR2X2M U13 ( .A(rq2_wptr[2]), .B(n8), .Y(n15) );
  XNOR2X2M U14 ( .A(n11), .B(raddr[0]), .Y(n12) );
  CLKXOR2X2M U15 ( .A(rq2_wptr[0]), .B(n12), .Y(n22) );
  CLKXOR2X2M U16 ( .A(n9), .B(rq2_wptr[3]), .Y(n23) );
  NAND2X2M U17 ( .A(raddr[0]), .B(raddr[1]), .Y(n21) );
  XNOR2X2M U18 ( .A(\rcounter[3] ), .B(n24), .Y(n9) );
  NOR2BX2M U19 ( .AN(raddr[2]), .B(n21), .Y(n24) );
  OAI2BB2X1M U20 ( .B0(n9), .B1(n7), .A0N(n1), .A1N(\rcounter[3] ), .Y(n28) );
  OAI2BB2X1M U21 ( .B0(n9), .B1(n7), .A0N(n1), .A1N(rptr_gray[3]), .Y(n27) );
  OAI2BB2X1M U22 ( .B0(n8), .B1(n7), .A0N(n1), .A1N(rptr_gray[2]), .Y(n26) );
  OAI2BB2X1M U23 ( .B0(n6), .B1(n7), .A0N(n1), .A1N(rptr_gray[1]), .Y(n25) );
  NAND4X2M U24 ( .A(n17), .B(n18), .C(n19), .D(n20), .Y(n13) );
  XNOR2X2M U25 ( .A(rptr_gray[3]), .B(rq2_wptr[3]), .Y(n19) );
  XNOR2X2M U26 ( .A(rptr_gray[2]), .B(rq2_wptr[2]), .Y(n20) );
  XNOR2X2M U27 ( .A(rptr_gray[1]), .B(rq2_wptr[1]), .Y(n18) );
  XNOR2X2M U28 ( .A(rptr_gray[0]), .B(rq2_wptr[0]), .Y(n17) );
  XNOR2X2M U29 ( .A(raddr[0]), .B(n1), .Y(n31) );
  OAI2BB2X1M U30 ( .B0(n11), .B1(n7), .A0N(n1), .A1N(raddr[1]), .Y(n30) );
  OAI2BB2X1M U31 ( .B0(n10), .B1(n7), .A0N(n1), .A1N(raddr[2]), .Y(n29) );
  OAI2BB2X1M U32 ( .B0(n1), .B1(n12), .A0N(n1), .A1N(rptr_gray[0]), .Y(n32) );
  NAND2X2M U33 ( .A(rinc), .B(n13), .Y(n7) );
endmodule


module FIFO_WR ( winc, wrst_n, wclk, wq2_rptr, waddr, wptr_gray, wfull );
  input [3:0] wq2_rptr;
  output [2:0] waddr;
  output [3:0] wptr_gray;
  input winc, wrst_n, wclk;
  output wfull;
  wire   \wcounter[3] , N11, n3, n4, n5, n6, n7, n8, n9, n10, n1, n2;
  wire   [3:0] wcounter_next;
  wire   [2:0] wcounter_gray_next;

  DFFRQX2M \wcounter_reg[3]  ( .D(wcounter_next[3]), .CK(wclk), .RN(n1), .Q(
        \wcounter[3] ) );
  DFFRQX2M \wcounter_reg[2]  ( .D(wcounter_next[2]), .CK(wclk), .RN(n1), .Q(
        waddr[2]) );
  DFFRQX2M wfull_reg_reg ( .D(N11), .CK(wclk), .RN(n1), .Q(wfull) );
  DFFRQX2M \wptr_gray_reg_reg[3]  ( .D(wcounter_next[3]), .CK(wclk), .RN(n1), 
        .Q(wptr_gray[3]) );
  DFFRQX2M \wcounter_reg[1]  ( .D(wcounter_next[1]), .CK(wclk), .RN(n1), .Q(
        waddr[1]) );
  DFFRQX2M \wcounter_reg[0]  ( .D(wcounter_next[0]), .CK(wclk), .RN(n1), .Q(
        waddr[0]) );
  DFFRQX2M \wptr_gray_reg_reg[2]  ( .D(wcounter_gray_next[2]), .CK(wclk), .RN(
        n1), .Q(wptr_gray[2]) );
  DFFRQX2M \wptr_gray_reg_reg[1]  ( .D(wcounter_gray_next[1]), .CK(wclk), .RN(
        n1), .Q(wptr_gray[1]) );
  DFFRQX2M \wptr_gray_reg_reg[0]  ( .D(wcounter_gray_next[0]), .CK(wclk), .RN(
        n1), .Q(wptr_gray[0]) );
  INVX2M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(wrst_n), .Y(n2) );
  CLKXOR2X2M U5 ( .A(wcounter_next[2]), .B(wcounter_next[1]), .Y(
        wcounter_gray_next[1]) );
  CLKXOR2X2M U6 ( .A(wcounter_next[1]), .B(wcounter_next[0]), .Y(
        wcounter_gray_next[0]) );
  CLKXOR2X2M U7 ( .A(wcounter_next[3]), .B(wcounter_next[2]), .Y(
        wcounter_gray_next[2]) );
  CLKXOR2X2M U8 ( .A(n9), .B(waddr[2]), .Y(wcounter_next[2]) );
  XNOR2X2M U9 ( .A(n8), .B(waddr[1]), .Y(wcounter_next[1]) );
  CLKXOR2X2M U10 ( .A(n7), .B(waddr[0]), .Y(wcounter_next[0]) );
  XNOR2X2M U11 ( .A(wcounter_gray_next[2]), .B(wq2_rptr[2]), .Y(n4) );
  NAND2X2M U12 ( .A(waddr[0]), .B(n7), .Y(n8) );
  NOR2BX2M U13 ( .AN(winc), .B(wfull), .Y(n7) );
  NOR2BX2M U14 ( .AN(waddr[1]), .B(n8), .Y(n9) );
  NOR4X1M U15 ( .A(n3), .B(n4), .C(n5), .D(n6), .Y(N11) );
  CLKXOR2X2M U16 ( .A(wq2_rptr[0]), .B(wcounter_gray_next[0]), .Y(n5) );
  XNOR2X2M U17 ( .A(wcounter_next[3]), .B(wq2_rptr[3]), .Y(n3) );
  CLKXOR2X2M U18 ( .A(wq2_rptr[1]), .B(wcounter_gray_next[1]), .Y(n6) );
  XNOR2X2M U19 ( .A(n10), .B(\wcounter[3] ), .Y(wcounter_next[3]) );
  NAND2X2M U20 ( .A(waddr[2]), .B(n9), .Y(n10) );
endmodule


module FIFO_MEM_CNTRL ( wclken, wclk, wrst_n, wdata, waddr, raddr, rdata );
  input [7:0] wdata;
  input [2:0] waddr;
  input [2:0] raddr;
  output [7:0] rdata;
  input wclken, wclk, wrst_n;
  wire   N10, N11, N12, \fifo_mem[7][7] , \fifo_mem[7][6] , \fifo_mem[7][5] ,
         \fifo_mem[7][4] , \fifo_mem[7][3] , \fifo_mem[7][2] ,
         \fifo_mem[7][1] , \fifo_mem[7][0] , \fifo_mem[6][7] ,
         \fifo_mem[6][6] , \fifo_mem[6][5] , \fifo_mem[6][4] ,
         \fifo_mem[6][3] , \fifo_mem[6][2] , \fifo_mem[6][1] ,
         \fifo_mem[6][0] , \fifo_mem[5][7] , \fifo_mem[5][6] ,
         \fifo_mem[5][5] , \fifo_mem[5][4] , \fifo_mem[5][3] ,
         \fifo_mem[5][2] , \fifo_mem[5][1] , \fifo_mem[5][0] ,
         \fifo_mem[4][7] , \fifo_mem[4][6] , \fifo_mem[4][5] ,
         \fifo_mem[4][4] , \fifo_mem[4][3] , \fifo_mem[4][2] ,
         \fifo_mem[4][1] , \fifo_mem[4][0] , \fifo_mem[3][7] ,
         \fifo_mem[3][6] , \fifo_mem[3][5] , \fifo_mem[3][4] ,
         \fifo_mem[3][3] , \fifo_mem[3][2] , \fifo_mem[3][1] ,
         \fifo_mem[3][0] , \fifo_mem[2][7] , \fifo_mem[2][6] ,
         \fifo_mem[2][5] , \fifo_mem[2][4] , \fifo_mem[2][3] ,
         \fifo_mem[2][2] , \fifo_mem[2][1] , \fifo_mem[2][0] ,
         \fifo_mem[1][7] , \fifo_mem[1][6] , \fifo_mem[1][5] ,
         \fifo_mem[1][4] , \fifo_mem[1][3] , \fifo_mem[1][2] ,
         \fifo_mem[1][1] , \fifo_mem[1][0] , \fifo_mem[0][7] ,
         \fifo_mem[0][6] , \fifo_mem[0][5] , \fifo_mem[0][4] ,
         \fifo_mem[0][3] , \fifo_mem[0][2] , \fifo_mem[0][1] ,
         \fifo_mem[0][0] , n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142;
  assign N10 = raddr[0];
  assign N11 = raddr[1];
  assign N12 = raddr[2];

  DFFRQX2M \fifo_mem_reg[1][7]  ( .D(n36), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[1][7] ) );
  DFFRQX2M \fifo_mem_reg[1][6]  ( .D(n35), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[1][6] ) );
  DFFRQX2M \fifo_mem_reg[1][5]  ( .D(n34), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[1][5] ) );
  DFFRQX2M \fifo_mem_reg[1][4]  ( .D(n33), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[1][4] ) );
  DFFRQX2M \fifo_mem_reg[1][3]  ( .D(n32), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[1][3] ) );
  DFFRQX2M \fifo_mem_reg[1][2]  ( .D(n31), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[1][2] ) );
  DFFRQX2M \fifo_mem_reg[1][1]  ( .D(n30), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[1][1] ) );
  DFFRQX2M \fifo_mem_reg[1][0]  ( .D(n29), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[1][0] ) );
  DFFRQX2M \fifo_mem_reg[0][7]  ( .D(n28), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[0][7] ) );
  DFFRQX2M \fifo_mem_reg[0][6]  ( .D(n27), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[0][6] ) );
  DFFRQX2M \fifo_mem_reg[0][5]  ( .D(n26), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[0][5] ) );
  DFFRQX2M \fifo_mem_reg[0][4]  ( .D(n25), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[0][4] ) );
  DFFRQX2M \fifo_mem_reg[0][3]  ( .D(n24), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[0][3] ) );
  DFFRQX2M \fifo_mem_reg[0][2]  ( .D(n23), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[0][2] ) );
  DFFRQX2M \fifo_mem_reg[0][1]  ( .D(n22), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[0][1] ) );
  DFFRQX2M \fifo_mem_reg[0][0]  ( .D(n21), .CK(wclk), .RN(n127), .Q(
        \fifo_mem[0][0] ) );
  DFFRQX2M \fifo_mem_reg[5][7]  ( .D(n68), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][7] ) );
  DFFRQX2M \fifo_mem_reg[5][6]  ( .D(n67), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][6] ) );
  DFFRQX2M \fifo_mem_reg[5][5]  ( .D(n66), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][5] ) );
  DFFRQX2M \fifo_mem_reg[5][4]  ( .D(n65), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][4] ) );
  DFFRQX2M \fifo_mem_reg[5][3]  ( .D(n64), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][3] ) );
  DFFRQX2M \fifo_mem_reg[5][2]  ( .D(n63), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][2] ) );
  DFFRQX2M \fifo_mem_reg[5][1]  ( .D(n62), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][1] ) );
  DFFRQX2M \fifo_mem_reg[5][0]  ( .D(n61), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[5][0] ) );
  DFFRQX2M \fifo_mem_reg[4][7]  ( .D(n60), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][7] ) );
  DFFRQX2M \fifo_mem_reg[4][6]  ( .D(n59), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][6] ) );
  DFFRQX2M \fifo_mem_reg[4][5]  ( .D(n58), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][5] ) );
  DFFRQX2M \fifo_mem_reg[4][4]  ( .D(n57), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][4] ) );
  DFFRQX2M \fifo_mem_reg[4][3]  ( .D(n56), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][3] ) );
  DFFRQX2M \fifo_mem_reg[4][2]  ( .D(n55), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][2] ) );
  DFFRQX2M \fifo_mem_reg[4][1]  ( .D(n54), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][1] ) );
  DFFRQX2M \fifo_mem_reg[4][0]  ( .D(n53), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[4][0] ) );
  DFFRQX2M \fifo_mem_reg[7][7]  ( .D(n84), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][7] ) );
  DFFRQX2M \fifo_mem_reg[7][6]  ( .D(n83), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][6] ) );
  DFFRQX2M \fifo_mem_reg[7][5]  ( .D(n82), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][5] ) );
  DFFRQX2M \fifo_mem_reg[7][4]  ( .D(n81), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][4] ) );
  DFFRQX2M \fifo_mem_reg[7][3]  ( .D(n80), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][3] ) );
  DFFRQX2M \fifo_mem_reg[7][2]  ( .D(n79), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][2] ) );
  DFFRQX2M \fifo_mem_reg[7][1]  ( .D(n78), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][1] ) );
  DFFRQX2M \fifo_mem_reg[7][0]  ( .D(n77), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[7][0] ) );
  DFFRQX2M \fifo_mem_reg[6][7]  ( .D(n76), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[6][7] ) );
  DFFRQX2M \fifo_mem_reg[6][6]  ( .D(n75), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[6][6] ) );
  DFFRQX2M \fifo_mem_reg[6][5]  ( .D(n74), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[6][5] ) );
  DFFRQX2M \fifo_mem_reg[6][4]  ( .D(n73), .CK(wclk), .RN(n129), .Q(
        \fifo_mem[6][4] ) );
  DFFRQX2M \fifo_mem_reg[6][3]  ( .D(n72), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[6][3] ) );
  DFFRQX2M \fifo_mem_reg[6][2]  ( .D(n71), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[6][2] ) );
  DFFRQX2M \fifo_mem_reg[6][1]  ( .D(n70), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[6][1] ) );
  DFFRQX2M \fifo_mem_reg[6][0]  ( .D(n69), .CK(wclk), .RN(n130), .Q(
        \fifo_mem[6][0] ) );
  DFFRQX2M \fifo_mem_reg[3][7]  ( .D(n52), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[3][7] ) );
  DFFRQX2M \fifo_mem_reg[3][6]  ( .D(n51), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[3][6] ) );
  DFFRQX2M \fifo_mem_reg[3][5]  ( .D(n50), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[3][5] ) );
  DFFRQX2M \fifo_mem_reg[3][4]  ( .D(n49), .CK(wclk), .RN(n131), .Q(
        \fifo_mem[3][4] ) );
  DFFRQX2M \fifo_mem_reg[3][3]  ( .D(n48), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[3][3] ) );
  DFFRQX2M \fifo_mem_reg[3][2]  ( .D(n47), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[3][2] ) );
  DFFRQX2M \fifo_mem_reg[3][1]  ( .D(n46), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[3][1] ) );
  DFFRQX2M \fifo_mem_reg[3][0]  ( .D(n45), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[3][0] ) );
  DFFRQX2M \fifo_mem_reg[2][7]  ( .D(n44), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][7] ) );
  DFFRQX2M \fifo_mem_reg[2][6]  ( .D(n43), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][6] ) );
  DFFRQX2M \fifo_mem_reg[2][5]  ( .D(n42), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][5] ) );
  DFFRQX2M \fifo_mem_reg[2][4]  ( .D(n41), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][4] ) );
  DFFRQX2M \fifo_mem_reg[2][3]  ( .D(n40), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][3] ) );
  DFFRQX2M \fifo_mem_reg[2][2]  ( .D(n39), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][2] ) );
  DFFRQX2M \fifo_mem_reg[2][1]  ( .D(n38), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][1] ) );
  DFFRQX2M \fifo_mem_reg[2][0]  ( .D(n37), .CK(wclk), .RN(n132), .Q(
        \fifo_mem[2][0] ) );
  BUFX4M U2 ( .A(n13), .Y(n125) );
  BUFX4M U3 ( .A(n14), .Y(n124) );
  BUFX4M U4 ( .A(n15), .Y(n123) );
  BUFX4M U5 ( .A(n19), .Y(n120) );
  BUFX4M U6 ( .A(n20), .Y(n119) );
  BUFX4M U7 ( .A(n18), .Y(n121) );
  INVX2M U8 ( .A(wdata[1]), .Y(n136) );
  INVX2M U9 ( .A(wdata[0]), .Y(n135) );
  INVX2M U10 ( .A(wdata[2]), .Y(n137) );
  INVX2M U11 ( .A(wdata[3]), .Y(n138) );
  INVX2M U12 ( .A(wdata[4]), .Y(n139) );
  INVX2M U13 ( .A(wdata[5]), .Y(n140) );
  INVX2M U14 ( .A(wdata[6]), .Y(n141) );
  INVX2M U15 ( .A(wdata[7]), .Y(n142) );
  BUFX4M U16 ( .A(n127), .Y(n132) );
  BUFX4M U17 ( .A(wrst_n), .Y(n131) );
  BUFX4M U18 ( .A(n127), .Y(n130) );
  BUFX4M U19 ( .A(n127), .Y(n129) );
  BUFX2M U20 ( .A(n16), .Y(n122) );
  BUFX2M U21 ( .A(n11), .Y(n126) );
  INVX2M U22 ( .A(n128), .Y(n127) );
  INVX2M U23 ( .A(wrst_n), .Y(n128) );
  NAND3X2M U24 ( .A(n133), .B(n134), .C(n12), .Y(n11) );
  NAND3X2M U25 ( .A(n133), .B(n134), .C(n17), .Y(n16) );
  BUFX4M U26 ( .A(n107), .Y(n116) );
  NOR2X2M U27 ( .A(n111), .B(n112), .Y(n107) );
  INVX2M U28 ( .A(n114), .Y(n113) );
  NOR2BX2M U29 ( .AN(wclken), .B(waddr[2]), .Y(n12) );
  OAI2BB2X1M U30 ( .B0(n136), .B1(n125), .A0N(\fifo_mem[1][1] ), .A1N(n125), 
        .Y(n30) );
  OAI2BB2X1M U31 ( .B0(n136), .B1(n124), .A0N(\fifo_mem[2][1] ), .A1N(n124), 
        .Y(n38) );
  OAI2BB2X1M U32 ( .B0(n136), .B1(n123), .A0N(\fifo_mem[3][1] ), .A1N(n123), 
        .Y(n46) );
  OAI2BB2X1M U33 ( .B0(n136), .B1(n122), .A0N(\fifo_mem[4][1] ), .A1N(n122), 
        .Y(n54) );
  OAI2BB2X1M U34 ( .B0(n136), .B1(n121), .A0N(\fifo_mem[5][1] ), .A1N(n121), 
        .Y(n62) );
  OAI2BB2X1M U35 ( .B0(n136), .B1(n120), .A0N(\fifo_mem[6][1] ), .A1N(n120), 
        .Y(n70) );
  OAI2BB2X1M U36 ( .B0(n136), .B1(n119), .A0N(\fifo_mem[7][1] ), .A1N(n119), 
        .Y(n78) );
  OAI2BB2X1M U37 ( .B0(n135), .B1(n125), .A0N(\fifo_mem[1][0] ), .A1N(n125), 
        .Y(n29) );
  OAI2BB2X1M U38 ( .B0(n137), .B1(n125), .A0N(\fifo_mem[1][2] ), .A1N(n125), 
        .Y(n31) );
  OAI2BB2X1M U39 ( .B0(n138), .B1(n125), .A0N(\fifo_mem[1][3] ), .A1N(n125), 
        .Y(n32) );
  OAI2BB2X1M U40 ( .B0(n139), .B1(n125), .A0N(\fifo_mem[1][4] ), .A1N(n125), 
        .Y(n33) );
  OAI2BB2X1M U41 ( .B0(n140), .B1(n125), .A0N(\fifo_mem[1][5] ), .A1N(n125), 
        .Y(n34) );
  OAI2BB2X1M U42 ( .B0(n141), .B1(n125), .A0N(\fifo_mem[1][6] ), .A1N(n125), 
        .Y(n35) );
  OAI2BB2X1M U43 ( .B0(n142), .B1(n125), .A0N(\fifo_mem[1][7] ), .A1N(n125), 
        .Y(n36) );
  OAI2BB2X1M U44 ( .B0(n135), .B1(n124), .A0N(\fifo_mem[2][0] ), .A1N(n124), 
        .Y(n37) );
  OAI2BB2X1M U45 ( .B0(n137), .B1(n124), .A0N(\fifo_mem[2][2] ), .A1N(n124), 
        .Y(n39) );
  OAI2BB2X1M U46 ( .B0(n138), .B1(n124), .A0N(\fifo_mem[2][3] ), .A1N(n124), 
        .Y(n40) );
  OAI2BB2X1M U47 ( .B0(n139), .B1(n124), .A0N(\fifo_mem[2][4] ), .A1N(n124), 
        .Y(n41) );
  OAI2BB2X1M U48 ( .B0(n140), .B1(n124), .A0N(\fifo_mem[2][5] ), .A1N(n124), 
        .Y(n42) );
  OAI2BB2X1M U49 ( .B0(n141), .B1(n124), .A0N(\fifo_mem[2][6] ), .A1N(n124), 
        .Y(n43) );
  OAI2BB2X1M U50 ( .B0(n142), .B1(n124), .A0N(\fifo_mem[2][7] ), .A1N(n124), 
        .Y(n44) );
  OAI2BB2X1M U51 ( .B0(n135), .B1(n123), .A0N(\fifo_mem[3][0] ), .A1N(n123), 
        .Y(n45) );
  OAI2BB2X1M U52 ( .B0(n137), .B1(n123), .A0N(\fifo_mem[3][2] ), .A1N(n123), 
        .Y(n47) );
  OAI2BB2X1M U53 ( .B0(n138), .B1(n123), .A0N(\fifo_mem[3][3] ), .A1N(n123), 
        .Y(n48) );
  OAI2BB2X1M U54 ( .B0(n139), .B1(n123), .A0N(\fifo_mem[3][4] ), .A1N(n123), 
        .Y(n49) );
  OAI2BB2X1M U55 ( .B0(n140), .B1(n123), .A0N(\fifo_mem[3][5] ), .A1N(n123), 
        .Y(n50) );
  OAI2BB2X1M U56 ( .B0(n141), .B1(n123), .A0N(\fifo_mem[3][6] ), .A1N(n123), 
        .Y(n51) );
  OAI2BB2X1M U57 ( .B0(n142), .B1(n123), .A0N(\fifo_mem[3][7] ), .A1N(n123), 
        .Y(n52) );
  OAI2BB2X1M U58 ( .B0(n135), .B1(n122), .A0N(\fifo_mem[4][0] ), .A1N(n122), 
        .Y(n53) );
  OAI2BB2X1M U59 ( .B0(n137), .B1(n122), .A0N(\fifo_mem[4][2] ), .A1N(n122), 
        .Y(n55) );
  OAI2BB2X1M U60 ( .B0(n138), .B1(n16), .A0N(\fifo_mem[4][3] ), .A1N(n122), 
        .Y(n56) );
  OAI2BB2X1M U61 ( .B0(n139), .B1(n16), .A0N(\fifo_mem[4][4] ), .A1N(n122), 
        .Y(n57) );
  OAI2BB2X1M U62 ( .B0(n140), .B1(n16), .A0N(\fifo_mem[4][5] ), .A1N(n122), 
        .Y(n58) );
  OAI2BB2X1M U63 ( .B0(n141), .B1(n16), .A0N(\fifo_mem[4][6] ), .A1N(n122), 
        .Y(n59) );
  OAI2BB2X1M U64 ( .B0(n142), .B1(n16), .A0N(\fifo_mem[4][7] ), .A1N(n122), 
        .Y(n60) );
  OAI2BB2X1M U65 ( .B0(n135), .B1(n121), .A0N(\fifo_mem[5][0] ), .A1N(n121), 
        .Y(n61) );
  OAI2BB2X1M U66 ( .B0(n137), .B1(n121), .A0N(\fifo_mem[5][2] ), .A1N(n121), 
        .Y(n63) );
  OAI2BB2X1M U67 ( .B0(n138), .B1(n121), .A0N(\fifo_mem[5][3] ), .A1N(n121), 
        .Y(n64) );
  OAI2BB2X1M U68 ( .B0(n139), .B1(n121), .A0N(\fifo_mem[5][4] ), .A1N(n121), 
        .Y(n65) );
  OAI2BB2X1M U69 ( .B0(n140), .B1(n121), .A0N(\fifo_mem[5][5] ), .A1N(n121), 
        .Y(n66) );
  OAI2BB2X1M U70 ( .B0(n141), .B1(n121), .A0N(\fifo_mem[5][6] ), .A1N(n121), 
        .Y(n67) );
  OAI2BB2X1M U71 ( .B0(n142), .B1(n121), .A0N(\fifo_mem[5][7] ), .A1N(n121), 
        .Y(n68) );
  OAI2BB2X1M U72 ( .B0(n135), .B1(n120), .A0N(\fifo_mem[6][0] ), .A1N(n120), 
        .Y(n69) );
  OAI2BB2X1M U73 ( .B0(n137), .B1(n120), .A0N(\fifo_mem[6][2] ), .A1N(n120), 
        .Y(n71) );
  OAI2BB2X1M U74 ( .B0(n138), .B1(n120), .A0N(\fifo_mem[6][3] ), .A1N(n120), 
        .Y(n72) );
  OAI2BB2X1M U75 ( .B0(n139), .B1(n120), .A0N(\fifo_mem[6][4] ), .A1N(n120), 
        .Y(n73) );
  OAI2BB2X1M U76 ( .B0(n140), .B1(n120), .A0N(\fifo_mem[6][5] ), .A1N(n120), 
        .Y(n74) );
  OAI2BB2X1M U77 ( .B0(n141), .B1(n120), .A0N(\fifo_mem[6][6] ), .A1N(n120), 
        .Y(n75) );
  OAI2BB2X1M U78 ( .B0(n142), .B1(n120), .A0N(\fifo_mem[6][7] ), .A1N(n120), 
        .Y(n76) );
  OAI2BB2X1M U79 ( .B0(n135), .B1(n119), .A0N(\fifo_mem[7][0] ), .A1N(n119), 
        .Y(n77) );
  OAI2BB2X1M U80 ( .B0(n137), .B1(n119), .A0N(\fifo_mem[7][2] ), .A1N(n119), 
        .Y(n79) );
  OAI2BB2X1M U81 ( .B0(n138), .B1(n119), .A0N(\fifo_mem[7][3] ), .A1N(n119), 
        .Y(n80) );
  OAI2BB2X1M U82 ( .B0(n139), .B1(n119), .A0N(\fifo_mem[7][4] ), .A1N(n119), 
        .Y(n81) );
  OAI2BB2X1M U83 ( .B0(n140), .B1(n119), .A0N(\fifo_mem[7][5] ), .A1N(n119), 
        .Y(n82) );
  OAI2BB2X1M U84 ( .B0(n141), .B1(n119), .A0N(\fifo_mem[7][6] ), .A1N(n119), 
        .Y(n83) );
  OAI2BB2X1M U85 ( .B0(n142), .B1(n119), .A0N(\fifo_mem[7][7] ), .A1N(n119), 
        .Y(n84) );
  NAND3X2M U86 ( .A(waddr[0]), .B(n12), .C(waddr[1]), .Y(n15) );
  NAND3X2M U87 ( .A(waddr[1]), .B(waddr[0]), .C(n17), .Y(n20) );
  NAND3X2M U88 ( .A(waddr[0]), .B(n134), .C(n17), .Y(n18) );
  NAND3X2M U89 ( .A(waddr[1]), .B(n133), .C(n17), .Y(n19) );
  OAI2BB2X1M U90 ( .B0(n126), .B1(n136), .A0N(\fifo_mem[0][1] ), .A1N(n126), 
        .Y(n22) );
  OAI2BB2X1M U91 ( .B0(n126), .B1(n135), .A0N(\fifo_mem[0][0] ), .A1N(n126), 
        .Y(n21) );
  OAI2BB2X1M U92 ( .B0(n126), .B1(n137), .A0N(\fifo_mem[0][2] ), .A1N(n126), 
        .Y(n23) );
  OAI2BB2X1M U93 ( .B0(n126), .B1(n138), .A0N(\fifo_mem[0][3] ), .A1N(n126), 
        .Y(n24) );
  OAI2BB2X1M U94 ( .B0(n11), .B1(n139), .A0N(\fifo_mem[0][4] ), .A1N(n126), 
        .Y(n25) );
  OAI2BB2X1M U95 ( .B0(n11), .B1(n140), .A0N(\fifo_mem[0][5] ), .A1N(n126), 
        .Y(n26) );
  OAI2BB2X1M U96 ( .B0(n11), .B1(n141), .A0N(\fifo_mem[0][6] ), .A1N(n126), 
        .Y(n27) );
  OAI2BB2X1M U97 ( .B0(n11), .B1(n142), .A0N(\fifo_mem[0][7] ), .A1N(n126), 
        .Y(n28) );
  NAND3X2M U98 ( .A(n12), .B(n134), .C(waddr[0]), .Y(n13) );
  NAND3X2M U99 ( .A(n12), .B(n133), .C(waddr[1]), .Y(n14) );
  AND2X2M U100 ( .A(waddr[2]), .B(wclken), .Y(n17) );
  INVX2M U101 ( .A(waddr[0]), .Y(n133) );
  INVX2M U102 ( .A(waddr[1]), .Y(n134) );
  INVX2M U103 ( .A(N12), .Y(n111) );
  INVX2M U104 ( .A(N11), .Y(n112) );
  BUFX4M U105 ( .A(n105), .Y(n117) );
  NOR2X2M U106 ( .A(n112), .B(N12), .Y(n105) );
  BUFX4M U107 ( .A(n108), .Y(n115) );
  NOR2X2M U108 ( .A(n111), .B(N11), .Y(n108) );
  BUFX4M U109 ( .A(n104), .Y(n118) );
  NOR2X2M U110 ( .A(N11), .B(N12), .Y(n104) );
  BUFX2M U111 ( .A(N10), .Y(n114) );
  AO22X1M U112 ( .A0(\fifo_mem[3][0] ), .A1(n117), .B0(\fifo_mem[1][0] ), .B1(
        n118), .Y(n1) );
  AOI221XLM U113 ( .A0(\fifo_mem[5][0] ), .A1(n115), .B0(\fifo_mem[7][0] ), 
        .B1(n116), .C0(n1), .Y(n4) );
  AO22X1M U114 ( .A0(\fifo_mem[2][0] ), .A1(n117), .B0(\fifo_mem[0][0] ), .B1(
        n118), .Y(n2) );
  AOI221XLM U115 ( .A0(\fifo_mem[4][0] ), .A1(n115), .B0(\fifo_mem[6][0] ), 
        .B1(n116), .C0(n2), .Y(n3) );
  OAI22X1M U116 ( .A0(n113), .A1(n4), .B0(n114), .B1(n3), .Y(rdata[0]) );
  AO22X1M U117 ( .A0(\fifo_mem[3][1] ), .A1(n117), .B0(\fifo_mem[1][1] ), .B1(
        n118), .Y(n5) );
  AOI221XLM U118 ( .A0(\fifo_mem[5][1] ), .A1(n115), .B0(\fifo_mem[7][1] ), 
        .B1(n116), .C0(n5), .Y(n8) );
  AO22X1M U119 ( .A0(\fifo_mem[2][1] ), .A1(n117), .B0(\fifo_mem[0][1] ), .B1(
        n118), .Y(n6) );
  AOI221XLM U120 ( .A0(\fifo_mem[4][1] ), .A1(n115), .B0(\fifo_mem[6][1] ), 
        .B1(n116), .C0(n6), .Y(n7) );
  OAI22X1M U121 ( .A0(n113), .A1(n8), .B0(n114), .B1(n7), .Y(rdata[1]) );
  AO22X1M U122 ( .A0(\fifo_mem[3][2] ), .A1(n117), .B0(\fifo_mem[1][2] ), .B1(
        n118), .Y(n9) );
  AOI221XLM U123 ( .A0(\fifo_mem[5][2] ), .A1(n115), .B0(\fifo_mem[7][2] ), 
        .B1(n116), .C0(n9), .Y(n86) );
  AO22X1M U124 ( .A0(\fifo_mem[2][2] ), .A1(n117), .B0(\fifo_mem[0][2] ), .B1(
        n118), .Y(n10) );
  AOI221XLM U125 ( .A0(\fifo_mem[4][2] ), .A1(n115), .B0(\fifo_mem[6][2] ), 
        .B1(n116), .C0(n10), .Y(n85) );
  OAI22X1M U126 ( .A0(n113), .A1(n86), .B0(n114), .B1(n85), .Y(rdata[2]) );
  AO22X1M U127 ( .A0(\fifo_mem[3][3] ), .A1(n117), .B0(\fifo_mem[1][3] ), .B1(
        n118), .Y(n87) );
  AOI221XLM U128 ( .A0(\fifo_mem[5][3] ), .A1(n115), .B0(\fifo_mem[7][3] ), 
        .B1(n116), .C0(n87), .Y(n90) );
  AO22X1M U129 ( .A0(\fifo_mem[2][3] ), .A1(n117), .B0(\fifo_mem[0][3] ), .B1(
        n118), .Y(n88) );
  AOI221XLM U130 ( .A0(\fifo_mem[4][3] ), .A1(n115), .B0(\fifo_mem[6][3] ), 
        .B1(n116), .C0(n88), .Y(n89) );
  OAI22X1M U131 ( .A0(n113), .A1(n90), .B0(n114), .B1(n89), .Y(rdata[3]) );
  AO22X1M U132 ( .A0(\fifo_mem[3][4] ), .A1(n117), .B0(\fifo_mem[1][4] ), .B1(
        n118), .Y(n91) );
  AOI221XLM U133 ( .A0(\fifo_mem[5][4] ), .A1(n115), .B0(\fifo_mem[7][4] ), 
        .B1(n116), .C0(n91), .Y(n94) );
  AO22X1M U134 ( .A0(\fifo_mem[2][4] ), .A1(n117), .B0(\fifo_mem[0][4] ), .B1(
        n118), .Y(n92) );
  AOI221XLM U135 ( .A0(\fifo_mem[4][4] ), .A1(n115), .B0(\fifo_mem[6][4] ), 
        .B1(n116), .C0(n92), .Y(n93) );
  OAI22X1M U136 ( .A0(n113), .A1(n94), .B0(n114), .B1(n93), .Y(rdata[4]) );
  AO22X1M U137 ( .A0(\fifo_mem[3][5] ), .A1(n117), .B0(\fifo_mem[1][5] ), .B1(
        n118), .Y(n95) );
  AOI221XLM U138 ( .A0(\fifo_mem[5][5] ), .A1(n115), .B0(\fifo_mem[7][5] ), 
        .B1(n116), .C0(n95), .Y(n98) );
  AO22X1M U139 ( .A0(\fifo_mem[2][5] ), .A1(n117), .B0(\fifo_mem[0][5] ), .B1(
        n118), .Y(n96) );
  AOI221XLM U140 ( .A0(\fifo_mem[4][5] ), .A1(n115), .B0(\fifo_mem[6][5] ), 
        .B1(n116), .C0(n96), .Y(n97) );
  OAI22X1M U141 ( .A0(n113), .A1(n98), .B0(n114), .B1(n97), .Y(rdata[5]) );
  AO22X1M U142 ( .A0(\fifo_mem[3][6] ), .A1(n117), .B0(\fifo_mem[1][6] ), .B1(
        n118), .Y(n99) );
  AOI221XLM U143 ( .A0(\fifo_mem[5][6] ), .A1(n115), .B0(\fifo_mem[7][6] ), 
        .B1(n116), .C0(n99), .Y(n102) );
  AO22X1M U144 ( .A0(\fifo_mem[2][6] ), .A1(n117), .B0(\fifo_mem[0][6] ), .B1(
        n118), .Y(n100) );
  AOI221XLM U145 ( .A0(\fifo_mem[4][6] ), .A1(n115), .B0(\fifo_mem[6][6] ), 
        .B1(n116), .C0(n100), .Y(n101) );
  OAI22X1M U146 ( .A0(n113), .A1(n102), .B0(n114), .B1(n101), .Y(rdata[6]) );
  AO22X1M U147 ( .A0(\fifo_mem[3][7] ), .A1(n117), .B0(\fifo_mem[1][7] ), .B1(
        n118), .Y(n103) );
  AOI221XLM U148 ( .A0(\fifo_mem[5][7] ), .A1(n115), .B0(\fifo_mem[7][7] ), 
        .B1(n116), .C0(n103), .Y(n110) );
  AO22X1M U149 ( .A0(\fifo_mem[2][7] ), .A1(n117), .B0(\fifo_mem[0][7] ), .B1(
        n118), .Y(n106) );
  AOI221XLM U150 ( .A0(\fifo_mem[4][7] ), .A1(n115), .B0(\fifo_mem[6][7] ), 
        .B1(n116), .C0(n106), .Y(n109) );
  OAI22X1M U151 ( .A0(n110), .A1(n113), .B0(n114), .B1(n109), .Y(rdata[7]) );
endmodule


module DF_SYNC_0 ( ptr, clk, rst, sync_out );
  input [3:0] ptr;
  output [3:0] sync_out;
  input clk, rst;

  wire   [3:0] sync_reg;

  DFFRQX1M \sync_out_reg[2]  ( .D(sync_reg[2]), .CK(clk), .RN(rst), .Q(
        sync_out[2]) );
  DFFRQX1M \sync_out_reg[1]  ( .D(sync_reg[1]), .CK(clk), .RN(rst), .Q(
        sync_out[1]) );
  DFFRQX1M \sync_out_reg[0]  ( .D(sync_reg[0]), .CK(clk), .RN(rst), .Q(
        sync_out[0]) );
  DFFRQX1M \sync_out_reg[3]  ( .D(sync_reg[3]), .CK(clk), .RN(rst), .Q(
        sync_out[3]) );
  DFFRQX1M \sync_reg_reg[3]  ( .D(ptr[3]), .CK(clk), .RN(rst), .Q(sync_reg[3])
         );
  DFFRQX1M \sync_reg_reg[2]  ( .D(ptr[2]), .CK(clk), .RN(rst), .Q(sync_reg[2])
         );
  DFFRQX1M \sync_reg_reg[1]  ( .D(ptr[1]), .CK(clk), .RN(rst), .Q(sync_reg[1])
         );
  DFFRQX1M \sync_reg_reg[0]  ( .D(ptr[0]), .CK(clk), .RN(rst), .Q(sync_reg[0])
         );
endmodule


module DF_SYNC_1 ( ptr, clk, rst, sync_out );
  input [3:0] ptr;
  output [3:0] sync_out;
  input clk, rst;
  wire   n1, n2;
  wire   [3:0] sync_reg;

  DFFRQX2M \sync_out_reg[1]  ( .D(sync_reg[1]), .CK(clk), .RN(n1), .Q(
        sync_out[1]) );
  DFFRQX2M \sync_out_reg[0]  ( .D(sync_reg[0]), .CK(clk), .RN(n1), .Q(
        sync_out[0]) );
  DFFRQX2M \sync_out_reg[3]  ( .D(sync_reg[3]), .CK(clk), .RN(n1), .Q(
        sync_out[3]) );
  DFFRQX2M \sync_out_reg[2]  ( .D(sync_reg[2]), .CK(clk), .RN(n1), .Q(
        sync_out[2]) );
  DFFRQX2M \sync_reg_reg[3]  ( .D(ptr[3]), .CK(clk), .RN(n1), .Q(sync_reg[3])
         );
  DFFRQX2M \sync_reg_reg[2]  ( .D(ptr[2]), .CK(clk), .RN(n1), .Q(sync_reg[2])
         );
  DFFRQX2M \sync_reg_reg[1]  ( .D(ptr[1]), .CK(clk), .RN(n1), .Q(sync_reg[1])
         );
  DFFRQX2M \sync_reg_reg[0]  ( .D(ptr[0]), .CK(clk), .RN(n1), .Q(sync_reg[0])
         );
  INVX2M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(rst), .Y(n2) );
endmodule


module ASYNC_FIFO ( wdata, winc, rinc, wclk, rclk, wrst_n, rrst_n, rdata, 
        rempty, wfull );
  input [7:0] wdata;
  output [7:0] rdata;
  input winc, rinc, wclk, rclk, wrst_n, rrst_n;
  output rempty, wfull;
  wire   wclken, n1, n2, n3, n4;
  wire   [2:0] raddr;
  wire   [3:0] rptr_gray;
  wire   [3:0] rq2_wptr;
  wire   [2:0] waddr;
  wire   [3:0] wptr_gray;
  wire   [3:0] wq2_rptr;

  FIFO_RD U0 ( .rinc(rinc), .rclk(rclk), .rrst_n(n3), .rq2_wptr(rq2_wptr), 
        .rempty(rempty), .raddr(raddr), .rptr_gray(rptr_gray) );
  FIFO_WR U1 ( .winc(winc), .wrst_n(n1), .wclk(wclk), .wq2_rptr(wq2_rptr), 
        .waddr(waddr), .wptr_gray(wptr_gray), .wfull(wfull) );
  FIFO_MEM_CNTRL U2 ( .wclken(wclken), .wclk(wclk), .wrst_n(n1), .wdata(wdata), 
        .waddr(waddr), .raddr(raddr), .rdata(rdata) );
  DF_SYNC_0 U3 ( .ptr(wptr_gray), .clk(rclk), .rst(n3), .sync_out(rq2_wptr) );
  DF_SYNC_1 U4 ( .ptr(rptr_gray), .clk(wclk), .rst(n1), .sync_out(wq2_rptr) );
  INVX2M U5 ( .A(n2), .Y(n1) );
  INVX2M U6 ( .A(wrst_n), .Y(n2) );
  INVX2M U7 ( .A(n4), .Y(n3) );
  INVX2M U8 ( .A(rrst_n), .Y(n4) );
  NOR2BX2M U9 ( .AN(winc), .B(wfull), .Y(wclken) );
endmodule


module Pulse_Gen ( clk, rst, async, sync );
  input clk, rst, async;
  output sync;
  wire   sync_d, N1;
  wire   [1:0] sync_reg;

  DFFRQX1M sync_d_reg ( .D(sync_reg[1]), .CK(clk), .RN(rst), .Q(sync_d) );
  DFFRQX1M \sync_reg_reg[1]  ( .D(sync_reg[0]), .CK(clk), .RN(rst), .Q(
        sync_reg[1]) );
  DFFRQX1M sync_reg_inst ( .D(N1), .CK(clk), .RN(rst), .Q(sync) );
  DFFRQX1M \sync_reg_reg[0]  ( .D(async), .CK(clk), .RN(rst), .Q(sync_reg[0])
         );
  NOR2BX2M U3 ( .AN(sync_reg[1]), .B(sync_d), .Y(N1) );
endmodule


module SYSTEM_TOP ( REF_CLK, UART_CLK, RST, RX_IN, TX_OUT, parity_error, 
        framing_error );
  input REF_CLK, UART_CLK, RST, RX_IN;
  output TX_OUT, parity_error, framing_error;
  wire   UART_RST, TX_CLK, RX_CLK, REF_RST, RX_OUT_V, UART_TX_BUSY,
         enable_pulse, Rd_D_Vld, ALU_OUT_V, FIFO_FULL, en, WrEn, RdEn, Gate_EN,
         WR_INC, gated_clk, FIFO_RINC, FIFO_EMPTY, n1, n2, n3, n4, n5;
  wire   [7:0] REG2;
  wire   [2:0] rx_div_ratio;
  wire   [7:0] REG3;
  wire   [7:0] FIFO_RDATA;
  wire   [7:0] RX_OUT_P;
  wire   [7:0] sync_bus;
  wire   [7:0] Rd_D;
  wire   [15:0] ALU_OUT;
  wire   [3:0] Addr;
  wire   [3:0] FUN;
  wire   [7:0] Wr_D;
  wire   [7:0] WR_DATA;
  wire   [7:0] REG0;
  wire   [7:0] REG1;

  CLK_GATE U0_CLK_GATE ( .clk(REF_CLK), .clk_en(Gate_EN), .gated_clk(gated_clk) );
  prescale_mux U0_prescale_mux ( .prescale(REG2[7:2]), .div_ratio(rx_div_ratio) );
  CLK_DIV_0 U0_TX_CLK_DIV ( .i_ref_clk(UART_CLK), .i_rst_n(n4), .i_clk_en(1'b1), .i_div_ratio(REG3), .o_div_clk(TX_CLK) );
  CLK_DIV_1 U1_RX_CLK_DIV ( .i_ref_clk(UART_CLK), .i_rst_n(n4), .i_clk_en(1'b1), .i_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, rx_div_ratio}), .o_div_clk(
        RX_CLK) );
  RST_SYNC_0 U0_RST_SYNC ( .rst(RST), .clk(REF_CLK), .sync_rst(REF_RST) );
  RST_SYNC_1 U1_RST_SYNC ( .rst(RST), .clk(UART_CLK), .sync_rst(UART_RST) );
  UART U0_UART ( .RST(n4), .TX_CLK(TX_CLK), .RX_CLK(RX_CLK), .RX_IN_S(RX_IN), 
        .parity_enable(REG2[0]), .parity_type(REG2[1]), .TX_IN_V(n1), 
        .Prescale(REG2[7:2]), .TX_IN_P(FIFO_RDATA), .RX_OUT_P(RX_OUT_P), 
        .RX_OUT_V(RX_OUT_V), .TX_OUT_S(TX_OUT), .TX_OUT_V(UART_TX_BUSY), 
        .parity_error(parity_error), .framing_error(framing_error) );
  DATA_SYNC U0_DATA_SYNC ( .clk(REF_CLK), .rst(n2), .bus_enable(RX_OUT_V), 
        .unsync_bus(RX_OUT_P), .sync_bus(sync_bus), .enable_pulse(enable_pulse) );
  SYS_CTRL U0_SYS_CTRL ( .Rd_D(Rd_D), .sync_bus(sync_bus), .Rd_D_Vld(Rd_D_Vld), 
        .clk(REF_CLK), .rst(n2), .out_valid(ALU_OUT_V), .enable_pulse(
        enable_pulse), .FIFO_FULL(FIFO_FULL), .ALU_OUT(ALU_OUT), .Addr(Addr), 
        .FUN(FUN), .en(en), .WrEn(WrEn), .RdEn(RdEn), .Gate_EN(Gate_EN), 
        .WR_INC(WR_INC), .Wr_D(Wr_D), .WR_DATA(WR_DATA) );
  regfile U0_REGFILE ( .WrEn(WrEn), .RdEn(RdEn), .clk(REF_CLK), .rst(n2), 
        .WrData(Wr_D), .Address(Addr), .RdData(Rd_D), .Rd_Data_Valid(Rd_D_Vld), 
        .REG0(REG0), .REG1(REG1), .REG2(REG2), .REG3(REG3) );
  ALU U0_ALU ( .A(REG0), .B(REG1), .ALU_FUN(FUN), .clk(gated_clk), .en(en), 
        .rst(n2), .ALU_OUT(ALU_OUT), .out_valid(ALU_OUT_V) );
  ASYNC_FIFO U0_ASYNC_FIFO ( .wdata(WR_DATA), .winc(WR_INC), .rinc(FIFO_RINC), 
        .wclk(REF_CLK), .rclk(TX_CLK), .wrst_n(n2), .rrst_n(n4), .rdata(
        FIFO_RDATA), .rempty(FIFO_EMPTY), .wfull(FIFO_FULL) );
  Pulse_Gen U0_Pulse_Gen ( .clk(TX_CLK), .rst(n4), .async(UART_TX_BUSY), 
        .sync(FIFO_RINC) );
  INVX2M U3 ( .A(n5), .Y(n4) );
  INVX2M U4 ( .A(n3), .Y(n2) );
  INVX2M U5 ( .A(FIFO_EMPTY), .Y(n1) );
  INVX2M U6 ( .A(REF_RST), .Y(n3) );
  INVX2M U7 ( .A(UART_RST), .Y(n5) );
endmodule

