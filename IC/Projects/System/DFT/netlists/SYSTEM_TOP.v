/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Oct  1 07:37:58 2026
/////////////////////////////////////////////////////////////


module CLK_GATE ( clk, clk_en, gated_clk );
  input clk, clk_en;
  output gated_clk;

wand  gated_clk;

  TLATNCAX2M U0 ( .E(clk_en), .CK(clk), .ECK(gated_clk) );
endmodule


module prescale_mux ( prescale, div_ratio );
  input [5:0] prescale;
  output [2:0] div_ratio;
  wire   n1, n2, n3;

  OAI21X2M U4 ( .A0(n1), .A1(n3), .B0(n2), .Y(div_ratio[0]) );
  AND2X2M U5 ( .A(n2), .B(n3), .Y(div_ratio[1]) );
  AND2X2M U6 ( .A(n1), .B(n2), .Y(div_ratio[2]) );
  NOR3X2M U3 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .Y(n2) );
  NOR3BX1M U7 ( .AN(prescale[4]), .B(prescale[3]), .C(prescale[5]), .Y(n3) );
  NOR3BX1M U8 ( .AN(prescale[3]), .B(prescale[4]), .C(prescale[5]), .Y(n1) );
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


module CLK_DIV_test_0 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk, 
        test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   divided_clk, N19, N20, N21, N22, N23, N24, N25, N26, N29, N30, N31,
         N32, N33, N34, N35, N36, N80, N81, N82, N83, N84, N85, N86, N87, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n88, n90, n91, n92,
         n93, n94;
  wire   [7:0] edge_count;
  wire   [7:0] prev_div_ratio;
  assign test_so = prev_div_ratio[7];

  SDFFSQX2M divided_clk_reg ( .D(n57), .SI(n88), .SE(n94), .CK(i_ref_clk), 
        .SN(n3), .Q(divided_clk) );
  SDFFRX1M clk_div_en_reg ( .D(i_clk_en), .SI(test_si), .SE(n92), .CK(
        i_ref_clk), .RN(n3), .Q(n86), .QN(n88) );
  AND4X2M U8 ( .A(n39), .B(n38), .C(n37), .D(n36), .Y(n1) );
  INVX1M U9 ( .A(i_rst_n), .Y(n4) );
  MX2XLM U10 ( .A(i_ref_clk), .B(divided_clk), .S0(n40), .Y(o_div_clk) );
  INVX4M U11 ( .A(n4), .Y(n3) );
  BUFX2M U25 ( .A(n61), .Y(n2) );
  NOR2X2M U26 ( .A(n62), .B(n1), .Y(n61) );
  OR2X2M U27 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n5) );
  CLKINVX1M U28 ( .A(i_div_ratio[1]), .Y(N19) );
  OAI2BB1X1M U29 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n5), .Y(N20) );
  OR2X1M U30 ( .A(n5), .B(i_div_ratio[3]), .Y(n6) );
  OAI2BB1X1M U31 ( .A0N(n5), .A1N(i_div_ratio[3]), .B0(n6), .Y(N21) );
  OR2X1M U32 ( .A(n6), .B(i_div_ratio[4]), .Y(n7) );
  OAI2BB1X1M U33 ( .A0N(n6), .A1N(i_div_ratio[4]), .B0(n7), .Y(N22) );
  OR2X1M U34 ( .A(n7), .B(i_div_ratio[5]), .Y(n8) );
  OAI2BB1X1M U35 ( .A0N(n7), .A1N(i_div_ratio[5]), .B0(n8), .Y(N23) );
  XNOR2X1M U36 ( .A(i_div_ratio[6]), .B(n8), .Y(N24) );
  NOR3X1M U37 ( .A(i_div_ratio[6]), .B(i_div_ratio[7]), .C(n8), .Y(N26) );
  OAI21X1M U38 ( .A0(i_div_ratio[6]), .A1(n8), .B0(i_div_ratio[7]), .Y(n9) );
  NAND2BX1M U39 ( .AN(N26), .B(n9), .Y(N25) );
  NOR2BX1M U40 ( .AN(prev_div_ratio[0]), .B(i_div_ratio[0]), .Y(n10) );
  OAI2B2X1M U41 ( .A1N(i_div_ratio[1]), .A0(n10), .B0(prev_div_ratio[1]), .B1(
        n10), .Y(n39) );
  NOR2BX1M U42 ( .AN(i_div_ratio[0]), .B(prev_div_ratio[0]), .Y(n29) );
  OAI2B2X1M U43 ( .A1N(prev_div_ratio[1]), .A0(n29), .B0(i_div_ratio[1]), .B1(
        n29), .Y(n38) );
  CLKXOR2X2M U44 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .Y(n31) );
  CLKXOR2X2M U45 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .Y(n30) );
  NOR2X1M U46 ( .A(n31), .B(n30), .Y(n37) );
  CLKXOR2X2M U47 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .Y(n35) );
  CLKXOR2X2M U48 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .Y(n34) );
  CLKXOR2X2M U49 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .Y(n33) );
  CLKXOR2X2M U50 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .Y(n32) );
  NOR4X1M U51 ( .A(n35), .B(n34), .C(n33), .D(n32), .Y(n36) );
  MXI2X1M U52 ( .A(n41), .B(n42), .S0(n43), .Y(n57) );
  NOR2X1M U53 ( .A(n44), .B(n45), .Y(n43) );
  OAI33X1M U54 ( .A0(n46), .A1(n47), .A2(n48), .B0(n58), .B1(n42), .B2(n59), 
        .Y(n45) );
  CLKINVX1M U55 ( .A(n60), .Y(n47) );
  NOR2X1M U56 ( .A(n42), .B(n44), .Y(n41) );
  NAND3BX1M U57 ( .AN(n2), .B(n40), .C(i_clk_en), .Y(n44) );
  CLKINVX1M U58 ( .A(divided_clk), .Y(n42) );
  CLKMX2X2M U59 ( .A(prev_div_ratio[0]), .B(i_div_ratio[0]), .S0(n2), .Y(n56)
         );
  CLKMX2X2M U60 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .S0(n2), .Y(n55)
         );
  CLKMX2X2M U61 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .S0(n2), .Y(n54)
         );
  CLKMX2X2M U62 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .S0(n2), .Y(n53)
         );
  CLKMX2X2M U63 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .S0(n2), .Y(n52)
         );
  CLKMX2X2M U64 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .S0(n2), .Y(n51)
         );
  CLKMX2X2M U65 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .S0(n2), .Y(n50)
         );
  CLKMX2X2M U66 ( .A(prev_div_ratio[1]), .B(i_div_ratio[1]), .S0(n2), .Y(n49)
         );
  AND2X1M U67 ( .A(N36), .B(n63), .Y(N87) );
  AND2X1M U68 ( .A(N35), .B(n63), .Y(N86) );
  AND2X1M U69 ( .A(N34), .B(n63), .Y(N85) );
  AND2X1M U70 ( .A(N33), .B(n63), .Y(N84) );
  AND2X1M U71 ( .A(N32), .B(n63), .Y(N83) );
  AND2X1M U72 ( .A(N31), .B(n63), .Y(N82) );
  AND2X1M U73 ( .A(N30), .B(n63), .Y(N81) );
  AND2X1M U74 ( .A(N29), .B(n63), .Y(N80) );
  CLKNAND2X2M U75 ( .A(n64), .B(n65), .Y(n63) );
  NAND4BX1M U76 ( .AN(n58), .B(i_clk_en), .C(divided_clk), .D(n59), .Y(n65) );
  CLKNAND2X2M U77 ( .A(n66), .B(n67), .Y(n59) );
  NOR4X1M U78 ( .A(edge_count[7]), .B(n68), .C(n69), .D(n70), .Y(n67) );
  CLKXOR2X2M U79 ( .A(i_div_ratio[3]), .B(edge_count[2]), .Y(n70) );
  CLKXOR2X2M U80 ( .A(i_div_ratio[2]), .B(edge_count[1]), .Y(n69) );
  CLKXOR2X2M U81 ( .A(i_div_ratio[1]), .B(edge_count[0]), .Y(n68) );
  NOR4X1M U82 ( .A(n71), .B(n72), .C(n73), .D(n74), .Y(n66) );
  CLKXOR2X2M U83 ( .A(i_div_ratio[7]), .B(edge_count[6]), .Y(n74) );
  CLKXOR2X2M U84 ( .A(i_div_ratio[6]), .B(edge_count[5]), .Y(n73) );
  CLKXOR2X2M U85 ( .A(i_div_ratio[5]), .B(edge_count[4]), .Y(n72) );
  CLKXOR2X2M U86 ( .A(i_div_ratio[4]), .B(edge_count[3]), .Y(n71) );
  OAI21X1M U87 ( .A0(n48), .A1(n46), .B0(n60), .Y(n64) );
  OAI31X1M U88 ( .A0(n58), .A1(divided_clk), .A2(n62), .B0(n75), .Y(n60) );
  NAND4BX1M U89 ( .AN(i_div_ratio[0]), .B(i_clk_en), .C(n40), .D(n1), .Y(n75)
         );
  CLKINVX1M U90 ( .A(i_clk_en), .Y(n62) );
  NAND3X1M U91 ( .A(n40), .B(n1), .C(i_div_ratio[0]), .Y(n58) );
  OA21X1M U92 ( .A0(n76), .A1(n77), .B0(n86), .Y(n40) );
  OR3X1M U93 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n77) );
  OR4X1M U94 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n76) );
  NAND4X1M U95 ( .A(n78), .B(n79), .C(n80), .D(n81), .Y(n46) );
  XNOR2X1M U96 ( .A(edge_count[0]), .B(N19), .Y(n81) );
  XNOR2X1M U97 ( .A(edge_count[1]), .B(N20), .Y(n80) );
  XNOR2X1M U98 ( .A(edge_count[2]), .B(N21), .Y(n79) );
  XNOR2X1M U99 ( .A(edge_count[7]), .B(N26), .Y(n78) );
  NAND4X1M U100 ( .A(n82), .B(n83), .C(n84), .D(n85), .Y(n48) );
  XNOR2X1M U101 ( .A(edge_count[3]), .B(N22), .Y(n85) );
  XNOR2X1M U102 ( .A(edge_count[4]), .B(N23), .Y(n84) );
  XNOR2X1M U103 ( .A(edge_count[5]), .B(N24), .Y(n83) );
  XNOR2X1M U104 ( .A(edge_count[6]), .B(N25), .Y(n82) );
  INVXLM U105 ( .A(test_se), .Y(n90) );
  INVXLM U106 ( .A(n90), .Y(n91) );
  DLY1X1M U107 ( .A(n91), .Y(n92) );
  DLY1X1M U108 ( .A(n91), .Y(n93) );
  DLY1X1M U109 ( .A(n91), .Y(n94) );
  CLK_DIV_0_DW01_inc_0 r80 ( .A(edge_count), .SUM({N36, N35, N34, N33, N32, 
        N31, N30, N29}) );
  SDFFRQX2M \prev_div_ratio_reg[6]  ( .D(n54), .SI(prev_div_ratio[5]), .SE(n93), .CK(i_ref_clk), .RN(n3), .Q(prev_div_ratio[6]) );
  SDFFRQX2M \prev_div_ratio_reg[3]  ( .D(n51), .SI(prev_div_ratio[2]), .SE(n93), .CK(i_ref_clk), .RN(i_rst_n), .Q(prev_div_ratio[3]) );
  SDFFRQX2M \prev_div_ratio_reg[1]  ( .D(n49), .SI(prev_div_ratio[0]), .SE(n93), .CK(i_ref_clk), .RN(i_rst_n), .Q(prev_div_ratio[1]) );
  SDFFRQX2M \edge_count_reg[7]  ( .D(N87), .SI(edge_count[6]), .SE(n93), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[7]) );
  SDFFRQX2M \edge_count_reg[5]  ( .D(N85), .SI(edge_count[4]), .SE(n93), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[5]) );
  SDFFRQX2M \edge_count_reg[2]  ( .D(N82), .SI(edge_count[1]), .SE(n93), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[2]) );
  SDFFRQX2M \prev_div_ratio_reg[7]  ( .D(n55), .SI(prev_div_ratio[6]), .SE(n92), .CK(i_ref_clk), .RN(n3), .Q(prev_div_ratio[7]) );
  SDFFRQX2M \prev_div_ratio_reg[4]  ( .D(n52), .SI(prev_div_ratio[3]), .SE(n92), .CK(i_ref_clk), .RN(n3), .Q(prev_div_ratio[4]) );
  SDFFRQX2M \edge_count_reg[6]  ( .D(N86), .SI(edge_count[5]), .SE(n92), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[6]) );
  SDFFRQX2M \edge_count_reg[3]  ( .D(N83), .SI(edge_count[2]), .SE(n92), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[3]) );
  SDFFRQX2M \edge_count_reg[0]  ( .D(N80), .SI(divided_clk), .SE(n92), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[0]) );
  SDFFRQX2M \prev_div_ratio_reg[5]  ( .D(n53), .SI(prev_div_ratio[4]), .SE(n94), .CK(i_ref_clk), .RN(n3), .Q(prev_div_ratio[5]) );
  SDFFRQX2M \prev_div_ratio_reg[2]  ( .D(n50), .SI(prev_div_ratio[1]), .SE(n94), .CK(i_ref_clk), .RN(i_rst_n), .Q(prev_div_ratio[2]) );
  SDFFRQX2M \prev_div_ratio_reg[0]  ( .D(n56), .SI(edge_count[7]), .SE(n94), 
        .CK(i_ref_clk), .RN(n3), .Q(prev_div_ratio[0]) );
  SDFFRQX2M \edge_count_reg[4]  ( .D(N84), .SI(edge_count[3]), .SE(n94), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[4]) );
  SDFFRQX2M \edge_count_reg[1]  ( .D(N81), .SI(edge_count[0]), .SE(n94), .CK(
        i_ref_clk), .RN(n3), .Q(edge_count[1]) );
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


module CLK_DIV_test_1 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk, 
        test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   divided_clk, N19, N20, N21, N22, N23, N24, N25, N26, N29, N30, N31,
         N32, N33, N34, N35, N36, N80, N81, N82, N83, N84, N85, N86, N87, n1,
         n3, n4, n5, n6, n7, n8, n9, n10, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n116, n118, n119,
         n120, n121, n122;
  wire   [7:0] edge_count;
  wire   [7:0] prev_div_ratio;
  assign test_so = prev_div_ratio[7];

  SDFFRQX1M \edge_count_reg[7]  ( .D(N87), .SI(edge_count[6]), .SE(n122), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[7]) );
  SDFFRQX1M \edge_count_reg[0]  ( .D(N80), .SI(n43), .SE(n121), .CK(i_ref_clk), 
        .RN(n4), .Q(edge_count[0]) );
  SDFFRQX1M \edge_count_reg[1]  ( .D(N81), .SI(edge_count[0]), .SE(n120), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[1]) );
  SDFFRQX1M \edge_count_reg[2]  ( .D(N82), .SI(edge_count[1]), .SE(n122), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[2]) );
  SDFFRQX1M \edge_count_reg[3]  ( .D(N83), .SI(edge_count[2]), .SE(n121), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[3]) );
  SDFFRQX1M \edge_count_reg[4]  ( .D(N84), .SI(edge_count[3]), .SE(n120), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[4]) );
  SDFFRQX1M \edge_count_reg[5]  ( .D(N85), .SI(edge_count[4]), .SE(n122), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[5]) );
  SDFFRQX1M \edge_count_reg[6]  ( .D(N86), .SI(edge_count[5]), .SE(n121), .CK(
        i_ref_clk), .RN(n4), .Q(edge_count[6]) );
  SDFFRX1M clk_div_en_reg ( .D(i_clk_en), .SI(test_si), .SE(n120), .CK(
        i_ref_clk), .RN(n4), .Q(n87), .QN(n116) );
  SDFFRQX1M \prev_div_ratio_reg[2]  ( .D(n95), .SI(prev_div_ratio[1]), .SE(
        n120), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[2]) );
  SDFFRQX1M \prev_div_ratio_reg[3]  ( .D(n94), .SI(prev_div_ratio[2]), .SE(
        n122), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[3]) );
  SDFFRQX1M \prev_div_ratio_reg[4]  ( .D(n93), .SI(prev_div_ratio[3]), .SE(
        n121), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[4]) );
  SDFFRQX1M \prev_div_ratio_reg[5]  ( .D(n92), .SI(prev_div_ratio[4]), .SE(
        n120), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[5]) );
  SDFFRQX1M \prev_div_ratio_reg[6]  ( .D(n91), .SI(prev_div_ratio[5]), .SE(
        n122), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[6]) );
  SDFFRQX1M \prev_div_ratio_reg[7]  ( .D(n90), .SI(prev_div_ratio[6]), .SE(
        n121), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[7]) );
  SDFFRQX1M \prev_div_ratio_reg[0]  ( .D(n89), .SI(edge_count[7]), .SE(n120), 
        .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[0]) );
  SDFFRQX1M \prev_div_ratio_reg[1]  ( .D(n96), .SI(prev_div_ratio[0]), .SE(
        n122), .CK(i_ref_clk), .RN(n4), .Q(prev_div_ratio[1]) );
  SDFFSX1M divided_clk_reg ( .D(n88), .SI(n116), .SE(n121), .CK(i_ref_clk), 
        .SN(n4), .Q(divided_clk), .QN(n43) );
  AND4X2M U8 ( .A(n40), .B(n39), .C(n38), .D(n37), .Y(n1) );
  MX2XLM U10 ( .A(i_ref_clk), .B(divided_clk), .S0(n41), .Y(o_div_clk) );
  OR2X2M U11 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n6) );
  INVX4M U25 ( .A(n5), .Y(n4) );
  BUFX2M U26 ( .A(n62), .Y(n3) );
  NOR2X2M U27 ( .A(n63), .B(n1), .Y(n62) );
  INVX2M U28 ( .A(i_rst_n), .Y(n5) );
  CLKINVX1M U29 ( .A(i_div_ratio[1]), .Y(N19) );
  OAI2BB1X1M U30 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n6), .Y(N20) );
  OR2X1M U31 ( .A(n6), .B(i_div_ratio[3]), .Y(n7) );
  OAI2BB1X1M U32 ( .A0N(n6), .A1N(i_div_ratio[3]), .B0(n7), .Y(N21) );
  OR2X1M U33 ( .A(n7), .B(i_div_ratio[4]), .Y(n8) );
  OAI2BB1X1M U34 ( .A0N(n7), .A1N(i_div_ratio[4]), .B0(n8), .Y(N22) );
  OR2X1M U35 ( .A(n8), .B(i_div_ratio[5]), .Y(n9) );
  OAI2BB1X1M U36 ( .A0N(n8), .A1N(i_div_ratio[5]), .B0(n9), .Y(N23) );
  XNOR2X1M U37 ( .A(i_div_ratio[6]), .B(n9), .Y(N24) );
  NOR3X1M U38 ( .A(i_div_ratio[6]), .B(i_div_ratio[7]), .C(n9), .Y(N26) );
  OAI21X1M U39 ( .A0(i_div_ratio[6]), .A1(n9), .B0(i_div_ratio[7]), .Y(n10) );
  NAND2BX1M U40 ( .AN(N26), .B(n10), .Y(N25) );
  NOR2BX1M U41 ( .AN(prev_div_ratio[0]), .B(i_div_ratio[0]), .Y(n29) );
  OAI2B2X1M U42 ( .A1N(i_div_ratio[1]), .A0(n29), .B0(prev_div_ratio[1]), .B1(
        n29), .Y(n40) );
  NOR2BX1M U43 ( .AN(i_div_ratio[0]), .B(prev_div_ratio[0]), .Y(n30) );
  OAI2B2X1M U44 ( .A1N(prev_div_ratio[1]), .A0(n30), .B0(i_div_ratio[1]), .B1(
        n30), .Y(n39) );
  CLKXOR2X2M U45 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .Y(n32) );
  CLKXOR2X2M U46 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .Y(n31) );
  NOR2X1M U47 ( .A(n32), .B(n31), .Y(n38) );
  CLKXOR2X2M U48 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .Y(n36) );
  CLKXOR2X2M U49 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .Y(n35) );
  CLKXOR2X2M U50 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .Y(n34) );
  CLKXOR2X2M U51 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .Y(n33) );
  NOR4X1M U52 ( .A(n36), .B(n35), .C(n34), .D(n33), .Y(n37) );
  MXI2X1M U53 ( .A(n42), .B(n43), .S0(n44), .Y(n88) );
  NOR2X1M U54 ( .A(n45), .B(n46), .Y(n44) );
  OAI33X1M U55 ( .A0(n47), .A1(n48), .A2(n58), .B0(n59), .B1(n43), .B2(n60), 
        .Y(n46) );
  CLKINVX1M U56 ( .A(n61), .Y(n48) );
  NOR2X1M U57 ( .A(n43), .B(n45), .Y(n42) );
  NAND3BX1M U58 ( .AN(n3), .B(n41), .C(i_clk_en), .Y(n45) );
  CLKMX2X2M U59 ( .A(prev_div_ratio[0]), .B(i_div_ratio[0]), .S0(n3), .Y(n89)
         );
  CLKMX2X2M U60 ( .A(prev_div_ratio[7]), .B(i_div_ratio[7]), .S0(n3), .Y(n90)
         );
  CLKMX2X2M U61 ( .A(prev_div_ratio[6]), .B(i_div_ratio[6]), .S0(n3), .Y(n91)
         );
  CLKMX2X2M U62 ( .A(prev_div_ratio[5]), .B(i_div_ratio[5]), .S0(n3), .Y(n92)
         );
  CLKMX2X2M U63 ( .A(prev_div_ratio[4]), .B(i_div_ratio[4]), .S0(n3), .Y(n93)
         );
  CLKMX2X2M U64 ( .A(prev_div_ratio[3]), .B(i_div_ratio[3]), .S0(n3), .Y(n94)
         );
  CLKMX2X2M U65 ( .A(prev_div_ratio[2]), .B(i_div_ratio[2]), .S0(n3), .Y(n95)
         );
  CLKMX2X2M U66 ( .A(prev_div_ratio[1]), .B(i_div_ratio[1]), .S0(n3), .Y(n96)
         );
  AND2X1M U67 ( .A(N36), .B(n64), .Y(N87) );
  AND2X1M U68 ( .A(N35), .B(n64), .Y(N86) );
  AND2X1M U69 ( .A(N34), .B(n64), .Y(N85) );
  AND2X1M U70 ( .A(N33), .B(n64), .Y(N84) );
  AND2X1M U71 ( .A(N32), .B(n64), .Y(N83) );
  AND2X1M U72 ( .A(N31), .B(n64), .Y(N82) );
  AND2X1M U73 ( .A(N30), .B(n64), .Y(N81) );
  AND2X1M U74 ( .A(N29), .B(n64), .Y(N80) );
  CLKNAND2X2M U75 ( .A(n65), .B(n66), .Y(n64) );
  NAND4BX1M U76 ( .AN(n59), .B(i_clk_en), .C(divided_clk), .D(n60), .Y(n66) );
  CLKNAND2X2M U77 ( .A(n67), .B(n68), .Y(n60) );
  NOR4X1M U78 ( .A(edge_count[7]), .B(n69), .C(n70), .D(n71), .Y(n68) );
  CLKXOR2X2M U79 ( .A(i_div_ratio[3]), .B(edge_count[2]), .Y(n71) );
  CLKXOR2X2M U80 ( .A(i_div_ratio[2]), .B(edge_count[1]), .Y(n70) );
  CLKXOR2X2M U81 ( .A(i_div_ratio[1]), .B(edge_count[0]), .Y(n69) );
  NOR4X1M U82 ( .A(n72), .B(n73), .C(n74), .D(n75), .Y(n67) );
  CLKXOR2X2M U83 ( .A(i_div_ratio[7]), .B(edge_count[6]), .Y(n75) );
  CLKXOR2X2M U84 ( .A(i_div_ratio[6]), .B(edge_count[5]), .Y(n74) );
  CLKXOR2X2M U85 ( .A(i_div_ratio[5]), .B(edge_count[4]), .Y(n73) );
  CLKXOR2X2M U86 ( .A(i_div_ratio[4]), .B(edge_count[3]), .Y(n72) );
  OAI21X1M U87 ( .A0(n58), .A1(n47), .B0(n61), .Y(n65) );
  OAI31X1M U88 ( .A0(n59), .A1(divided_clk), .A2(n63), .B0(n76), .Y(n61) );
  NAND4BX1M U89 ( .AN(i_div_ratio[0]), .B(i_clk_en), .C(n41), .D(n1), .Y(n76)
         );
  CLKINVX1M U90 ( .A(i_clk_en), .Y(n63) );
  NAND3X1M U91 ( .A(n41), .B(n1), .C(i_div_ratio[0]), .Y(n59) );
  OA21X1M U92 ( .A0(n77), .A1(n78), .B0(n87), .Y(n41) );
  OR3X1M U93 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n78) );
  OR4X1M U94 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n77) );
  NAND4X1M U95 ( .A(n79), .B(n80), .C(n81), .D(n82), .Y(n47) );
  XNOR2X1M U96 ( .A(edge_count[0]), .B(N19), .Y(n82) );
  XNOR2X1M U97 ( .A(edge_count[1]), .B(N20), .Y(n81) );
  XNOR2X1M U98 ( .A(edge_count[2]), .B(N21), .Y(n80) );
  XNOR2X1M U99 ( .A(edge_count[7]), .B(N26), .Y(n79) );
  NAND4X1M U100 ( .A(n83), .B(n84), .C(n85), .D(n86), .Y(n58) );
  XNOR2X1M U101 ( .A(edge_count[3]), .B(N22), .Y(n86) );
  XNOR2X1M U102 ( .A(edge_count[4]), .B(N23), .Y(n85) );
  XNOR2X1M U103 ( .A(edge_count[5]), .B(N24), .Y(n84) );
  XNOR2X1M U104 ( .A(edge_count[6]), .B(N25), .Y(n83) );
  INVXLM U105 ( .A(test_se), .Y(n118) );
  INVXLM U106 ( .A(n118), .Y(n119) );
  DLY1X1M U107 ( .A(n119), .Y(n120) );
  DLY1X1M U108 ( .A(n119), .Y(n121) );
  DLY1X1M U109 ( .A(n119), .Y(n122) );
  CLK_DIV_1_DW01_inc_0 r80 ( .A(edge_count), .SUM({N36, N35, N34, N33, N32, 
        N31, N30, N29}) );
endmodule


module RST_SYNC_test_0 ( rst, clk, sync_rst, test_si, test_se );
  input rst, clk, test_si, test_se;
  output sync_rst;

  wire   [0:1] flops;

  SDFFRQX2M \flops_reg[2]  ( .D(flops[1]), .SI(flops[1]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_rst) );
  SDFFRQX2M \flops_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(flops[0]) );
  SDFFRQX2M \flops_reg[1]  ( .D(flops[0]), .SI(flops[0]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(flops[1]) );
endmodule


module RST_SYNC_test_1 ( rst, clk, sync_rst, test_si, test_se );
  input rst, clk, test_si, test_se;
  output sync_rst;

  wire   [0:1] flops;

  SDFFRQX1M \flops_reg[2]  ( .D(flops[1]), .SI(flops[1]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_rst) );
  SDFFRQX1M \flops_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(flops[0]) );
  SDFFRQX1M \flops_reg[1]  ( .D(flops[0]), .SI(flops[0]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(flops[1]) );
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


module Parity_Calc_test_1 ( Data_Valid, PAR_TYP, clk, rst, P_DATA, par_bit, 
        test_si, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, clk, rst, test_si, test_se;
  output par_bit;
  wire   n1, n3, n4, n5, n6, n8, n2;

  XOR3XLM U2 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U3 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XNOR2X2M U4 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n8) );
  INVX2M U6 ( .A(Data_Valid), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
  SDFFRQX2M par_bit_reg ( .D(n8), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(par_bit) );
endmodule


module Serializer_test_1 ( P_DATA, ser_en, clk, rst, ser_done, ser_data, 
        test_si, test_se );
  input [7:0] P_DATA;
  input ser_en, clk, rst, test_si, test_se;
  output ser_done, ser_data;
  wire   N5, N6, N7, N13, N26, N27, N28, N30, n2, n3, n5, n9, n10, n11, n13,
         n26, n27, n28, n29, n30, n31, n32, n33, n1, n4, n6, n7, n8, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n46, n47, n48, n49, n50, n51;
  wire   [7:0] Data_In;

  SDFFRQX1M ser_data_reg ( .D(n13), .SI(N7), .SE(n46), .CK(clk), .RN(n4), .Q(
        ser_data) );
  SDFFRQX1M \count_reg[0]  ( .D(N26), .SI(Data_In[7]), .SE(n51), .CK(clk), 
        .RN(n4), .Q(N5) );
  SDFFRQX1M \Data_In_reg[0]  ( .D(n33), .SI(test_si), .SE(n50), .CK(clk), .RN(
        n4), .Q(Data_In[0]) );
  SDFFRQX1M \Data_In_reg[7]  ( .D(n26), .SI(Data_In[6]), .SE(n49), .CK(clk), 
        .RN(n4), .Q(Data_In[7]) );
  SDFFRQX1M \Data_In_reg[5]  ( .D(n28), .SI(Data_In[4]), .SE(n46), .CK(clk), 
        .RN(n4), .Q(Data_In[5]) );
  SDFFRQX1M \Data_In_reg[3]  ( .D(n30), .SI(Data_In[2]), .SE(n51), .CK(clk), 
        .RN(n4), .Q(Data_In[3]) );
  SDFFRQX1M \Data_In_reg[1]  ( .D(n32), .SI(Data_In[0]), .SE(n50), .CK(clk), 
        .RN(n4), .Q(Data_In[1]) );
  SDFFRQX1M \Data_In_reg[6]  ( .D(n27), .SI(Data_In[5]), .SE(n49), .CK(clk), 
        .RN(n4), .Q(Data_In[6]) );
  SDFFRQX1M \Data_In_reg[4]  ( .D(n29), .SI(Data_In[3]), .SE(n46), .CK(clk), 
        .RN(n4), .Q(Data_In[4]) );
  SDFFRQX1M \Data_In_reg[2]  ( .D(n31), .SI(Data_In[1]), .SE(n51), .CK(clk), 
        .RN(n4), .Q(Data_In[2]) );
  SDFFRQX1M ser_done_reg ( .D(N30), .SI(ser_data), .SE(n50), .CK(clk), .RN(n4), 
        .Q(ser_done) );
  SDFFRQX1M \count_reg[2]  ( .D(N28), .SI(N6), .SE(n49), .CK(clk), .RN(n4), 
        .Q(N7) );
  SDFFRQX1M \count_reg[1]  ( .D(N27), .SI(N5), .SE(n46), .CK(clk), .RN(n4), 
        .Q(N6) );
  INVX4M U3 ( .A(n6), .Y(n4) );
  INVX2M U4 ( .A(rst), .Y(n6) );
  INVX2M U5 ( .A(n3), .Y(n39) );
  INVX2M U6 ( .A(P_DATA[0]), .Y(n43) );
  NOR2X2M U7 ( .A(n40), .B(n1), .Y(N26) );
  INVX2M U8 ( .A(ser_en), .Y(n40) );
  NAND3X2M U9 ( .A(n41), .B(n42), .C(N26), .Y(n3) );
  INVX2M U10 ( .A(n1), .Y(n38) );
  NOR2X2M U11 ( .A(n9), .B(n42), .Y(N30) );
  OAI221X1M U12 ( .A0(n40), .A1(n2), .B0(n3), .B1(n43), .C0(n5), .Y(n13) );
  NAND2X2M U13 ( .A(ser_data), .B(n40), .Y(n5) );
  OAI31X1M U14 ( .A0(n1), .A1(N7), .A2(N6), .B0(N13), .Y(n2) );
  OAI2BB2X1M U15 ( .B0(n3), .B1(n43), .A0N(Data_In[0]), .A1N(n3), .Y(n33) );
  AO22X1M U16 ( .A0(P_DATA[6]), .A1(n39), .B0(Data_In[6]), .B1(n3), .Y(n27) );
  AO22X1M U17 ( .A0(P_DATA[2]), .A1(n39), .B0(Data_In[2]), .B1(n3), .Y(n31) );
  AO22X1M U18 ( .A0(P_DATA[7]), .A1(n39), .B0(Data_In[7]), .B1(n3), .Y(n26) );
  AO22X1M U19 ( .A0(P_DATA[3]), .A1(n39), .B0(Data_In[3]), .B1(n3), .Y(n30) );
  AO22X1M U20 ( .A0(P_DATA[1]), .A1(n39), .B0(Data_In[1]), .B1(n3), .Y(n32) );
  AO22X1M U21 ( .A0(P_DATA[5]), .A1(n39), .B0(Data_In[5]), .B1(n3), .Y(n28) );
  AO22X1M U22 ( .A0(P_DATA[4]), .A1(n39), .B0(Data_In[4]), .B1(n3), .Y(n29) );
  OAI22X1M U23 ( .A0(N7), .A1(n9), .B0(n10), .B1(n42), .Y(N28) );
  AOI21X2M U24 ( .A0(ser_en), .A1(n41), .B0(N26), .Y(n10) );
  INVX2M U25 ( .A(N7), .Y(n42) );
  INVX2M U26 ( .A(N6), .Y(n41) );
  BUFX2M U40 ( .A(N5), .Y(n1) );
  NAND3X2M U41 ( .A(n1), .B(ser_en), .C(N6), .Y(n9) );
  NOR2X2M U42 ( .A(n11), .B(n40), .Y(N27) );
  XNOR2X2M U43 ( .A(n1), .B(N6), .Y(n11) );
  AOI22X1M U44 ( .A0(Data_In[2]), .A1(n38), .B0(Data_In[3]), .B1(n1), .Y(n8)
         );
  AOI22X1M U45 ( .A0(Data_In[0]), .A1(n38), .B0(Data_In[1]), .B1(n1), .Y(n7)
         );
  OA22X1M U46 ( .A0(n41), .A1(n8), .B0(N6), .B1(n7), .Y(n37) );
  AOI22X1M U47 ( .A0(Data_In[6]), .A1(n38), .B0(Data_In[7]), .B1(n1), .Y(n35)
         );
  AOI22X1M U48 ( .A0(Data_In[4]), .A1(n38), .B0(Data_In[5]), .B1(n1), .Y(n34)
         );
  OAI22X1M U49 ( .A0(n35), .A1(n41), .B0(N6), .B1(n34), .Y(n36) );
  OAI2BB2X1M U50 ( .B0(n37), .B1(N7), .A0N(N7), .A1N(n36), .Y(N13) );
  DLY1X1M U51 ( .A(n48), .Y(n46) );
  INVXLM U52 ( .A(test_se), .Y(n47) );
  INVXLM U53 ( .A(n47), .Y(n48) );
  INVXLM U54 ( .A(n47), .Y(n49) );
  INVXLM U55 ( .A(n47), .Y(n50) );
  INVXLM U56 ( .A(n47), .Y(n51) );
endmodule


module FSM_TX_test_1 ( Data_Valid, PAR_EN, ser_done, clk, rst, ser_en, busy, 
        mux_sel, test_so, test_se );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, clk, rst, test_se;
  output ser_en, busy, test_so;
  wire   n7, n8, n4, n5, n6, n10, n11;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = current_state[2];

  INVX2M U6 ( .A(mux_sel[1]), .Y(n5) );
  NAND2X2M U7 ( .A(n5), .B(mux_sel[0]), .Y(next_state[1]) );
  AOI21X2M U8 ( .A0(current_state[1]), .A1(ser_done), .B0(mux_sel[0]), .Y(
        ser_en) );
  NAND2BX2M U9 ( .AN(current_state[2]), .B(current_state[0]), .Y(mux_sel[0])
         );
  NOR2X2M U10 ( .A(n6), .B(current_state[2]), .Y(mux_sel[1]) );
  OAI21X2M U11 ( .A0(current_state[0]), .A1(n6), .B0(mux_sel[0]), .Y(busy) );
  INVX2M U12 ( .A(current_state[1]), .Y(n6) );
  NOR2X2M U13 ( .A(n7), .B(n5), .Y(next_state[2]) );
  AOI2B1X1M U14 ( .A1N(PAR_EN), .A0(ser_done), .B0(n4), .Y(n7) );
  INVX2M U15 ( .A(current_state[0]), .Y(n4) );
  NAND2BX2M U16 ( .AN(ser_en), .B(n8), .Y(next_state[0]) );
  NAND3BX2M U17 ( .AN(current_state[2]), .B(n6), .C(Data_Valid), .Y(n8) );
  INVXLM U18 ( .A(test_se), .Y(n10) );
  INVXLM U19 ( .A(n10), .Y(n11) );
  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(n11), .CK(clk), .RN(rst), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(n11), .CK(clk), .RN(rst), .Q(current_state[1]) );
  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(ser_done), .SE(n11), .CK(clk), .RN(rst), .Q(current_state[0]) );
endmodule


module UART_TX_test_1 ( Data_Valid, PAR_EN, PAR_TYP, clk, rst, P_DATA, TX_OUT, 
        busy, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, clk, rst, test_si, test_se;
  output TX_OUT, busy, test_so;
  wire   ser_data, par_bit, ser_en, ser_done, n1, n2, n6, n7;
  wire   [1:0] mux_sel;

  INVX2M U4 ( .A(n2), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n2) );
  INVXLM U6 ( .A(test_se), .Y(n6) );
  INVXLM U7 ( .A(n6), .Y(n7) );
  MUX U0 ( .ser_data(ser_data), .par_bit(par_bit), .mux_sel(mux_sel), .TX_OUT(
        TX_OUT) );
  Parity_Calc_test_1 U1 ( .Data_Valid(Data_Valid), .PAR_TYP(PAR_TYP), .clk(clk), .rst(n1), .P_DATA(P_DATA), .par_bit(par_bit), .test_si(test_si), .test_se(n7) );
  Serializer_test_1 U2 ( .P_DATA(P_DATA), .ser_en(ser_en), .clk(clk), .rst(n1), 
        .ser_done(ser_done), .ser_data(ser_data), .test_si(par_bit), .test_se(
        n7) );
  FSM_TX_test_1 U3 ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(
        ser_done), .clk(clk), .rst(n1), .ser_en(ser_en), .busy(busy), 
        .mux_sel(mux_sel), .test_so(test_so), .test_se(n7) );
endmodule


module parity_checker_test_1 ( par_chk_en, strt_chk_en, PAR_TYP, rst, clk, 
        majority_bit, P_DATA, edge_cnt, prescale, par_err, test_si, test_se );
  input [7:0] P_DATA;
  input [5:0] edge_cnt;
  input [5:0] prescale;
  input par_chk_en, strt_chk_en, PAR_TYP, rst, clk, majority_bit, test_si,
         test_se;
  output par_err;
  wire   N4, N5, N6, N7, N8, N9, N10, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n1, n2, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24;

  SDFFRQX2M par_err_reg ( .D(n12), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(par_err) );
  OAI31X1M U5 ( .A0(n4), .A1(strt_chk_en), .A2(n5), .B0(n6), .Y(n12) );
  XOR3XLM U6 ( .A(n7), .B(n8), .C(n9), .Y(n4) );
  NAND2X2M U7 ( .A(par_err), .B(n5), .Y(n6) );
  AOI21X2M U8 ( .A0(par_chk_en), .A1(N10), .B0(strt_chk_en), .Y(n5) );
  INVX2M U9 ( .A(prescale[3]), .Y(n15) );
  XOR3XLM U10 ( .A(P_DATA[6]), .B(P_DATA[5]), .C(n10), .Y(n8) );
  XNOR2X2M U11 ( .A(majority_bit), .B(P_DATA[7]), .Y(n10) );
  XOR3XLM U12 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n11), .Y(n7) );
  XNOR2X2M U13 ( .A(P_DATA[4]), .B(P_DATA[3]), .Y(n11) );
  XNOR2X2M U14 ( .A(P_DATA[2]), .B(PAR_TYP), .Y(n9) );
  CLKINVX1M U15 ( .A(prescale[0]), .Y(N4) );
  OAI2BB1X1M U16 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n1), .Y(N5) );
  NOR2X1M U17 ( .A(n1), .B(prescale[2]), .Y(n2) );
  AO21XLM U18 ( .A0(n1), .A1(prescale[2]), .B0(n2), .Y(N6) );
  CLKNAND2X2M U19 ( .A(n2), .B(n15), .Y(n13) );
  OAI21X1M U20 ( .A0(n2), .A1(n15), .B0(n13), .Y(N7) );
  XNOR2X1M U21 ( .A(prescale[4]), .B(n13), .Y(N8) );
  NOR2X1M U22 ( .A(prescale[4]), .B(n13), .Y(n14) );
  CLKXOR2X2M U23 ( .A(prescale[5]), .B(n14), .Y(N9) );
  NOR2BX1M U24 ( .AN(edge_cnt[0]), .B(N4), .Y(n16) );
  OAI2B2X1M U25 ( .A1N(N5), .A0(n16), .B0(edge_cnt[1]), .B1(n16), .Y(n20) );
  NOR2BX1M U26 ( .AN(N4), .B(edge_cnt[0]), .Y(n17) );
  OAI2B2X1M U27 ( .A1N(edge_cnt[1]), .A0(n17), .B0(N5), .B1(n17), .Y(n19) );
  XNOR2X1M U28 ( .A(N9), .B(edge_cnt[5]), .Y(n18) );
  NAND3X1M U29 ( .A(n20), .B(n19), .C(n18), .Y(n24) );
  CLKXOR2X2M U30 ( .A(N8), .B(edge_cnt[4]), .Y(n23) );
  CLKXOR2X2M U31 ( .A(N6), .B(edge_cnt[2]), .Y(n22) );
  CLKXOR2X2M U32 ( .A(N7), .B(edge_cnt[3]), .Y(n21) );
  NOR4X1M U33 ( .A(n24), .B(n23), .C(n22), .D(n21), .Y(N10) );
  OR2X1M U3 ( .A(prescale[1]), .B(prescale[0]), .Y(n1) );
endmodule


module strt_checker_test_1 ( strt_chk_en, majority_bit, clk, rst, strt_glitch, 
        test_si, test_se );
  input strt_chk_en, majority_bit, clk, rst, test_si, test_se;
  output strt_glitch;
  wire   N4;

  AND2X2M U4 ( .A(strt_chk_en), .B(majority_bit), .Y(N4) );
  SDFFRQX2M strt_glitch_reg ( .D(N4), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(strt_glitch) );
endmodule


module stop_checker_test_1 ( stp_chk_en, strt_chk_en, clk, rst, majority_bit, 
        prescale, edge_cnt, stp_err, test_si, test_se );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input stp_chk_en, strt_chk_en, clk, rst, majority_bit, test_si, test_se;
  output stp_err;
  wire   N2, N3, N4, N5, N6, N7, N8, n6, n7, n8, \sub_14/carry[5] ,
         \sub_14/carry[4] , \sub_14/carry[3] , n1, n2, n3, n4, n9, n10, n11,
         n12, n13, n16, n17;
  assign N2 = prescale[0];

  SDFFRQX2M stp_err_reg ( .D(n8), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(stp_err) );
  NOR2X2M U4 ( .A(strt_chk_en), .B(n6), .Y(n8) );
  AOI2BB2XLM U5 ( .B0(n7), .B1(n17), .A0N(majority_bit), .A1N(n7), .Y(n6) );
  NAND2X2M U6 ( .A(stp_chk_en), .B(N8), .Y(n7) );
  INVX2M U7 ( .A(prescale[1]), .Y(N3) );
  XNOR2X1M U8 ( .A(prescale[5]), .B(\sub_14/carry[5] ), .Y(N7) );
  OR2X1M U9 ( .A(prescale[4]), .B(\sub_14/carry[4] ), .Y(\sub_14/carry[5] ) );
  XNOR2X1M U10 ( .A(\sub_14/carry[4] ), .B(prescale[4]), .Y(N6) );
  OR2X1M U11 ( .A(prescale[3]), .B(\sub_14/carry[3] ), .Y(\sub_14/carry[4] )
         );
  XNOR2X1M U12 ( .A(\sub_14/carry[3] ), .B(prescale[3]), .Y(N5) );
  OR2X1M U13 ( .A(prescale[2]), .B(prescale[1]), .Y(\sub_14/carry[3] ) );
  XNOR2X1M U14 ( .A(prescale[1]), .B(prescale[2]), .Y(N4) );
  OAI2B2X1M U16 ( .A1N(N3), .A0(n1), .B0(edge_cnt[1]), .B1(n1), .Y(n9) );
  OAI2B2X1M U18 ( .A1N(edge_cnt[1]), .A0(n2), .B0(N3), .B1(n2), .Y(n4) );
  XNOR2X1M U19 ( .A(N7), .B(edge_cnt[5]), .Y(n3) );
  NAND3X1M U20 ( .A(n9), .B(n4), .C(n3), .Y(n13) );
  CLKXOR2X2M U21 ( .A(N6), .B(edge_cnt[4]), .Y(n12) );
  CLKXOR2X2M U22 ( .A(N4), .B(edge_cnt[2]), .Y(n11) );
  CLKXOR2X2M U23 ( .A(N5), .B(edge_cnt[3]), .Y(n10) );
  NOR4X1M U24 ( .A(n13), .B(n12), .C(n11), .D(n10), .Y(N8) );
  INVXLM U25 ( .A(stp_err), .Y(n16) );
  INVXLM U26 ( .A(n16), .Y(n17) );
  NOR2BXLM U3 ( .AN(edge_cnt[0]), .B(N2), .Y(n1) );
  NOR2BXLM U15 ( .AN(N2), .B(edge_cnt[0]), .Y(n2) );
endmodule


module data_sampling_test_1 ( edge_cnt, prescale, dat_samp_en, clk, rst, RX_IN, 
        majority_bit, test_si, test_so, test_se );
  input [5:0] edge_cnt;
  input [5:0] prescale;
  input dat_samp_en, clk, rst, RX_IN, test_si, test_se;
  output majority_bit, test_so;
  wire   first_sample, second_sample, third_sample, N6, N7, N8, N9, N10, N11,
         N15, N16, N17, N18, N19, n21, n22, n23, \add_21/carry[4] ,
         \add_21/carry[3] , \add_21/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n14, n15, n16, n17, n18, n19, n20, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36;
  assign test_so = third_sample;

  ADDHX1M U5 ( .A(prescale[2]), .B(prescale[1]), .CO(\add_21/carry[2] ), .S(
        N15) );
  ADDHX1M U6 ( .A(prescale[4]), .B(\add_21/carry[3] ), .CO(\add_21/carry[4] ), 
        .S(N17) );
  ADDHX1M U7 ( .A(prescale[3]), .B(\add_21/carry[2] ), .CO(\add_21/carry[3] ), 
        .S(N16) );
  ADDHX1M U8 ( .A(prescale[5]), .B(\add_21/carry[4] ), .CO(N19), .S(N18) );
  CLKINVX1M U11 ( .A(prescale[1]), .Y(N6) );
  OAI2BB1X1M U12 ( .A0N(prescale[1]), .A1N(prescale[2]), .B0(n1), .Y(N7) );
  OR2X1M U13 ( .A(n1), .B(prescale[3]), .Y(n2) );
  OAI2BB1X1M U14 ( .A0N(n1), .A1N(prescale[3]), .B0(n2), .Y(N8) );
  XNOR2X1M U15 ( .A(prescale[4]), .B(n2), .Y(N9) );
  NOR3X1M U16 ( .A(prescale[4]), .B(prescale[5]), .C(n2), .Y(N11) );
  OAI21X1M U17 ( .A0(prescale[4]), .A1(n2), .B0(prescale[5]), .Y(n3) );
  NAND2BX1M U18 ( .AN(N11), .B(n3), .Y(N10) );
  CLKMX2X2M U19 ( .A(third_sample), .B(RX_IN), .S0(n4), .Y(n23) );
  NOR4X1M U20 ( .A(n5), .B(n6), .C(n7), .D(n8), .Y(n4) );
  CLKXOR2X2M U21 ( .A(edge_cnt[1]), .B(N15), .Y(n8) );
  CLKXOR2X2M U22 ( .A(edge_cnt[0]), .B(N6), .Y(n7) );
  NAND2BX1M U23 ( .AN(n9), .B(n10), .Y(n6) );
  NAND4X1M U24 ( .A(n14), .B(n15), .C(n16), .D(n17), .Y(n5) );
  XNOR2X1M U25 ( .A(edge_cnt[2]), .B(N16), .Y(n17) );
  XNOR2X1M U26 ( .A(edge_cnt[3]), .B(N17), .Y(n16) );
  XNOR2X1M U27 ( .A(edge_cnt[4]), .B(N18), .Y(n15) );
  XNOR2X1M U28 ( .A(edge_cnt[5]), .B(N19), .Y(n14) );
  CLKMX2X2M U29 ( .A(first_sample), .B(RX_IN), .S0(n18), .Y(n22) );
  NOR2BX1M U30 ( .AN(dat_samp_en), .B(n19), .Y(n18) );
  CLKMX2X2M U31 ( .A(second_sample), .B(RX_IN), .S0(n20), .Y(n21) );
  NOR2X1M U32 ( .A(n9), .B(n10), .Y(n20) );
  NAND4X1M U33 ( .A(n24), .B(n25), .C(n26), .D(n27), .Y(n10) );
  NOR3X1M U34 ( .A(n28), .B(edge_cnt[5]), .C(n29), .Y(n27) );
  CLKXOR2X2M U35 ( .A(prescale[1]), .B(edge_cnt[0]), .Y(n29) );
  CLKXOR2X2M U36 ( .A(prescale[5]), .B(edge_cnt[4]), .Y(n28) );
  XNOR2X1M U37 ( .A(edge_cnt[2]), .B(prescale[3]), .Y(n26) );
  XNOR2X1M U38 ( .A(edge_cnt[3]), .B(prescale[4]), .Y(n25) );
  XNOR2X1M U39 ( .A(edge_cnt[1]), .B(prescale[2]), .Y(n24) );
  CLKNAND2X2M U40 ( .A(dat_samp_en), .B(n19), .Y(n9) );
  NAND4X1M U41 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n19) );
  NOR3X1M U42 ( .A(n34), .B(n35), .C(n36), .Y(n33) );
  CLKXOR2X2M U43 ( .A(edge_cnt[4]), .B(N10), .Y(n36) );
  CLKXOR2X2M U44 ( .A(edge_cnt[0]), .B(N6), .Y(n35) );
  CLKXOR2X2M U45 ( .A(edge_cnt[5]), .B(N11), .Y(n34) );
  XNOR2X1M U46 ( .A(edge_cnt[2]), .B(N8), .Y(n32) );
  XNOR2X1M U47 ( .A(edge_cnt[3]), .B(N9), .Y(n31) );
  XNOR2X1M U48 ( .A(edge_cnt[1]), .B(N7), .Y(n30) );
  ADDFX1M U49 ( .A(second_sample), .B(third_sample), .CI(first_sample), .CO(
        majority_bit) );
  SDFFRQX2M third_sample_reg ( .D(n23), .SI(second_sample), .SE(test_se), .CK(
        clk), .RN(rst), .Q(third_sample) );
  SDFFRQX2M second_sample_reg ( .D(n21), .SI(first_sample), .SE(test_se), .CK(
        clk), .RN(rst), .Q(second_sample) );
  SDFFRQX2M first_sample_reg ( .D(n22), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(first_sample) );
  OR2X1M U3 ( .A(prescale[2]), .B(prescale[1]), .Y(n1) );
endmodule


module deserializer_test_1 ( deser_en, majority_bit, clk, rst, P_DATA, test_si, 
        test_so, test_se );
  output [7:0] P_DATA;
  input deser_en, majority_bit, clk, rst, test_si, test_se;
  output test_so;
  wire   n1, n2, n5, n8, n9, n11, n12, n13, n15, n16, n18, n20, n22, n24, n25,
         n27, n45, n47, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n3, n4, n6, n7, n10, n14, n17, n19, n21, n23,
         n26, n28, n65, n66, n67, n68, n71, n72, n73;
  wire   [3:0] counter;
  wire   [6:0] data;
  assign test_so = data[6];

  SDFFRQX1M \counter_reg[0]  ( .D(n49), .SI(P_DATA[7]), .SE(n72), .CK(clk), 
        .RN(n4), .Q(counter[0]) );
  SDFFRQX1M \P_DATA_reg[2]  ( .D(n58), .SI(P_DATA[1]), .SE(n71), .CK(clk), 
        .RN(n4), .Q(P_DATA[2]) );
  SDFFRQX1M \counter_reg[1]  ( .D(n47), .SI(counter[0]), .SE(n73), .CK(clk), 
        .RN(n4), .Q(counter[1]) );
  SDFFRQX1M \counter_reg[2]  ( .D(n45), .SI(counter[1]), .SE(n72), .CK(clk), 
        .RN(n4), .Q(counter[2]) );
  SDFFRQX1M \P_DATA_reg[5]  ( .D(n52), .SI(P_DATA[4]), .SE(n71), .CK(clk), 
        .RN(n4), .Q(P_DATA[5]) );
  SDFFRQX1M \P_DATA_reg[0]  ( .D(n62), .SI(test_si), .SE(n73), .CK(clk), .RN(
        n6), .Q(P_DATA[0]) );
  SDFFRQX1M \P_DATA_reg[6]  ( .D(n50), .SI(P_DATA[5]), .SE(n72), .CK(clk), 
        .RN(n4), .Q(P_DATA[6]) );
  SDFFRQX1M \P_DATA_reg[1]  ( .D(n60), .SI(P_DATA[0]), .SE(n71), .CK(clk), 
        .RN(n6), .Q(P_DATA[1]) );
  SDFFRQX1M \P_DATA_reg[4]  ( .D(n54), .SI(P_DATA[3]), .SE(n73), .CK(clk), 
        .RN(n4), .Q(P_DATA[4]) );
  SDFFRQX1M \P_DATA_reg[7]  ( .D(n64), .SI(P_DATA[6]), .SE(n72), .CK(clk), 
        .RN(n4), .Q(P_DATA[7]) );
  SDFFRQX1M \P_DATA_reg[3]  ( .D(n56), .SI(P_DATA[2]), .SE(n71), .CK(clk), 
        .RN(n6), .Q(P_DATA[3]) );
  INVX4M U3 ( .A(n7), .Y(n4) );
  INVX2M U4 ( .A(n7), .Y(n6) );
  INVX2M U5 ( .A(rst), .Y(n7) );
  OR2X2M U6 ( .A(n8), .B(n68), .Y(n12) );
  BUFX2M U7 ( .A(n9), .Y(n3) );
  NAND2X2M U8 ( .A(deser_en), .B(n14), .Y(n8) );
  NAND2X2M U9 ( .A(majority_bit), .B(n10), .Y(n15) );
  OAI221X1M U10 ( .A0(n1), .A1(n2), .B0(n10), .B1(n19), .C0(n5), .Y(n45) );
  CLKXOR2X2M U11 ( .A(n17), .B(n2), .Y(n47) );
  OAI22X1M U12 ( .A0(n15), .A1(n24), .B0(n25), .B1(n67), .Y(n61) );
  NOR2X2M U13 ( .A(n2), .B(n24), .Y(n25) );
  OAI22X1M U14 ( .A0(n1), .A1(n15), .B0(n20), .B1(n66), .Y(n57) );
  NOR2X2M U15 ( .A(n1), .B(n2), .Y(n20) );
  OAI22X1M U16 ( .A0(n1), .A1(n12), .B0(n22), .B1(n23), .Y(n59) );
  NOR2X2M U17 ( .A(n1), .B(n8), .Y(n22) );
  OAI22X1M U18 ( .A0(n12), .A1(n24), .B0(n27), .B1(n65), .Y(n63) );
  NOR2X2M U19 ( .A(n8), .B(n24), .Y(n27) );
  OAI22X1M U20 ( .A0(n12), .A1(n5), .B0(n18), .B1(n28), .Y(n55) );
  NOR2X2M U21 ( .A(n8), .B(n5), .Y(n18) );
  OAI22X1M U22 ( .A0(n5), .A1(n15), .B0(n16), .B1(n26), .Y(n53) );
  NOR2X2M U23 ( .A(n2), .B(n5), .Y(n16) );
  OAI22X1M U24 ( .A0(n11), .A1(n12), .B0(n13), .B1(n21), .Y(n51) );
  NOR2X2M U25 ( .A(n11), .B(n8), .Y(n13) );
  INVX2M U26 ( .A(n2), .Y(n10) );
  NAND2BX2M U27 ( .AN(n11), .B(n10), .Y(n9) );
  OAI21X2M U28 ( .A0(deser_en), .A1(n14), .B0(n8), .Y(n49) );
  INVX2M U29 ( .A(majority_bit), .Y(n68) );
  NAND2X2M U30 ( .A(n19), .B(n17), .Y(n24) );
  NAND2X2M U31 ( .A(deser_en), .B(counter[0]), .Y(n2) );
  OAI2BB2X1M U32 ( .B0(n3), .B1(n68), .A0N(P_DATA[7]), .A1N(n3), .Y(n64) );
  OAI2BB2X1M U33 ( .B0(n3), .B1(n67), .A0N(P_DATA[1]), .A1N(n3), .Y(n60) );
  OAI2BB2X1M U34 ( .B0(n9), .B1(n66), .A0N(P_DATA[3]), .A1N(n3), .Y(n56) );
  OAI2BB2X1M U35 ( .B0(n9), .B1(n65), .A0N(P_DATA[0]), .A1N(n3), .Y(n62) );
  OAI2BB2X1M U36 ( .B0(n9), .B1(n28), .A0N(P_DATA[4]), .A1N(n3), .Y(n54) );
  OAI2BB2X1M U37 ( .B0(n9), .B1(n26), .A0N(P_DATA[5]), .A1N(n3), .Y(n52) );
  OAI2BB2X1M U38 ( .B0(n9), .B1(n23), .A0N(P_DATA[2]), .A1N(n3), .Y(n58) );
  OAI2BB2X1M U39 ( .B0(n9), .B1(n21), .A0N(P_DATA[6]), .A1N(n3), .Y(n50) );
  NAND2X2M U40 ( .A(counter[1]), .B(n19), .Y(n1) );
  NAND2X2M U41 ( .A(counter[2]), .B(n17), .Y(n5) );
  NAND2X2M U42 ( .A(counter[1]), .B(counter[2]), .Y(n11) );
  INVX2M U43 ( .A(counter[1]), .Y(n17) );
  INVX2M U44 ( .A(counter[2]), .Y(n19) );
  INVX2M U45 ( .A(data[1]), .Y(n67) );
  INVX2M U46 ( .A(data[3]), .Y(n66) );
  INVX2M U47 ( .A(data[0]), .Y(n65) );
  INVX2M U48 ( .A(data[4]), .Y(n28) );
  INVX2M U67 ( .A(data[5]), .Y(n26) );
  INVX2M U68 ( .A(data[2]), .Y(n23) );
  INVX2M U69 ( .A(data[6]), .Y(n21) );
  INVX2M U70 ( .A(counter[0]), .Y(n14) );
  DLY1X1M U71 ( .A(test_se), .Y(n71) );
  DLY1X1M U72 ( .A(test_se), .Y(n72) );
  DLY1X1M U73 ( .A(test_se), .Y(n73) );
  SDFFRQX2M \data_reg[6]  ( .D(n51), .SI(data[5]), .SE(n73), .CK(clk), .RN(n4), 
        .Q(data[6]) );
  SDFFRQX2M \data_reg[5]  ( .D(n53), .SI(data[4]), .SE(n71), .CK(clk), .RN(n4), 
        .Q(data[5]) );
  SDFFRQX2M \data_reg[4]  ( .D(n55), .SI(data[3]), .SE(n73), .CK(clk), .RN(n4), 
        .Q(data[4]) );
  SDFFRQX2M \data_reg[3]  ( .D(n57), .SI(data[2]), .SE(n71), .CK(clk), .RN(n6), 
        .Q(data[3]) );
  SDFFRQX2M \data_reg[2]  ( .D(n59), .SI(data[1]), .SE(n72), .CK(clk), .RN(n4), 
        .Q(data[2]) );
  SDFFRQX2M \data_reg[1]  ( .D(n61), .SI(data[0]), .SE(n73), .CK(clk), .RN(n6), 
        .Q(data[1]) );
  SDFFRQX2M \data_reg[0]  ( .D(n63), .SI(counter[2]), .SE(n72), .CK(clk), .RN(
        n4), .Q(data[0]) );
endmodule


module edge_bit_counter_test_1 ( enable, clk, rst, prescale, edge_cnt, test_si, 
        test_se );
  input [5:0] prescale;
  output [5:0] edge_cnt;
  input enable, clk, rst, test_si, test_se;
  wire   n9, N4, N5, N6, N7, N8, N9, N10, N12, N13, N14, N15, N16, N17, n4, n6,
         n8, n10, n12, n14, n16, \add_18/carry[5] , \add_18/carry[4] ,
         \add_18/carry[3] , \add_18/carry[2] , n1, n2, n3, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n33, n5;

  SDFFRQX2M \edges_counter_reg[5]  ( .D(n14), .SI(edge_cnt[4]), .SE(n33), .CK(
        clk), .RN(n1), .Q(edge_cnt[5]) );
  SDFFRQX2M \edges_counter_reg[3]  ( .D(n10), .SI(edge_cnt[2]), .SE(n33), .CK(
        clk), .RN(n1), .Q(edge_cnt[3]) );
  SDFFRQX2M \edges_counter_reg[2]  ( .D(n8), .SI(edge_cnt[1]), .SE(n33), .CK(
        clk), .RN(n1), .Q(edge_cnt[2]) );
  SDFFRQX2M \edges_counter_reg[4]  ( .D(n12), .SI(edge_cnt[3]), .SE(n33), .CK(
        clk), .RN(n1), .Q(edge_cnt[4]) );
  INVX2M U3 ( .A(enable), .Y(n30) );
  INVX2M U4 ( .A(n2), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n2) );
  NOR2X2M U6 ( .A(N10), .B(n30), .Y(n4) );
  AO22X1M U8 ( .A0(edge_cnt[0]), .A1(n30), .B0(N12), .B1(n4), .Y(n16) );
  AO22X1M U9 ( .A0(edge_cnt[1]), .A1(n30), .B0(N13), .B1(n4), .Y(n6) );
  AO22X1M U10 ( .A0(edge_cnt[4]), .A1(n30), .B0(N16), .B1(n4), .Y(n12) );
  AO22X1M U11 ( .A0(edge_cnt[2]), .A1(n30), .B0(N14), .B1(n4), .Y(n8) );
  AO22X1M U18 ( .A0(edge_cnt[3]), .A1(n30), .B0(N15), .B1(n4), .Y(n10) );
  AO22X1M U19 ( .A0(edge_cnt[5]), .A1(n30), .B0(N17), .B1(n4), .Y(n14) );
  INVX2M U20 ( .A(prescale[3]), .Y(n20) );
  ADDHX1M U21 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .CO(\add_18/carry[2] ), .S(
        N13) );
  ADDHX1M U22 ( .A(edge_cnt[2]), .B(\add_18/carry[2] ), .CO(\add_18/carry[3] ), 
        .S(N14) );
  ADDHX1M U23 ( .A(edge_cnt[3]), .B(\add_18/carry[3] ), .CO(\add_18/carry[4] ), 
        .S(N15) );
  ADDHX1M U24 ( .A(edge_cnt[4]), .B(\add_18/carry[4] ), .CO(\add_18/carry[5] ), 
        .S(N16) );
  CLKINVX1M U25 ( .A(prescale[0]), .Y(N4) );
  OAI2BB1X1M U26 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n3), .Y(N5) );
  NOR2X1M U27 ( .A(n3), .B(prescale[2]), .Y(n17) );
  AO21XLM U28 ( .A0(n3), .A1(prescale[2]), .B0(n17), .Y(N6) );
  CLKNAND2X2M U29 ( .A(n17), .B(n20), .Y(n18) );
  OAI21X1M U30 ( .A0(n17), .A1(n20), .B0(n18), .Y(N7) );
  XNOR2X1M U31 ( .A(prescale[4]), .B(n18), .Y(N8) );
  NOR2X1M U32 ( .A(prescale[4]), .B(n18), .Y(n19) );
  CLKXOR2X2M U33 ( .A(prescale[5]), .B(n19), .Y(N9) );
  CLKINVX1M U34 ( .A(edge_cnt[0]), .Y(N12) );
  CLKXOR2X2M U35 ( .A(\add_18/carry[5] ), .B(edge_cnt[5]), .Y(N17) );
  NOR2BX1M U36 ( .AN(edge_cnt[0]), .B(N4), .Y(n21) );
  OAI2B2X1M U37 ( .A1N(N5), .A0(n21), .B0(edge_cnt[1]), .B1(n21), .Y(n25) );
  NOR2BX1M U38 ( .AN(N4), .B(edge_cnt[0]), .Y(n22) );
  OAI2B2X1M U39 ( .A1N(edge_cnt[1]), .A0(n22), .B0(N5), .B1(n22), .Y(n24) );
  XNOR2X1M U40 ( .A(N9), .B(edge_cnt[5]), .Y(n23) );
  NAND3X1M U41 ( .A(n25), .B(n24), .C(n23), .Y(n29) );
  CLKXOR2X2M U42 ( .A(N8), .B(edge_cnt[4]), .Y(n28) );
  CLKXOR2X2M U43 ( .A(N6), .B(edge_cnt[2]), .Y(n27) );
  CLKXOR2X2M U44 ( .A(N7), .B(edge_cnt[3]), .Y(n26) );
  NOR4X1M U45 ( .A(n29), .B(n28), .C(n27), .D(n26), .Y(N10) );
  DLY1X1M U46 ( .A(test_se), .Y(n33) );
  SDFFRQX4M \edges_counter_reg[0]  ( .D(n16), .SI(test_si), .SE(n33), .CK(clk), 
        .RN(n1), .Q(edge_cnt[0]) );
  SDFFRQX1M \edges_counter_reg[1]  ( .D(n6), .SI(edge_cnt[0]), .SE(n33), .CK(
        clk), .RN(n1), .Q(n9) );
  INVXLM U7 ( .A(n9), .Y(n5) );
  INVX4M U12 ( .A(n5), .Y(edge_cnt[1]) );
  OR2X1M U13 ( .A(prescale[1]), .B(prescale[0]), .Y(n3) );
endmodule


module FSM_RX_test_1 ( PAR_EN, RX_IN, strt_glitch, clk, rst, prescale, 
        edge_cnt, dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en, data_valid, 
        deser_en, enable, test_se );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input PAR_EN, RX_IN, strt_glitch, clk, rst, test_se;
  output dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en, data_valid,
         deser_en, enable;
  wire   N31, N32, N33, N34, N35, N36, N37, N38, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n2, n3, n4, n5, n6, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n51, n52, n53, n54;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [2:0] data_counter;

  NOR3X6M U7 ( .A(current_state[1]), .B(current_state[2]), .C(n41), .Y(
        strt_chk_en) );
  NOR4X4M U11 ( .A(n24), .B(n23), .C(n22), .D(n21), .Y(N37) );
  NAND2XLM U12 ( .A(N37), .B(n28), .Y(n27) );
  INVX2M U13 ( .A(n3), .Y(n2) );
  INVX2M U14 ( .A(rst), .Y(n3) );
  INVX2M U15 ( .A(n27), .Y(deser_en) );
  NOR2X2M U16 ( .A(n48), .B(n42), .Y(N38) );
  NAND2X2M U17 ( .A(deser_en), .B(n26), .Y(n33) );
  INVXLM U18 ( .A(N37), .Y(n48) );
  NAND3BX2M U19 ( .AN(n28), .B(n43), .C(n29), .Y(next_state[1]) );
  AOI32XLM U20 ( .A0(N37), .A1(n49), .A2(strt_chk_en), .B0(stp_chk_en), .B1(
        n48), .Y(n29) );
  AO21XLM U21 ( .A0(N37), .A1(strt_chk_en), .B0(deser_en), .Y(n36) );
  NOR2X2M U22 ( .A(n28), .B(strt_chk_en), .Y(n31) );
  INVX2M U23 ( .A(stp_chk_en), .Y(n42) );
  INVX2M U24 ( .A(par_chk_en), .Y(n43) );
  OAI32X1M U26 ( .A0(n33), .A1(data_counter[1]), .A2(n40), .B0(n34), .B1(n46), 
        .Y(n37) );
  OA21X2M U27 ( .A0(data_counter[0]), .A1(n33), .B0(n36), .Y(n34) );
  OAI32X1M U28 ( .A0(n33), .A1(n40), .A2(n46), .B0(n35), .B1(n47), .Y(n38) );
  INVX2M U29 ( .A(data_counter[2]), .Y(n47) );
  AND2X2M U30 ( .A(n33), .B(n34), .Y(n35) );
  OAI221XLM U31 ( .A0(RX_IN), .A1(n30), .B0(N37), .B1(n31), .C0(n32), .Y(
        next_state[0]) );
  AOI22X1M U32 ( .A0(n28), .A1(n26), .B0(strt_chk_en), .B1(n49), .Y(n32) );
  AOI32XLM U33 ( .A0(n44), .A1(n45), .A2(n41), .B0(stp_chk_en), .B1(N37), .Y(
        n30) );
  OAI21BX1M U34 ( .A0(n48), .A1(n43), .B0N(n25), .Y(next_state[2]) );
  OAI32XLM U35 ( .A0(n26), .A1(PAR_EN), .A2(n27), .B0(N37), .B1(n42), .Y(n25)
         );
  OAI22X1M U36 ( .A0(n40), .A1(n36), .B0(data_counter[0]), .B1(n33), .Y(n39)
         );
  INVX2M U37 ( .A(prescale[3]), .Y(n15) );
  INVX2M U38 ( .A(current_state[0]), .Y(n41) );
  NOR3X4M U39 ( .A(n41), .B(current_state[2]), .C(n44), .Y(n28) );
  NOR3X4M U40 ( .A(n44), .B(current_state[0]), .C(n45), .Y(stp_chk_en) );
  NOR3X2M U41 ( .A(current_state[0]), .B(current_state[2]), .C(n44), .Y(
        par_chk_en) );
  INVX2M U42 ( .A(current_state[1]), .Y(n44) );
  INVX2M U43 ( .A(current_state[2]), .Y(n45) );
  NAND3X2M U44 ( .A(data_counter[1]), .B(data_counter[0]), .C(data_counter[2]), 
        .Y(n26) );
  INVX2M U45 ( .A(data_counter[0]), .Y(n40) );
  INVX2M U46 ( .A(data_counter[1]), .Y(n46) );
  INVX2M U47 ( .A(strt_glitch), .Y(n49) );
  BUFX2M U48 ( .A(dat_samp_en), .Y(enable) );
  NAND3X2M U49 ( .A(n43), .B(n42), .C(n31), .Y(dat_samp_en) );
  CLKINVX1M U50 ( .A(prescale[0]), .Y(N31) );
  NOR2X1M U52 ( .A(n4), .B(prescale[2]), .Y(n5) );
  AO21XLM U53 ( .A0(n4), .A1(prescale[2]), .B0(n5), .Y(N33) );
  CLKNAND2X2M U54 ( .A(n5), .B(n15), .Y(n6) );
  OAI21X1M U55 ( .A0(n5), .A1(n15), .B0(n6), .Y(N34) );
  XNOR2X1M U56 ( .A(prescale[4]), .B(n6), .Y(N35) );
  NOR2X1M U57 ( .A(prescale[4]), .B(n6), .Y(n14) );
  CLKXOR2X2M U58 ( .A(prescale[5]), .B(n14), .Y(N36) );
  NOR2BX1M U59 ( .AN(edge_cnt[0]), .B(N31), .Y(n16) );
  OAI2B2X1M U60 ( .A1N(N32), .A0(n16), .B0(edge_cnt[1]), .B1(n16), .Y(n20) );
  NOR2BX1M U61 ( .AN(N31), .B(edge_cnt[0]), .Y(n17) );
  OAI2B2X1M U62 ( .A1N(edge_cnt[1]), .A0(n17), .B0(N32), .B1(n17), .Y(n19) );
  XNOR2X1M U63 ( .A(N36), .B(edge_cnt[5]), .Y(n18) );
  NAND3X1M U64 ( .A(n20), .B(n19), .C(n18), .Y(n24) );
  CLKXOR2X2M U65 ( .A(N35), .B(edge_cnt[4]), .Y(n23) );
  CLKXOR2X2M U66 ( .A(N33), .B(edge_cnt[2]), .Y(n22) );
  CLKXOR2X2M U67 ( .A(N34), .B(edge_cnt[3]), .Y(n21) );
  INVXLM U68 ( .A(test_se), .Y(n51) );
  INVXLM U69 ( .A(n51), .Y(n52) );
  INVXLM U70 ( .A(n51), .Y(n53) );
  INVXLM U71 ( .A(n51), .Y(n54) );
  SDFFRQX2M \data_counter_reg[1]  ( .D(n37), .SI(data_counter[0]), .SE(n54), 
        .CK(clk), .RN(n2), .Q(data_counter[1]) );
  SDFFRQX2M \data_counter_reg[0]  ( .D(n39), .SI(current_state[2]), .SE(n53), 
        .CK(clk), .RN(n2), .Q(data_counter[0]) );
  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(n54), .CK(clk), .RN(n2), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(edge_cnt[5]), .SE(
        n53), .CK(clk), .RN(n2), .Q(current_state[0]) );
  SDFFRQX2M data_valid_reg ( .D(N38), .SI(data_counter[2]), .SE(n52), .CK(clk), 
        .RN(n2), .Q(data_valid) );
  SDFFRQX2M \data_counter_reg[2]  ( .D(n38), .SI(data_counter[1]), .SE(n52), 
        .CK(clk), .RN(n2), .Q(data_counter[2]) );
  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(n52), .CK(clk), .RN(n2), .Q(current_state[1]) );
  OR2X1M U3 ( .A(prescale[1]), .B(prescale[0]), .Y(n4) );
  OAI2BB1XLM U4 ( .A0N(prescale[0]), .A1N(prescale[1]), .B0(n4), .Y(N32) );
endmodule


module UART_RX_test_1 ( RX_IN, clk, rst, PAR_EN, PAR_TYP, prescale, P_DATA, 
        data_valid, par_err, stp_err, test_si2, test_si1, test_se );
  input [5:0] prescale;
  output [7:0] P_DATA;
  input RX_IN, clk, rst, PAR_EN, PAR_TYP, test_si2, test_si1, test_se;
  output data_valid, par_err, stp_err;
  wire   par_chk_en, majority_bit, strt_chk_en, strt_glitch, stp_chk_en,
         dat_samp_en, deser_en, enable, n1, n2, n4, n5, n8, n9;
  wire   [5:0] edge_cnt;

  INVX2M U7 ( .A(n2), .Y(n1) );
  INVX2M U8 ( .A(rst), .Y(n2) );
  DLY1X1M U9 ( .A(test_se), .Y(n8) );
  DLY1X1M U10 ( .A(test_se), .Y(n9) );
  parity_checker_test_1 U0 ( .par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), .PAR_TYP(PAR_TYP), .rst(n1), .clk(clk), .majority_bit(majority_bit), 
        .P_DATA(P_DATA), .edge_cnt(edge_cnt), .prescale(prescale), .par_err(
        par_err), .test_si(test_si1), .test_se(n8) );
  strt_checker_test_1 U1 ( .strt_chk_en(strt_chk_en), .majority_bit(
        majority_bit), .clk(clk), .rst(n1), .strt_glitch(strt_glitch), 
        .test_si(par_err), .test_se(n8) );
  stop_checker_test_1 U2 ( .stp_chk_en(stp_chk_en), .strt_chk_en(strt_chk_en), 
        .clk(clk), .rst(n1), .majority_bit(majority_bit), .prescale(prescale), 
        .edge_cnt(edge_cnt), .stp_err(stp_err), .test_si(test_si2), .test_se(
        n9) );
  data_sampling_test_1 U3 ( .edge_cnt(edge_cnt), .prescale(prescale), 
        .dat_samp_en(dat_samp_en), .clk(clk), .rst(n1), .RX_IN(RX_IN), 
        .majority_bit(majority_bit), .test_si(strt_glitch), .test_so(n5), 
        .test_se(n9) );
  deserializer_test_1 U4 ( .deser_en(deser_en), .majority_bit(majority_bit), 
        .clk(clk), .rst(n1), .P_DATA(P_DATA), .test_si(n5), .test_so(n4), 
        .test_se(n9) );
  edge_bit_counter_test_1 U5 ( .enable(enable), .clk(clk), .rst(n1), 
        .prescale(prescale), .edge_cnt(edge_cnt), .test_si(n4), .test_se(n8)
         );
  FSM_RX_test_1 U6 ( .PAR_EN(PAR_EN), .RX_IN(RX_IN), .strt_glitch(strt_glitch), 
        .clk(clk), .rst(n1), .prescale(prescale), .edge_cnt(edge_cnt), 
        .dat_samp_en(dat_samp_en), .par_chk_en(par_chk_en), .strt_chk_en(
        strt_chk_en), .stp_chk_en(stp_chk_en), .data_valid(data_valid), 
        .deser_en(deser_en), .enable(enable), .test_se(n8) );
endmodule


module UART_test_1 ( RST, TX_CLK, RX_CLK, RX_IN_S, parity_enable, parity_type, 
        TX_IN_V, Prescale, TX_IN_P, RX_OUT_P, RX_OUT_V, TX_OUT_S, TX_OUT_V, 
        parity_error, framing_error, test_si2, test_si1, test_so1, test_se );
  input [5:0] Prescale;
  input [7:0] TX_IN_P;
  output [7:0] RX_OUT_P;
  input RST, TX_CLK, RX_CLK, RX_IN_S, parity_enable, parity_type, TX_IN_V,
         test_si2, test_si1, test_se;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V, parity_error, framing_error, test_so1;
  wire   n1, n2;

  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
  UART_TX_test_1 U0_UART_TX ( .Data_Valid(TX_IN_V), .PAR_EN(parity_enable), 
        .PAR_TYP(parity_type), .clk(TX_CLK), .rst(n1), .P_DATA(TX_IN_P), 
        .TX_OUT(TX_OUT_S), .busy(TX_OUT_V), .test_si(RX_OUT_V), .test_so(
        test_so1), .test_se(test_se) );
  UART_RX_test_1 U0_UART_RX ( .RX_IN(RX_IN_S), .clk(RX_CLK), .rst(n1), 
        .PAR_EN(parity_enable), .PAR_TYP(parity_type), .prescale(Prescale), 
        .P_DATA(RX_OUT_P), .data_valid(RX_OUT_V), .par_err(parity_error), 
        .stp_err(framing_error), .test_si2(test_si2), .test_si1(test_si1), 
        .test_se(test_se) );
endmodule


module DATA_SYNC_test_1 ( clk, rst, bus_enable, unsync_bus, sync_bus, 
        enable_pulse, test_si, test_se );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input clk, rst, bus_enable, test_si, test_se;
  output enable_pulse;
  wire   enable_flop, n1, n3, n5, n7, n9, n11, n13, n15, n17, n22, n23, n24,
         n27;
  wire   [0:1] multi_flops;

  SDFFRQX2M enable_flop_reg ( .D(multi_flops[1]), .SI(test_si), .SE(n27), .CK(
        clk), .RN(n22), .Q(enable_flop) );
  SDFFRQX2M \multi_flops_reg[1]  ( .D(multi_flops[0]), .SI(multi_flops[0]), 
        .SE(n27), .CK(clk), .RN(n22), .Q(multi_flops[1]) );
  SDFFRQX2M \sync_bus_reg[7]  ( .D(n17), .SI(sync_bus[6]), .SE(n27), .CK(clk), 
        .RN(n22), .Q(sync_bus[7]) );
  SDFFRQX2M \sync_bus_reg[4]  ( .D(n11), .SI(sync_bus[3]), .SE(n27), .CK(clk), 
        .RN(n22), .Q(sync_bus[4]) );
  SDFFRQX2M \sync_bus_reg[5]  ( .D(n13), .SI(sync_bus[4]), .SE(n27), .CK(clk), 
        .RN(n22), .Q(sync_bus[5]) );
  SDFFRQX2M \sync_bus_reg[6]  ( .D(n15), .SI(sync_bus[5]), .SE(n27), .CK(clk), 
        .RN(n22), .Q(sync_bus[6]) );
  SDFFRQX2M \sync_bus_reg[3]  ( .D(n9), .SI(sync_bus[2]), .SE(test_se), .CK(
        clk), .RN(n22), .Q(sync_bus[3]) );
  SDFFRQX2M \sync_bus_reg[1]  ( .D(n5), .SI(sync_bus[0]), .SE(test_se), .CK(
        clk), .RN(n22), .Q(sync_bus[1]) );
  SDFFRQX2M \sync_bus_reg[2]  ( .D(n7), .SI(sync_bus[1]), .SE(test_se), .CK(
        clk), .RN(n22), .Q(sync_bus[2]) );
  SDFFRQX2M \sync_bus_reg[0]  ( .D(n3), .SI(multi_flops[1]), .SE(test_se), 
        .CK(clk), .RN(n22), .Q(sync_bus[0]) );
  SDFFRQX2M enable_pulse_reg ( .D(n24), .SI(enable_flop), .SE(test_se), .CK(
        clk), .RN(n22), .Q(enable_pulse) );
  SDFFRQX2M \multi_flops_reg[0]  ( .D(bus_enable), .SI(enable_pulse), .SE(
        test_se), .CK(clk), .RN(n22), .Q(multi_flops[0]) );
  NAND2BX2M U3 ( .AN(enable_flop), .B(multi_flops[1]), .Y(n1) );
  INVX2M U4 ( .A(n1), .Y(n24) );
  INVX4M U5 ( .A(n23), .Y(n22) );
  INVX2M U6 ( .A(rst), .Y(n23) );
  AO22X1M U7 ( .A0(unsync_bus[0]), .A1(n24), .B0(sync_bus[0]), .B1(n1), .Y(n3)
         );
  AO22X1M U8 ( .A0(unsync_bus[6]), .A1(n24), .B0(sync_bus[6]), .B1(n1), .Y(n15) );
  AO22X1M U9 ( .A0(unsync_bus[2]), .A1(n24), .B0(sync_bus[2]), .B1(n1), .Y(n7)
         );
  AO22X1M U10 ( .A0(unsync_bus[1]), .A1(n24), .B0(sync_bus[1]), .B1(n1), .Y(n5) );
  AO22X1M U11 ( .A0(unsync_bus[3]), .A1(n24), .B0(sync_bus[3]), .B1(n1), .Y(n9) );
  AO22X1M U12 ( .A0(unsync_bus[4]), .A1(n24), .B0(sync_bus[4]), .B1(n1), .Y(
        n11) );
  AO22X1M U25 ( .A0(unsync_bus[5]), .A1(n24), .B0(sync_bus[5]), .B1(n1), .Y(
        n13) );
  AO22X1M U26 ( .A0(unsync_bus[7]), .A1(n24), .B0(sync_bus[7]), .B1(n1), .Y(
        n17) );
  DLY1X1M U27 ( .A(test_se), .Y(n27) );
endmodule


module SYS_CTRL_test_1 ( Rd_D, sync_bus, Rd_D_Vld, clk, rst, out_valid, 
        enable_pulse, FIFO_FULL, ALU_OUT, Addr, FUN, en, WrEn, RdEn, Gate_EN, 
        WR_INC, clk_div_en, Wr_D, WR_DATA, test_si2, test_si1, test_so2, 
        test_so1, test_se );
  input [7:0] Rd_D;
  input [7:0] sync_bus;
  input [15:0] ALU_OUT;
  output [3:0] Addr;
  output [3:0] FUN;
  output [7:0] Wr_D;
  output [7:0] WR_DATA;
  input Rd_D_Vld, clk, rst, out_valid, enable_pulse, FIFO_FULL, test_si2,
         test_si1, test_se;
  output en, WrEn, RdEn, Gate_EN, WR_INC, clk_div_en, test_so2, test_so1;
  wire   n17, n18, n19, n20, n28, n29, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n24, n25, n26, n27, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n110, n111, n112, n113, n114,
         n115, n116, n118, n119, n120, n121, n122, n123, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137;
  wire   [3:0] current_state;
  wire   [7:0] command;
  wire   [3:0] next_state;
  assign test_so2 = current_state[3];
  assign test_so1 = current_state[1];

  OAI222X4M U97 ( .A0(n39), .A1(n67), .B0(n89), .B1(n20), .C0(n116), .C1(n88), 
        .Y(Addr[0]) );
  SDFFRX1M \addr_reg_reg[3]  ( .D(n98), .SI(n121), .SE(n126), .CK(clk), .RN(
        n27), .Q(n120), .QN(n17) );
  SDFFRX1M \addr_reg_reg[2]  ( .D(n99), .SI(n122), .SE(n131), .CK(clk), .RN(
        n27), .Q(n121), .QN(n18) );
  SDFFRX1M \addr_reg_reg[1]  ( .D(n100), .SI(n123), .SE(n130), .CK(clk), .RN(
        n27), .Q(n122), .QN(n19) );
  SDFFRX1M \addr_reg_reg[0]  ( .D(n101), .SI(test_si1), .SE(n129), .CK(clk), 
        .RN(n27), .Q(n123), .QN(n20) );
  SDFFRQX2M \command_reg[1]  ( .D(n103), .SI(command[0]), .SE(n129), .CK(clk), 
        .RN(n27), .Q(command[1]) );
  SDFFRQX2M \command_reg[3]  ( .D(n105), .SI(command[2]), .SE(n130), .CK(clk), 
        .RN(n27), .Q(command[3]) );
  SDFFRQX2M \command_reg[0]  ( .D(n102), .SI(n120), .SE(n126), .CK(clk), .RN(
        n27), .Q(command[0]) );
  SDFFRX1M \command_reg[7]  ( .D(n109), .SI(command[6]), .SE(n126), .CK(clk), 
        .RN(n27), .Q(n118), .QN(n28) );
  SDFFRX1M \command_reg[5]  ( .D(n107), .SI(command[4]), .SE(n128), .CK(clk), 
        .RN(n27), .Q(n119), .QN(n29) );
  SDFFRQX2M \command_reg[4]  ( .D(n106), .SI(command[3]), .SE(n131), .CK(clk), 
        .RN(rst), .Q(command[4]) );
  SDFFRQX2M \command_reg[2]  ( .D(n104), .SI(command[1]), .SE(n130), .CK(clk), 
        .RN(n27), .Q(command[2]) );
  SDFFRQX2M \command_reg[6]  ( .D(n108), .SI(n119), .SE(n128), .CK(clk), .RN(
        rst), .Q(command[6]) );
  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(n126), .CK(clk), .RN(n27), .Q(current_state[1]) );
  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(n118), .SE(n128), 
        .CK(clk), .RN(n27), .Q(current_state[0]) );
  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(test_si2), .SE(
        n131), .CK(clk), .RN(n27), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[3]  ( .D(next_state[3]), .SI(current_state[2]), 
        .SE(n126), .CK(clk), .RN(n27), .Q(current_state[3]) );
  OAI22X4M U21 ( .A0(n114), .A1(n88), .B0(n89), .B1(n18), .Y(Addr[2]) );
  NOR2X2M U22 ( .A(n115), .B(n43), .Y(FUN[1]) );
  OAI22X1M U23 ( .A0(n66), .A1(n65), .B0(n45), .B1(n39), .Y(WrEn) );
  BUFX2M U24 ( .A(n73), .Y(n26) );
  INVX2M U25 ( .A(n50), .Y(n35) );
  INVX2M U26 ( .A(WrEn), .Y(n31) );
  INVX2M U27 ( .A(n88), .Y(RdEn) );
  INVX2M U28 ( .A(n26), .Y(n38) );
  INVX4M U29 ( .A(n30), .Y(n27) );
  NOR2X4M U30 ( .A(n116), .B(n43), .Y(FUN[0]) );
  NAND2BX2M U31 ( .AN(n90), .B(n55), .Y(n88) );
  NAND2X2M U32 ( .A(n87), .B(n93), .Y(n50) );
  NAND2X2M U33 ( .A(n90), .B(n65), .Y(n56) );
  NAND2X2M U34 ( .A(n65), .B(n56), .Y(n64) );
  AND2X2M U35 ( .A(n76), .B(n87), .Y(n55) );
  NOR2X4M U36 ( .A(n113), .B(n43), .Y(FUN[3]) );
  NOR2X2M U37 ( .A(n114), .B(n43), .Y(FUN[2]) );
  NOR2X2M U38 ( .A(n31), .B(n116), .Y(Wr_D[0]) );
  NOR2X2M U39 ( .A(n31), .B(n115), .Y(Wr_D[1]) );
  NOR2X2M U40 ( .A(n31), .B(n114), .Y(Wr_D[2]) );
  NOR2X2M U41 ( .A(n31), .B(n113), .Y(Wr_D[3]) );
  NOR2X2M U42 ( .A(n31), .B(n112), .Y(Wr_D[4]) );
  NOR2X2M U43 ( .A(n31), .B(n111), .Y(Wr_D[5]) );
  NOR2X2M U44 ( .A(n31), .B(n110), .Y(Wr_D[6]) );
  NOR2X2M U45 ( .A(n31), .B(n40), .Y(Wr_D[7]) );
  OR3X2M U46 ( .A(n77), .B(n24), .C(n25), .Y(WR_INC) );
  BUFX2M U47 ( .A(n78), .Y(n25) );
  NOR2BX2M U48 ( .AN(n58), .B(n59), .Y(n78) );
  AND2X2M U49 ( .A(n57), .B(n67), .Y(n45) );
  NOR3X2M U50 ( .A(n113), .B(n39), .C(n40), .Y(n52) );
  AOI2BB1X2M U51 ( .A0N(n58), .A1N(n59), .B0(n60), .Y(n44) );
  INVX2M U52 ( .A(n72), .Y(n33) );
  NAND4X2M U53 ( .A(n51), .B(n52), .C(n115), .D(n111), .Y(n49) );
  OAI22X1M U54 ( .A0(n116), .A1(n26), .B0(n38), .B1(n32), .Y(n102) );
  NAND3X2M U55 ( .A(n51), .B(n70), .C(n52), .Y(n73) );
  NAND3X2M U56 ( .A(n44), .B(n45), .C(n46), .Y(next_state[2]) );
  AOI211X2M U57 ( .A0(n47), .A1(n39), .B0(RdEn), .C0(n48), .Y(n46) );
  NOR4X1M U58 ( .A(n49), .B(n110), .C(n50), .D(n114), .Y(n48) );
  NAND3BX2M U59 ( .AN(n53), .B(n44), .C(n54), .Y(next_state[1]) );
  AOI2BB2XLM U60 ( .B0(n55), .B1(n56), .A0N(n57), .A1N(n39), .Y(n54) );
  INVX2M U61 ( .A(n41), .Y(n36) );
  INVX2M U62 ( .A(rst), .Y(n30) );
  NOR3BX2M U63 ( .AN(n93), .B(n133), .C(n37), .Y(n47) );
  NOR2X2M U64 ( .A(current_state[3]), .B(current_state[0]), .Y(n93) );
  AND4X2M U65 ( .A(n66), .B(n59), .C(n91), .D(n92), .Y(n89) );
  AOI21X2M U66 ( .A0(n55), .A1(n64), .B0(n39), .Y(n91) );
  NOR4X1M U67 ( .A(current_state[3]), .B(n35), .C(n47), .D(n60), .Y(n92) );
  INVX2M U68 ( .A(current_state[2]), .Y(n37) );
  OAI22X4M U69 ( .A0(n115), .A1(n88), .B0(n89), .B1(n19), .Y(Addr[1]) );
  OAI22X4M U70 ( .A0(n113), .A1(n88), .B0(n89), .B1(n17), .Y(Addr[3]) );
  NAND2X2M U71 ( .A(enable_pulse), .B(n47), .Y(n43) );
  NAND3X2M U72 ( .A(n95), .B(n32), .C(n96), .Y(n65) );
  NOR3X2M U73 ( .A(command[2]), .B(command[6]), .C(command[4]), .Y(n96) );
  NOR2X2M U74 ( .A(n34), .B(current_state[3]), .Y(n76) );
  NOR2X2M U75 ( .A(current_state[2]), .B(n137), .Y(n87) );
  NAND3X2M U76 ( .A(n76), .B(n37), .C(n134), .Y(n66) );
  NAND3X2M U77 ( .A(current_state[2]), .B(n93), .C(n137), .Y(n59) );
  NAND3X2M U78 ( .A(n76), .B(current_state[2]), .C(n137), .Y(n67) );
  INVX2M U79 ( .A(enable_pulse), .Y(n39) );
  AND3X2M U80 ( .A(n93), .B(n37), .C(n133), .Y(n60) );
  NAND4X2M U81 ( .A(command[4]), .B(command[0]), .C(n94), .D(n95), .Y(n90) );
  NOR2X2M U82 ( .A(command[6]), .B(command[2]), .Y(n94) );
  INVX2M U83 ( .A(current_state[0]), .Y(n34) );
  AND4X2M U84 ( .A(command[1]), .B(enable_pulse), .C(command[3]), .D(n97), .Y(
        n95) );
  NOR2X2M U85 ( .A(n29), .B(n28), .Y(n97) );
  INVX2M U86 ( .A(command[0]), .Y(n32) );
  INVX2M U87 ( .A(sync_bus[2]), .Y(n114) );
  INVX2M U88 ( .A(sync_bus[1]), .Y(n115) );
  INVX2M U89 ( .A(sync_bus[0]), .Y(n116) );
  NOR2X4M U90 ( .A(n41), .B(FIFO_FULL), .Y(n77) );
  NAND3X2M U91 ( .A(current_state[3]), .B(n87), .C(current_state[0]), .Y(n41)
         );
  NAND3BX2M U92 ( .AN(n134), .B(current_state[2]), .C(n76), .Y(n57) );
  INVX2M U93 ( .A(sync_bus[3]), .Y(n113) );
  NAND3X2M U94 ( .A(n87), .B(n34), .C(current_state[3]), .Y(n42) );
  NOR2BX2M U95 ( .AN(Rd_D_Vld), .B(FIFO_FULL), .Y(n58) );
  BUFX2M U96 ( .A(n61), .Y(n24) );
  NOR3BX2M U98 ( .AN(out_valid), .B(n42), .C(FIFO_FULL), .Y(n61) );
  NAND2X2M U99 ( .A(n55), .B(enable_pulse), .Y(n72) );
  NOR3BX2M U100 ( .AN(n70), .B(sync_bus[4]), .C(sync_bus[0]), .Y(n69) );
  OAI2BB1X2M U101 ( .A0N(ALU_OUT[8]), .A1N(n24), .B0(n86), .Y(WR_DATA[0]) );
  AOI22X1M U102 ( .A0(Rd_D[0]), .A1(n25), .B0(ALU_OUT[0]), .B1(n77), .Y(n86)
         );
  OAI2BB1X2M U103 ( .A0N(ALU_OUT[9]), .A1N(n24), .B0(n85), .Y(WR_DATA[1]) );
  AOI22X1M U104 ( .A0(Rd_D[1]), .A1(n25), .B0(ALU_OUT[1]), .B1(n77), .Y(n85)
         );
  OAI2BB1X2M U105 ( .A0N(ALU_OUT[10]), .A1N(n24), .B0(n84), .Y(WR_DATA[2]) );
  AOI22X1M U106 ( .A0(Rd_D[2]), .A1(n25), .B0(ALU_OUT[2]), .B1(n77), .Y(n84)
         );
  OAI2BB1X2M U107 ( .A0N(ALU_OUT[11]), .A1N(n24), .B0(n83), .Y(WR_DATA[3]) );
  AOI22X1M U108 ( .A0(Rd_D[3]), .A1(n25), .B0(ALU_OUT[3]), .B1(n77), .Y(n83)
         );
  OAI2BB1X2M U109 ( .A0N(ALU_OUT[12]), .A1N(n24), .B0(n82), .Y(WR_DATA[4]) );
  AOI22X1M U110 ( .A0(Rd_D[4]), .A1(n25), .B0(ALU_OUT[4]), .B1(n77), .Y(n82)
         );
  OAI2BB1X2M U111 ( .A0N(ALU_OUT[13]), .A1N(n24), .B0(n81), .Y(WR_DATA[5]) );
  AOI22X1M U112 ( .A0(Rd_D[5]), .A1(n25), .B0(ALU_OUT[5]), .B1(n77), .Y(n81)
         );
  OAI2BB1X2M U113 ( .A0N(ALU_OUT[14]), .A1N(n24), .B0(n80), .Y(WR_DATA[6]) );
  AOI22X1M U114 ( .A0(Rd_D[6]), .A1(n25), .B0(ALU_OUT[6]), .B1(n77), .Y(n80)
         );
  OAI2BB1X2M U115 ( .A0N(ALU_OUT[15]), .A1N(n24), .B0(n79), .Y(WR_DATA[7]) );
  AOI22X1M U116 ( .A0(Rd_D[7]), .A1(n25), .B0(ALU_OUT[7]), .B1(n77), .Y(n79)
         );
  CLKXOR2X2M U117 ( .A(n112), .B(sync_bus[0]), .Y(n51) );
  OAI2B2X1M U118 ( .A1N(n65), .A0(n66), .B0(enable_pulse), .B1(n67), .Y(n53)
         );
  OAI2B11X2M U119 ( .A1N(FIFO_FULL), .A0(n41), .B0(n42), .C0(n43), .Y(
        next_state[3]) );
  INVX2M U120 ( .A(sync_bus[6]), .Y(n110) );
  OAI22X1M U121 ( .A0(n116), .A1(n72), .B0(n33), .B1(n20), .Y(n101) );
  OAI22X1M U122 ( .A0(n115), .A1(n72), .B0(n33), .B1(n19), .Y(n100) );
  OAI22X1M U123 ( .A0(n114), .A1(n72), .B0(n33), .B1(n18), .Y(n99) );
  OAI22X1M U124 ( .A0(n113), .A1(n72), .B0(n33), .B1(n17), .Y(n98) );
  OAI22X1M U125 ( .A0(n111), .A1(n26), .B0(n38), .B1(n29), .Y(n107) );
  INVX2M U126 ( .A(sync_bus[4]), .Y(n112) );
  INVX2M U127 ( .A(sync_bus[5]), .Y(n111) );
  OAI2BB2X1M U128 ( .B0(n114), .B1(n26), .A0N(n26), .A1N(command[2]), .Y(n104)
         );
  OAI2BB2X1M U129 ( .B0(n115), .B1(n26), .A0N(n26), .A1N(command[1]), .Y(n103)
         );
  NAND2X2M U130 ( .A(n74), .B(n75), .Y(n70) );
  NAND4X2M U131 ( .A(sync_bus[6]), .B(sync_bus[2]), .C(n115), .D(n111), .Y(n75) );
  NAND4X2M U132 ( .A(sync_bus[5]), .B(sync_bus[1]), .C(n114), .D(n110), .Y(n74) );
  OAI2BB2X1M U133 ( .B0(n110), .B1(n26), .A0N(n26), .A1N(command[6]), .Y(n108)
         );
  NAND4BX1M U134 ( .AN(n24), .B(n57), .C(n62), .D(n63), .Y(next_state[0]) );
  OAI211X2M U135 ( .A0(n68), .A1(n69), .B0(n52), .C0(n35), .Y(n62) );
  AOI221XLM U136 ( .A0(n55), .A1(n64), .B0(FIFO_FULL), .B1(n36), .C0(n53), .Y(
        n63) );
  NOR4X1M U137 ( .A(n71), .B(n112), .C(sync_bus[6]), .D(sync_bus[2]), .Y(n68)
         );
  OAI2BB2X1M U138 ( .B0(n112), .B1(n26), .A0N(n26), .A1N(command[4]), .Y(n106)
         );
  INVX2M U139 ( .A(sync_bus[7]), .Y(n40) );
  NAND2X2M U140 ( .A(n26), .B(n28), .Y(n109) );
  OR2X2M U141 ( .A(command[3]), .B(n38), .Y(n105) );
  NAND3X2M U142 ( .A(sync_bus[1]), .B(sync_bus[0]), .C(sync_bus[5]), .Y(n71)
         );
  BUFX2M U143 ( .A(en), .Y(Gate_EN) );
  INVX2M U144 ( .A(n43), .Y(en) );
  DLY1X1M U145 ( .A(n129), .Y(n126) );
  INVXLM U146 ( .A(test_se), .Y(n127) );
  INVXLM U147 ( .A(n127), .Y(n128) );
  INVXLM U148 ( .A(n127), .Y(n129) );
  INVXLM U149 ( .A(n127), .Y(n130) );
  INVXLM U150 ( .A(n127), .Y(n131) );
  INVXLM U151 ( .A(n136), .Y(n132) );
  INVXLM U152 ( .A(n132), .Y(n133) );
  INVXLM U153 ( .A(n132), .Y(n134) );
  INVXLM U154 ( .A(current_state[1]), .Y(n135) );
  INVXLM U155 ( .A(n135), .Y(n136) );
  INVXLM U156 ( .A(n135), .Y(n137) );
  INVX2M U3 ( .A(1'b0), .Y(clk_div_en) );
endmodule


module regfile_test_1 ( WrEn, RdEn, clk, rst, WrData, Address, RdData, 
        Rd_Data_Valid, REG0, REG1, REG2, REG3, test_si2, test_si1, test_so2, 
        test_so1, test_se );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input WrEn, RdEn, clk, rst, test_si2, test_si1, test_se;
  output Rd_Data_Valid, test_so2, test_so1;
  wire   N10, N11, N12, N13, \Registers[15][7] , \Registers[15][6] ,
         \Registers[15][5] , \Registers[15][4] , \Registers[15][3] ,
         \Registers[15][2] , \Registers[15][1] , \Registers[15][0] ,
         \Registers[14][7] , \Registers[14][6] , \Registers[14][5] ,
         \Registers[14][4] , \Registers[14][3] , \Registers[14][2] ,
         \Registers[14][1] , \Registers[14][0] , \Registers[13][7] ,
         \Registers[13][6] , \Registers[13][5] , \Registers[13][4] ,
         \Registers[13][3] , \Registers[13][2] , \Registers[13][1] ,
         \Registers[13][0] , \Registers[12][7] , \Registers[12][6] ,
         \Registers[12][5] , \Registers[12][4] , \Registers[12][3] ,
         \Registers[12][2] , \Registers[12][1] , \Registers[12][0] ,
         \Registers[11][7] , \Registers[11][6] , \Registers[11][5] ,
         \Registers[11][4] , \Registers[11][3] , \Registers[11][2] ,
         \Registers[11][1] , \Registers[11][0] , \Registers[10][7] ,
         \Registers[10][6] , \Registers[10][5] , \Registers[10][4] ,
         \Registers[10][3] , \Registers[10][2] , \Registers[10][1] ,
         \Registers[10][0] , \Registers[9][7] , \Registers[9][6] ,
         \Registers[9][5] , \Registers[9][4] , \Registers[9][3] ,
         \Registers[9][2] , \Registers[9][1] , \Registers[9][0] ,
         \Registers[8][7] , \Registers[8][6] , \Registers[8][5] ,
         \Registers[8][4] , \Registers[8][3] , \Registers[8][2] ,
         \Registers[8][1] , \Registers[8][0] , \Registers[7][7] ,
         \Registers[7][6] , \Registers[7][5] , \Registers[7][4] ,
         \Registers[7][3] , \Registers[7][2] , \Registers[7][1] ,
         \Registers[7][0] , \Registers[6][7] , \Registers[6][6] ,
         \Registers[6][5] , \Registers[6][4] , \Registers[6][3] ,
         \Registers[6][2] , \Registers[6][1] , \Registers[6][0] ,
         \Registers[5][7] , \Registers[5][6] , \Registers[5][5] ,
         \Registers[5][4] , \Registers[5][3] , \Registers[5][2] ,
         \Registers[5][1] , \Registers[5][0] , \Registers[4][7] ,
         \Registers[4][6] , \Registers[4][5] , \Registers[4][4] ,
         \Registers[4][3] , \Registers[4][2] , \Registers[4][1] ,
         \Registers[4][0] , N35, N36, N37, N38, N39, N40, N41, N42, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n237, n238,
         n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n313, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n314, n315,
         n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326,
         n327, n328, n329, n330, n331, n332, n333, n334, n335, n336, n337,
         n338, n339, n340, n341, n342, n343, n344, n345, n346, n347, n348,
         n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, n359,
         n360, n361, n362, n363, n364, n365, n366, n367, n368, n369, n370,
         n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381,
         n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392,
         n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403,
         n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425,
         n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436,
         n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447,
         n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458,
         n459, n460, n461, n462, n466, n467, n468, n469, n470, n471, n472,
         n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483,
         n484, n485, n486, n487, n488, n489, n490;
  assign N10 = Address[0];
  assign N11 = Address[1];
  assign N12 = Address[2];
  assign N13 = Address[3];
  assign test_so2 = \Registers[15][7] ;
  assign test_so1 = \Registers[6][1] ;

  SDFFRQX2M \RdData_reg[7]  ( .D(n184), .SI(RdData[6]), .SE(n488), .CK(clk), 
        .RN(n440), .Q(RdData[7]) );
  SDFFRQX2M \RdData_reg[6]  ( .D(n183), .SI(RdData[5]), .SE(n479), .CK(clk), 
        .RN(n439), .Q(RdData[6]) );
  SDFFRQX2M \RdData_reg[5]  ( .D(n182), .SI(RdData[4]), .SE(n485), .CK(clk), 
        .RN(n439), .Q(RdData[5]) );
  SDFFRQX2M \RdData_reg[4]  ( .D(n181), .SI(RdData[3]), .SE(n484), .CK(clk), 
        .RN(n439), .Q(RdData[4]) );
  SDFFRQX2M \RdData_reg[3]  ( .D(n180), .SI(RdData[2]), .SE(n483), .CK(clk), 
        .RN(n439), .Q(RdData[3]) );
  SDFFRQX2M \RdData_reg[2]  ( .D(n179), .SI(RdData[1]), .SE(n482), .CK(clk), 
        .RN(n439), .Q(RdData[2]) );
  SDFFRQX2M \RdData_reg[1]  ( .D(n178), .SI(RdData[0]), .SE(n488), .CK(clk), 
        .RN(n439), .Q(RdData[1]) );
  SDFFRQX2M \RdData_reg[0]  ( .D(n177), .SI(test_si1), .SE(n479), .CK(clk), 
        .RN(n444), .Q(RdData[0]) );
  SDFFRQX2M \Registers_reg[15][7]  ( .D(n313), .SI(\Registers[15][6] ), .SE(
        n489), .CK(clk), .RN(n439), .Q(\Registers[15][7] ) );
  SDFFRQX2M \Registers_reg[15][6]  ( .D(n312), .SI(\Registers[15][5] ), .SE(
        n486), .CK(clk), .RN(n449), .Q(\Registers[15][6] ) );
  SDFFRQX2M \Registers_reg[15][5]  ( .D(n311), .SI(\Registers[15][4] ), .SE(
        n487), .CK(clk), .RN(n449), .Q(\Registers[15][5] ) );
  SDFFRQX2M \Registers_reg[15][4]  ( .D(n310), .SI(\Registers[15][3] ), .SE(
        n486), .CK(clk), .RN(n449), .Q(\Registers[15][4] ) );
  SDFFRQX2M \Registers_reg[15][3]  ( .D(n309), .SI(\Registers[15][2] ), .SE(
        n485), .CK(clk), .RN(n449), .Q(\Registers[15][3] ) );
  SDFFRQX2M \Registers_reg[15][2]  ( .D(n308), .SI(\Registers[15][1] ), .SE(
        n484), .CK(clk), .RN(n449), .Q(\Registers[15][2] ) );
  SDFFRQX2M \Registers_reg[15][1]  ( .D(n307), .SI(\Registers[15][0] ), .SE(
        n483), .CK(clk), .RN(n449), .Q(\Registers[15][1] ) );
  SDFFRQX2M \Registers_reg[15][0]  ( .D(n306), .SI(\Registers[14][7] ), .SE(
        n482), .CK(clk), .RN(n449), .Q(\Registers[15][0] ) );
  SDFFRQX2M \Registers_reg[13][7]  ( .D(n297), .SI(\Registers[13][6] ), .SE(
        n472), .CK(clk), .RN(n448), .Q(\Registers[13][7] ) );
  SDFFRQX2M \Registers_reg[13][6]  ( .D(n296), .SI(\Registers[13][5] ), .SE(
        n487), .CK(clk), .RN(n448), .Q(\Registers[13][6] ) );
  SDFFRQX2M \Registers_reg[13][5]  ( .D(n295), .SI(\Registers[13][4] ), .SE(
        n486), .CK(clk), .RN(n448), .Q(\Registers[13][5] ) );
  SDFFRQX2M \Registers_reg[13][4]  ( .D(n294), .SI(\Registers[13][3] ), .SE(
        n485), .CK(clk), .RN(n448), .Q(\Registers[13][4] ) );
  SDFFRQX2M \Registers_reg[13][3]  ( .D(n293), .SI(\Registers[13][2] ), .SE(
        n484), .CK(clk), .RN(n448), .Q(\Registers[13][3] ) );
  SDFFRQX2M \Registers_reg[13][2]  ( .D(n292), .SI(\Registers[13][1] ), .SE(
        n483), .CK(clk), .RN(n447), .Q(\Registers[13][2] ) );
  SDFFRQX2M \Registers_reg[13][1]  ( .D(n291), .SI(\Registers[13][0] ), .SE(
        n482), .CK(clk), .RN(n447), .Q(\Registers[13][1] ) );
  SDFFRQX2M \Registers_reg[13][0]  ( .D(n290), .SI(\Registers[12][7] ), .SE(
        n488), .CK(clk), .RN(n447), .Q(\Registers[13][0] ) );
  SDFFRQX2M \Registers_reg[11][7]  ( .D(n281), .SI(\Registers[11][6] ), .SE(
        n487), .CK(clk), .RN(n447), .Q(\Registers[11][7] ) );
  SDFFRQX2M \Registers_reg[11][6]  ( .D(n280), .SI(\Registers[11][5] ), .SE(
        n486), .CK(clk), .RN(n447), .Q(\Registers[11][6] ) );
  SDFFRQX2M \Registers_reg[11][5]  ( .D(n279), .SI(\Registers[11][4] ), .SE(
        n485), .CK(clk), .RN(n446), .Q(\Registers[11][5] ) );
  SDFFRQX2M \Registers_reg[11][4]  ( .D(n278), .SI(\Registers[11][3] ), .SE(
        n484), .CK(clk), .RN(n446), .Q(\Registers[11][4] ) );
  SDFFRQX2M \Registers_reg[11][3]  ( .D(n277), .SI(\Registers[11][2] ), .SE(
        n483), .CK(clk), .RN(n446), .Q(\Registers[11][3] ) );
  SDFFRQX2M \Registers_reg[11][2]  ( .D(n276), .SI(\Registers[11][1] ), .SE(
        n482), .CK(clk), .RN(n446), .Q(\Registers[11][2] ) );
  SDFFRQX2M \Registers_reg[11][1]  ( .D(n275), .SI(\Registers[11][0] ), .SE(
        n488), .CK(clk), .RN(n446), .Q(\Registers[11][1] ) );
  SDFFRQX2M \Registers_reg[11][0]  ( .D(n274), .SI(\Registers[10][7] ), .SE(
        n489), .CK(clk), .RN(n446), .Q(\Registers[11][0] ) );
  SDFFRQX2M \Registers_reg[9][7]  ( .D(n265), .SI(\Registers[9][6] ), .SE(n486), .CK(clk), .RN(n445), .Q(\Registers[9][7] ) );
  SDFFRQX2M \Registers_reg[9][6]  ( .D(n264), .SI(\Registers[9][5] ), .SE(n485), .CK(clk), .RN(n445), .Q(\Registers[9][6] ) );
  SDFFRQX2M \Registers_reg[9][5]  ( .D(n263), .SI(\Registers[9][4] ), .SE(n484), .CK(clk), .RN(n445), .Q(\Registers[9][5] ) );
  SDFFRQX2M \Registers_reg[9][4]  ( .D(n262), .SI(\Registers[9][3] ), .SE(n483), .CK(clk), .RN(n445), .Q(\Registers[9][4] ) );
  SDFFRQX2M \Registers_reg[9][3]  ( .D(n261), .SI(\Registers[9][2] ), .SE(n482), .CK(clk), .RN(n445), .Q(\Registers[9][3] ) );
  SDFFRQX2M \Registers_reg[9][2]  ( .D(n260), .SI(\Registers[9][1] ), .SE(n488), .CK(clk), .RN(n445), .Q(\Registers[9][2] ) );
  SDFFRQX2M \Registers_reg[9][1]  ( .D(n259), .SI(\Registers[9][0] ), .SE(n489), .CK(clk), .RN(n445), .Q(\Registers[9][1] ) );
  SDFFRQX2M \Registers_reg[9][0]  ( .D(n258), .SI(\Registers[8][7] ), .SE(n467), .CK(clk), .RN(n445), .Q(\Registers[9][0] ) );
  SDFFRQX2M \Registers_reg[7][7]  ( .D(n249), .SI(\Registers[7][6] ), .SE(n485), .CK(clk), .RN(n444), .Q(\Registers[7][7] ) );
  SDFFRQX2M \Registers_reg[7][6]  ( .D(n248), .SI(\Registers[7][5] ), .SE(n484), .CK(clk), .RN(n444), .Q(\Registers[7][6] ) );
  SDFFRQX2M \Registers_reg[7][5]  ( .D(n247), .SI(\Registers[7][4] ), .SE(n483), .CK(clk), .RN(n444), .Q(\Registers[7][5] ) );
  SDFFRQX2M \Registers_reg[7][4]  ( .D(n246), .SI(\Registers[7][3] ), .SE(n482), .CK(clk), .RN(n444), .Q(\Registers[7][4] ) );
  SDFFRQX2M \Registers_reg[7][3]  ( .D(n245), .SI(\Registers[7][2] ), .SE(n488), .CK(clk), .RN(n444), .Q(\Registers[7][3] ) );
  SDFFRQX2M \Registers_reg[7][2]  ( .D(n244), .SI(\Registers[7][1] ), .SE(n489), .CK(clk), .RN(n444), .Q(\Registers[7][2] ) );
  SDFFRQX2M \Registers_reg[7][1]  ( .D(n243), .SI(\Registers[7][0] ), .SE(n467), .CK(clk), .RN(n444), .Q(\Registers[7][1] ) );
  SDFFRQX2M \Registers_reg[7][0]  ( .D(n242), .SI(\Registers[6][7] ), .SE(n487), .CK(clk), .RN(n444), .Q(\Registers[7][0] ) );
  SDFFRQX2M \Registers_reg[5][7]  ( .D(n233), .SI(\Registers[5][6] ), .SE(n480), .CK(clk), .RN(n443), .Q(\Registers[5][7] ) );
  SDFFRQX2M \Registers_reg[5][6]  ( .D(n232), .SI(\Registers[5][5] ), .SE(n480), .CK(clk), .RN(n443), .Q(\Registers[5][6] ) );
  SDFFRQX2M \Registers_reg[5][5]  ( .D(n231), .SI(\Registers[5][4] ), .SE(n480), .CK(clk), .RN(n443), .Q(\Registers[5][5] ) );
  SDFFRQX2M \Registers_reg[5][4]  ( .D(n230), .SI(\Registers[5][3] ), .SE(n480), .CK(clk), .RN(n443), .Q(\Registers[5][4] ) );
  SDFFRQX2M \Registers_reg[5][3]  ( .D(n229), .SI(\Registers[5][2] ), .SE(n487), .CK(clk), .RN(n443), .Q(\Registers[5][3] ) );
  SDFFRQX2M \Registers_reg[5][2]  ( .D(n228), .SI(\Registers[5][1] ), .SE(n487), .CK(clk), .RN(n442), .Q(\Registers[5][2] ) );
  SDFFRQX2M \Registers_reg[5][1]  ( .D(n227), .SI(\Registers[5][0] ), .SE(n486), .CK(clk), .RN(n442), .Q(\Registers[5][1] ) );
  SDFFRQX2M \Registers_reg[5][0]  ( .D(n226), .SI(\Registers[4][7] ), .SE(n480), .CK(clk), .RN(n442), .Q(\Registers[5][0] ) );
  SDFFRQX2M \Registers_reg[14][7]  ( .D(n305), .SI(\Registers[14][6] ), .SE(
        n486), .CK(clk), .RN(n448), .Q(\Registers[14][7] ) );
  SDFFRQX2M \Registers_reg[14][6]  ( .D(n304), .SI(\Registers[14][5] ), .SE(
        n485), .CK(clk), .RN(n448), .Q(\Registers[14][6] ) );
  SDFFRQX2M \Registers_reg[14][5]  ( .D(n303), .SI(\Registers[14][4] ), .SE(
        n484), .CK(clk), .RN(n448), .Q(\Registers[14][5] ) );
  SDFFRQX2M \Registers_reg[14][4]  ( .D(n302), .SI(\Registers[14][3] ), .SE(
        n483), .CK(clk), .RN(n448), .Q(\Registers[14][4] ) );
  SDFFRQX2M \Registers_reg[14][3]  ( .D(n301), .SI(\Registers[14][2] ), .SE(
        n482), .CK(clk), .RN(n448), .Q(\Registers[14][3] ) );
  SDFFRQX2M \Registers_reg[14][2]  ( .D(n300), .SI(\Registers[14][1] ), .SE(
        n488), .CK(clk), .RN(n448), .Q(\Registers[14][2] ) );
  SDFFRQX2M \Registers_reg[14][1]  ( .D(n299), .SI(\Registers[14][0] ), .SE(
        n489), .CK(clk), .RN(n448), .Q(\Registers[14][1] ) );
  SDFFRQX2M \Registers_reg[14][0]  ( .D(n298), .SI(\Registers[13][7] ), .SE(
        n480), .CK(clk), .RN(n448), .Q(\Registers[14][0] ) );
  SDFFRQX2M \Registers_reg[12][7]  ( .D(n289), .SI(\Registers[12][6] ), .SE(
        n471), .CK(clk), .RN(n447), .Q(\Registers[12][7] ) );
  SDFFRQX2M \Registers_reg[12][6]  ( .D(n288), .SI(\Registers[12][5] ), .SE(
        n472), .CK(clk), .RN(n447), .Q(\Registers[12][6] ) );
  SDFFRQX2M \Registers_reg[12][5]  ( .D(n287), .SI(\Registers[12][4] ), .SE(
        n474), .CK(clk), .RN(n447), .Q(\Registers[12][5] ) );
  SDFFRQX2M \Registers_reg[12][4]  ( .D(n286), .SI(\Registers[12][3] ), .SE(
        n475), .CK(clk), .RN(n447), .Q(\Registers[12][4] ) );
  SDFFRQX2M \Registers_reg[12][3]  ( .D(n285), .SI(\Registers[12][2] ), .SE(
        n472), .CK(clk), .RN(n447), .Q(\Registers[12][3] ) );
  SDFFRQX2M \Registers_reg[12][2]  ( .D(n284), .SI(\Registers[12][1] ), .SE(
        n475), .CK(clk), .RN(n447), .Q(\Registers[12][2] ) );
  SDFFRQX2M \Registers_reg[12][1]  ( .D(n283), .SI(\Registers[12][0] ), .SE(
        n476), .CK(clk), .RN(n447), .Q(\Registers[12][1] ) );
  SDFFRQX2M \Registers_reg[12][0]  ( .D(n282), .SI(\Registers[11][7] ), .SE(
        n473), .CK(clk), .RN(n447), .Q(\Registers[12][0] ) );
  SDFFRQX2M \Registers_reg[10][7]  ( .D(n273), .SI(\Registers[10][6] ), .SE(
        n481), .CK(clk), .RN(n446), .Q(\Registers[10][7] ) );
  SDFFRQX2M \Registers_reg[10][6]  ( .D(n272), .SI(\Registers[10][5] ), .SE(
        n479), .CK(clk), .RN(n446), .Q(\Registers[10][6] ) );
  SDFFRQX2M \Registers_reg[10][5]  ( .D(n271), .SI(\Registers[10][4] ), .SE(
        n481), .CK(clk), .RN(n446), .Q(\Registers[10][5] ) );
  SDFFRQX2M \Registers_reg[10][4]  ( .D(n270), .SI(\Registers[10][3] ), .SE(
        test_se), .CK(clk), .RN(n446), .Q(\Registers[10][4] ) );
  SDFFRQX2M \Registers_reg[10][3]  ( .D(n269), .SI(\Registers[10][2] ), .SE(
        test_se), .CK(clk), .RN(n446), .Q(\Registers[10][3] ) );
  SDFFRQX2M \Registers_reg[10][2]  ( .D(n268), .SI(\Registers[10][1] ), .SE(
        test_se), .CK(clk), .RN(n446), .Q(\Registers[10][2] ) );
  SDFFRQX2M \Registers_reg[10][1]  ( .D(n267), .SI(\Registers[10][0] ), .SE(
        test_se), .CK(clk), .RN(n446), .Q(\Registers[10][1] ) );
  SDFFRQX2M \Registers_reg[10][0]  ( .D(n266), .SI(\Registers[9][7] ), .SE(
        test_se), .CK(clk), .RN(n445), .Q(\Registers[10][0] ) );
  SDFFRQX2M \Registers_reg[8][7]  ( .D(n257), .SI(\Registers[8][6] ), .SE(n469), .CK(clk), .RN(n445), .Q(\Registers[8][7] ) );
  SDFFRQX2M \Registers_reg[8][6]  ( .D(n256), .SI(\Registers[8][5] ), .SE(n468), .CK(clk), .RN(n445), .Q(\Registers[8][6] ) );
  SDFFRQX2M \Registers_reg[8][5]  ( .D(n255), .SI(\Registers[8][4] ), .SE(n470), .CK(clk), .RN(n445), .Q(\Registers[8][5] ) );
  SDFFRQX2M \Registers_reg[8][4]  ( .D(n254), .SI(\Registers[8][3] ), .SE(n469), .CK(clk), .RN(n445), .Q(\Registers[8][4] ) );
  SDFFRQX2M \Registers_reg[8][3]  ( .D(n253), .SI(\Registers[8][2] ), .SE(n468), .CK(clk), .RN(n444), .Q(\Registers[8][3] ) );
  SDFFRQX2M \Registers_reg[8][2]  ( .D(n252), .SI(\Registers[8][1] ), .SE(n470), .CK(clk), .RN(n444), .Q(\Registers[8][2] ) );
  SDFFRQX2M \Registers_reg[8][1]  ( .D(n251), .SI(\Registers[8][0] ), .SE(n469), .CK(clk), .RN(n444), .Q(\Registers[8][1] ) );
  SDFFRQX2M \Registers_reg[8][0]  ( .D(n250), .SI(\Registers[7][7] ), .SE(n468), .CK(clk), .RN(n444), .Q(\Registers[8][0] ) );
  SDFFRQX2M \Registers_reg[6][7]  ( .D(n241), .SI(\Registers[6][6] ), .SE(n479), .CK(clk), .RN(n443), .Q(\Registers[6][7] ) );
  SDFFRQX2M \Registers_reg[6][6]  ( .D(n240), .SI(\Registers[6][5] ), .SE(n481), .CK(clk), .RN(n443), .Q(\Registers[6][6] ) );
  SDFFRQX2M \Registers_reg[6][5]  ( .D(n239), .SI(\Registers[6][4] ), .SE(n479), .CK(clk), .RN(n443), .Q(\Registers[6][5] ) );
  SDFFRQX2M \Registers_reg[6][4]  ( .D(n238), .SI(\Registers[6][3] ), .SE(n481), .CK(clk), .RN(n443), .Q(\Registers[6][4] ) );
  SDFFRQX2M \Registers_reg[6][3]  ( .D(n237), .SI(\Registers[6][2] ), .SE(n479), .CK(clk), .RN(n443), .Q(\Registers[6][3] ) );
  SDFFRQX2M \Registers_reg[6][2]  ( .D(n236), .SI(test_si2), .SE(n481), .CK(
        clk), .RN(n443), .Q(\Registers[6][2] ) );
  SDFFRQX2M \Registers_reg[6][1]  ( .D(n235), .SI(\Registers[6][0] ), .SE(n479), .CK(clk), .RN(n443), .Q(\Registers[6][1] ) );
  SDFFRQX2M \Registers_reg[6][0]  ( .D(n234), .SI(\Registers[5][7] ), .SE(n470), .CK(clk), .RN(n443), .Q(\Registers[6][0] ) );
  SDFFRQX2M \Registers_reg[4][7]  ( .D(n225), .SI(\Registers[4][6] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][7] ) );
  SDFFRQX2M \Registers_reg[4][6]  ( .D(n224), .SI(\Registers[4][5] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][6] ) );
  SDFFRQX2M \Registers_reg[4][5]  ( .D(n223), .SI(\Registers[4][4] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][5] ) );
  SDFFRQX2M \Registers_reg[4][4]  ( .D(n222), .SI(\Registers[4][3] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][4] ) );
  SDFFRQX2M \Registers_reg[4][3]  ( .D(n221), .SI(\Registers[4][2] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][3] ) );
  SDFFRQX2M \Registers_reg[4][2]  ( .D(n220), .SI(\Registers[4][1] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][2] ) );
  SDFFRQX2M \Registers_reg[4][1]  ( .D(n219), .SI(\Registers[4][0] ), .SE(n477), .CK(clk), .RN(n442), .Q(\Registers[4][1] ) );
  SDFFRQX2M \Registers_reg[4][0]  ( .D(n218), .SI(REG3[7]), .SE(n467), .CK(clk), .RN(n442), .Q(\Registers[4][0] ) );
  SDFFSQX2M \Registers_reg[2][0]  ( .D(n202), .SI(REG1[7]), .SE(n475), .CK(clk), .SN(n439), .Q(REG2[0]) );
  SDFFRQX2M \Registers_reg[2][1]  ( .D(n203), .SI(REG2[0]), .SE(n474), .CK(clk), .RN(n441), .Q(REG2[1]) );
  SDFFRQX2M Rd_Data_Valid_reg ( .D(n185), .SI(RdData[7]), .SE(n471), .CK(clk), 
        .RN(n439), .Q(Rd_Data_Valid) );
  SDFFSQX2M \Registers_reg[3][5]  ( .D(n215), .SI(REG3[4]), .SE(n476), .CK(clk), .SN(n439), .Q(REG3[5]) );
  SDFFRQX2M \Registers_reg[3][0]  ( .D(n210), .SI(n490), .SE(n476), .CK(clk), 
        .RN(n441), .Q(REG3[0]) );
  SDFFRQX2M \Registers_reg[3][4]  ( .D(n214), .SI(REG3[3]), .SE(n472), .CK(clk), .RN(n441), .Q(REG3[4]) );
  SDFFRQX2M \Registers_reg[3][2]  ( .D(n212), .SI(REG3[1]), .SE(n466), .CK(clk), .RN(n441), .Q(REG3[2]) );
  SDFFRQX2M \Registers_reg[3][3]  ( .D(n213), .SI(REG3[2]), .SE(n476), .CK(clk), .RN(n441), .Q(REG3[3]) );
  SDFFRQX2M \Registers_reg[3][7]  ( .D(n217), .SI(REG3[6]), .SE(n471), .CK(clk), .RN(n442), .Q(REG3[7]) );
  SDFFRQX2M \Registers_reg[3][6]  ( .D(n216), .SI(REG3[5]), .SE(n476), .CK(clk), .RN(n442), .Q(REG3[6]) );
  SDFFRQX2M \Registers_reg[3][1]  ( .D(n211), .SI(REG3[0]), .SE(n473), .CK(clk), .RN(n441), .Q(REG3[1]) );
  SDFFRQX2M \Registers_reg[0][1]  ( .D(n187), .SI(REG0[0]), .SE(n466), .CK(clk), .RN(n439), .Q(REG0[1]) );
  SDFFRQX2M \Registers_reg[0][0]  ( .D(n186), .SI(Rd_Data_Valid), .SE(n475), 
        .CK(clk), .RN(n439), .Q(REG0[0]) );
  SDFFRQX2M \Registers_reg[0][2]  ( .D(n188), .SI(REG0[1]), .SE(n473), .CK(clk), .RN(n440), .Q(REG0[2]) );
  SDFFRQX2M \Registers_reg[0][3]  ( .D(n189), .SI(REG0[2]), .SE(n472), .CK(clk), .RN(n440), .Q(REG0[3]) );
  SDFFRQX2M \Registers_reg[0][4]  ( .D(n190), .SI(REG0[3]), .SE(n474), .CK(clk), .RN(n440), .Q(REG0[4]) );
  SDFFRQX2M \Registers_reg[0][5]  ( .D(n191), .SI(REG0[4]), .SE(n472), .CK(clk), .RN(n440), .Q(REG0[5]) );
  SDFFRQX2M \Registers_reg[0][6]  ( .D(n192), .SI(REG0[5]), .SE(n466), .CK(clk), .RN(n440), .Q(REG0[6]) );
  SDFFRQX2M \Registers_reg[0][7]  ( .D(n193), .SI(REG0[6]), .SE(n471), .CK(clk), .RN(n440), .Q(REG0[7]) );
  SDFFSQX2M \Registers_reg[2][7]  ( .D(n209), .SI(REG2[6]), .SE(n466), .CK(clk), .SN(n439), .Q(REG2[7]) );
  SDFFRQX2M \Registers_reg[1][2]  ( .D(n196), .SI(REG1[1]), .SE(n473), .CK(clk), .RN(n440), .Q(REG1[2]) );
  SDFFRQX2M \Registers_reg[1][1]  ( .D(n195), .SI(REG1[0]), .SE(n474), .CK(clk), .RN(n440), .Q(REG1[1]) );
  SDFFRQX2M \Registers_reg[1][3]  ( .D(n197), .SI(REG1[2]), .SE(n474), .CK(clk), .RN(n440), .Q(REG1[3]) );
  SDFFRQX2M \Registers_reg[1][5]  ( .D(n199), .SI(REG1[4]), .SE(n475), .CK(clk), .RN(n441), .Q(REG1[5]) );
  SDFFRQX2M \Registers_reg[1][4]  ( .D(n198), .SI(REG1[3]), .SE(n466), .CK(clk), .RN(n440), .Q(REG1[4]) );
  SDFFRQX2M \Registers_reg[1][0]  ( .D(n194), .SI(REG0[7]), .SE(n473), .CK(clk), .RN(n440), .Q(REG1[0]) );
  SDFFRQX2M \Registers_reg[1][7]  ( .D(n201), .SI(REG1[6]), .SE(n466), .CK(clk), .RN(n440), .Q(REG1[7]) );
  SDFFRQX2M \Registers_reg[1][6]  ( .D(n200), .SI(REG1[5]), .SE(n471), .CK(clk), .RN(n441), .Q(REG1[6]) );
  NOR2BX2M U140 ( .AN(n175), .B(N10), .Y(n167) );
  NOR2BX2M U141 ( .AN(n164), .B(N10), .Y(n153) );
  NOR2BX2M U142 ( .AN(N12), .B(n409), .Y(n163) );
  NOR2X2M U143 ( .A(n409), .B(N12), .Y(n157) );
  NOR2BX2M U144 ( .AN(N12), .B(N11), .Y(n160) );
  NOR2X2M U145 ( .A(N11), .B(N12), .Y(n152) );
  BUFX2M U146 ( .A(n396), .Y(n413) );
  BUFX2M U147 ( .A(n396), .Y(n412) );
  BUFX2M U148 ( .A(n396), .Y(n411) );
  BUFX2M U149 ( .A(n156), .Y(n436) );
  BUFX2M U150 ( .A(n159), .Y(n434) );
  BUFX2M U151 ( .A(n162), .Y(n432) );
  BUFX2M U152 ( .A(n166), .Y(n430) );
  BUFX2M U153 ( .A(n170), .Y(n428) );
  BUFX2M U154 ( .A(n154), .Y(n437) );
  BUFX2M U155 ( .A(n168), .Y(n429) );
  BUFX2M U156 ( .A(n171), .Y(n427) );
  BUFX2M U157 ( .A(n173), .Y(n425) );
  BUFX2M U158 ( .A(n158), .Y(n435) );
  BUFX2M U159 ( .A(n161), .Y(n433) );
  BUFX2M U160 ( .A(n151), .Y(n438) );
  BUFX2M U161 ( .A(n165), .Y(n431) );
  INVX2M U162 ( .A(n149), .Y(n454) );
  BUFX4M U163 ( .A(n452), .Y(n440) );
  BUFX4M U164 ( .A(n450), .Y(n441) );
  BUFX4M U165 ( .A(n452), .Y(n442) );
  BUFX4M U166 ( .A(n453), .Y(n443) );
  BUFX4M U167 ( .A(n450), .Y(n444) );
  BUFX4M U168 ( .A(n450), .Y(n445) );
  BUFX4M U169 ( .A(n453), .Y(n446) );
  BUFX4M U170 ( .A(n451), .Y(n447) );
  BUFX4M U171 ( .A(n451), .Y(n448) );
  BUFX2M U172 ( .A(n453), .Y(n449) );
  BUFX2M U173 ( .A(n398), .Y(n419) );
  BUFX2M U174 ( .A(n398), .Y(n418) );
  BUFX2M U175 ( .A(n398), .Y(n417) );
  BUFX2M U176 ( .A(n397), .Y(n416) );
  BUFX2M U177 ( .A(n399), .Y(n422) );
  BUFX2M U178 ( .A(n397), .Y(n415) );
  BUFX2M U179 ( .A(n399), .Y(n421) );
  BUFX2M U180 ( .A(n397), .Y(n414) );
  BUFX2M U181 ( .A(n399), .Y(n420) );
  NOR2BX2M U182 ( .AN(n164), .B(n410), .Y(n155) );
  NOR2BX2M U183 ( .AN(n175), .B(n410), .Y(n169) );
  BUFX4M U184 ( .A(n172), .Y(n426) );
  NAND2X2M U185 ( .A(n167), .B(n160), .Y(n172) );
  BUFX4M U186 ( .A(n174), .Y(n424) );
  NAND2X2M U187 ( .A(n167), .B(n163), .Y(n174) );
  NAND2X2M U188 ( .A(n167), .B(n152), .Y(n166) );
  NAND2X2M U189 ( .A(n167), .B(n157), .Y(n170) );
  NAND2X2M U190 ( .A(n155), .B(n152), .Y(n154) );
  NAND2X2M U191 ( .A(n160), .B(n153), .Y(n159) );
  NAND2X2M U192 ( .A(n160), .B(n155), .Y(n161) );
  NAND2X2M U193 ( .A(n163), .B(n153), .Y(n162) );
  NAND2X2M U194 ( .A(n163), .B(n155), .Y(n165) );
  NAND2X2M U195 ( .A(n169), .B(n152), .Y(n168) );
  NAND2X2M U196 ( .A(n169), .B(n157), .Y(n171) );
  NAND2X2M U197 ( .A(n169), .B(n160), .Y(n173) );
  NAND2X2M U198 ( .A(n152), .B(n153), .Y(n151) );
  NAND2X2M U199 ( .A(n157), .B(n153), .Y(n156) );
  NAND2X2M U200 ( .A(n157), .B(n155), .Y(n158) );
  BUFX4M U201 ( .A(n176), .Y(n423) );
  NAND2X2M U202 ( .A(n169), .B(n163), .Y(n176) );
  NAND2BX2M U203 ( .AN(WrEn), .B(RdEn), .Y(n149) );
  NOR2BX2M U204 ( .AN(WrEn), .B(RdEn), .Y(n150) );
  BUFX4M U205 ( .A(n451), .Y(n439) );
  BUFX2M U206 ( .A(n452), .Y(n451) );
  BUFX2M U207 ( .A(n453), .Y(n450) );
  INVX2M U208 ( .A(N10), .Y(n410) );
  INVX2M U209 ( .A(N12), .Y(n408) );
  INVX2M U210 ( .A(N11), .Y(n409) );
  NOR2BX2M U211 ( .AN(n150), .B(N13), .Y(n164) );
  INVX2M U212 ( .A(N13), .Y(n407) );
  AND2X2M U213 ( .A(N13), .B(n150), .Y(n175) );
  INVX4M U214 ( .A(WrData[0]), .Y(n462) );
  INVX4M U215 ( .A(WrData[1]), .Y(n461) );
  INVX4M U216 ( .A(WrData[2]), .Y(n460) );
  INVX4M U217 ( .A(WrData[3]), .Y(n459) );
  INVX4M U218 ( .A(WrData[4]), .Y(n458) );
  INVX4M U219 ( .A(WrData[5]), .Y(n457) );
  INVX4M U220 ( .A(WrData[6]), .Y(n456) );
  INVX4M U221 ( .A(WrData[7]), .Y(n455) );
  BUFX2M U222 ( .A(rst), .Y(n453) );
  BUFX2M U223 ( .A(rst), .Y(n452) );
  AO22X1M U224 ( .A0(N42), .A1(n454), .B0(RdData[0]), .B1(n149), .Y(n177) );
  AO22X1M U225 ( .A0(N41), .A1(n454), .B0(RdData[1]), .B1(n149), .Y(n178) );
  AO22X1M U226 ( .A0(N38), .A1(n454), .B0(RdData[4]), .B1(n149), .Y(n181) );
  AO22X1M U227 ( .A0(N37), .A1(n454), .B0(RdData[5]), .B1(n149), .Y(n182) );
  AO22X1M U228 ( .A0(N36), .A1(n454), .B0(RdData[6]), .B1(n149), .Y(n183) );
  AO22X1M U229 ( .A0(N35), .A1(n454), .B0(RdData[7]), .B1(n149), .Y(n184) );
  AO22X1M U230 ( .A0(N40), .A1(n454), .B0(RdData[2]), .B1(n149), .Y(n179) );
  AO22X1M U231 ( .A0(N39), .A1(n454), .B0(RdData[3]), .B1(n149), .Y(n180) );
  OAI2BB2X1M U232 ( .B0(n438), .B1(n462), .A0N(REG0[0]), .A1N(n438), .Y(n186)
         );
  OAI2BB2X1M U233 ( .B0(n438), .B1(n461), .A0N(REG0[1]), .A1N(n438), .Y(n187)
         );
  OAI2BB2X1M U234 ( .B0(n438), .B1(n460), .A0N(REG0[2]), .A1N(n438), .Y(n188)
         );
  OAI2BB2X1M U235 ( .B0(n151), .B1(n459), .A0N(REG0[3]), .A1N(n438), .Y(n189)
         );
  OAI2BB2X1M U236 ( .B0(n151), .B1(n458), .A0N(REG0[4]), .A1N(n438), .Y(n190)
         );
  OAI2BB2X1M U237 ( .B0(n151), .B1(n457), .A0N(REG0[5]), .A1N(n438), .Y(n191)
         );
  OAI2BB2X1M U238 ( .B0(n151), .B1(n456), .A0N(REG0[6]), .A1N(n438), .Y(n192)
         );
  OAI2BB2X1M U239 ( .B0(n151), .B1(n455), .A0N(REG0[7]), .A1N(n438), .Y(n193)
         );
  OAI2BB2X1M U240 ( .B0(n462), .B1(n437), .A0N(REG1[0]), .A1N(n437), .Y(n194)
         );
  OAI2BB2X1M U241 ( .B0(n461), .B1(n437), .A0N(REG1[1]), .A1N(n437), .Y(n195)
         );
  OAI2BB2X1M U242 ( .B0(n460), .B1(n437), .A0N(REG1[2]), .A1N(n437), .Y(n196)
         );
  OAI2BB2X1M U243 ( .B0(n459), .B1(n154), .A0N(REG1[3]), .A1N(n437), .Y(n197)
         );
  OAI2BB2X1M U244 ( .B0(n458), .B1(n154), .A0N(REG1[4]), .A1N(n437), .Y(n198)
         );
  OAI2BB2X1M U245 ( .B0(n457), .B1(n154), .A0N(REG1[5]), .A1N(n437), .Y(n199)
         );
  OAI2BB2X1M U246 ( .B0(n456), .B1(n154), .A0N(REG1[6]), .A1N(n437), .Y(n200)
         );
  OAI2BB2X1M U247 ( .B0(n455), .B1(n154), .A0N(REG1[7]), .A1N(n437), .Y(n201)
         );
  OAI2BB2X1M U248 ( .B0(n461), .B1(n156), .A0N(REG2[1]), .A1N(n436), .Y(n203)
         );
  OAI2BB2X1M U249 ( .B0(n460), .B1(n436), .A0N(REG2[2]), .A1N(n436), .Y(n204)
         );
  OAI2BB2X1M U250 ( .B0(n459), .B1(n156), .A0N(REG2[3]), .A1N(n436), .Y(n205)
         );
  OAI2BB2X1M U251 ( .B0(n458), .B1(n156), .A0N(REG2[4]), .A1N(n436), .Y(n206)
         );
  OAI2BB2X1M U252 ( .B0(n457), .B1(n156), .A0N(REG2[5]), .A1N(n436), .Y(n207)
         );
  OAI2BB2X1M U253 ( .B0(n456), .B1(n156), .A0N(REG2[6]), .A1N(n436), .Y(n208)
         );
  OAI2BB2X1M U254 ( .B0(n462), .B1(n435), .A0N(REG3[0]), .A1N(n435), .Y(n210)
         );
  OAI2BB2X1M U255 ( .B0(n461), .B1(n435), .A0N(REG3[1]), .A1N(n435), .Y(n211)
         );
  OAI2BB2X1M U256 ( .B0(n460), .B1(n158), .A0N(REG3[2]), .A1N(n435), .Y(n212)
         );
  OAI2BB2X1M U257 ( .B0(n459), .B1(n158), .A0N(REG3[3]), .A1N(n435), .Y(n213)
         );
  OAI2BB2X1M U258 ( .B0(n458), .B1(n158), .A0N(REG3[4]), .A1N(n435), .Y(n214)
         );
  OAI2BB2X1M U259 ( .B0(n456), .B1(n158), .A0N(REG3[6]), .A1N(n435), .Y(n216)
         );
  OAI2BB2X1M U260 ( .B0(n455), .B1(n158), .A0N(REG3[7]), .A1N(n435), .Y(n217)
         );
  OAI2BB2X1M U261 ( .B0(n462), .B1(n434), .A0N(\Registers[4][0] ), .A1N(n434), 
        .Y(n218) );
  OAI2BB2X1M U262 ( .B0(n461), .B1(n434), .A0N(\Registers[4][1] ), .A1N(n434), 
        .Y(n219) );
  OAI2BB2X1M U263 ( .B0(n460), .B1(n434), .A0N(\Registers[4][2] ), .A1N(n434), 
        .Y(n220) );
  OAI2BB2X1M U264 ( .B0(n459), .B1(n159), .A0N(\Registers[4][3] ), .A1N(n434), 
        .Y(n221) );
  OAI2BB2X1M U265 ( .B0(n458), .B1(n159), .A0N(\Registers[4][4] ), .A1N(n434), 
        .Y(n222) );
  OAI2BB2X1M U266 ( .B0(n457), .B1(n159), .A0N(\Registers[4][5] ), .A1N(n434), 
        .Y(n223) );
  OAI2BB2X1M U267 ( .B0(n456), .B1(n159), .A0N(\Registers[4][6] ), .A1N(n434), 
        .Y(n224) );
  OAI2BB2X1M U268 ( .B0(n455), .B1(n159), .A0N(\Registers[4][7] ), .A1N(n434), 
        .Y(n225) );
  OAI2BB2X1M U269 ( .B0(n462), .B1(n433), .A0N(\Registers[5][0] ), .A1N(n433), 
        .Y(n226) );
  OAI2BB2X1M U270 ( .B0(n461), .B1(n433), .A0N(\Registers[5][1] ), .A1N(n433), 
        .Y(n227) );
  OAI2BB2X1M U271 ( .B0(n460), .B1(n433), .A0N(\Registers[5][2] ), .A1N(n433), 
        .Y(n228) );
  OAI2BB2X1M U272 ( .B0(n459), .B1(n161), .A0N(\Registers[5][3] ), .A1N(n433), 
        .Y(n229) );
  OAI2BB2X1M U273 ( .B0(n458), .B1(n161), .A0N(\Registers[5][4] ), .A1N(n433), 
        .Y(n230) );
  OAI2BB2X1M U274 ( .B0(n457), .B1(n161), .A0N(\Registers[5][5] ), .A1N(n433), 
        .Y(n231) );
  OAI2BB2X1M U275 ( .B0(n456), .B1(n161), .A0N(\Registers[5][6] ), .A1N(n433), 
        .Y(n232) );
  OAI2BB2X1M U276 ( .B0(n455), .B1(n161), .A0N(\Registers[5][7] ), .A1N(n433), 
        .Y(n233) );
  OAI2BB2X1M U277 ( .B0(n462), .B1(n432), .A0N(\Registers[6][0] ), .A1N(n432), 
        .Y(n234) );
  OAI2BB2X1M U278 ( .B0(n461), .B1(n432), .A0N(\Registers[6][1] ), .A1N(n432), 
        .Y(n235) );
  OAI2BB2X1M U279 ( .B0(n460), .B1(n432), .A0N(\Registers[6][2] ), .A1N(n432), 
        .Y(n236) );
  OAI2BB2X1M U280 ( .B0(n459), .B1(n162), .A0N(\Registers[6][3] ), .A1N(n432), 
        .Y(n237) );
  OAI2BB2X1M U281 ( .B0(n458), .B1(n162), .A0N(\Registers[6][4] ), .A1N(n432), 
        .Y(n238) );
  OAI2BB2X1M U282 ( .B0(n457), .B1(n162), .A0N(\Registers[6][5] ), .A1N(n432), 
        .Y(n239) );
  OAI2BB2X1M U283 ( .B0(n456), .B1(n162), .A0N(\Registers[6][6] ), .A1N(n432), 
        .Y(n240) );
  OAI2BB2X1M U284 ( .B0(n455), .B1(n162), .A0N(\Registers[6][7] ), .A1N(n432), 
        .Y(n241) );
  OAI2BB2X1M U285 ( .B0(n462), .B1(n431), .A0N(\Registers[7][0] ), .A1N(n431), 
        .Y(n242) );
  OAI2BB2X1M U286 ( .B0(n461), .B1(n431), .A0N(\Registers[7][1] ), .A1N(n431), 
        .Y(n243) );
  OAI2BB2X1M U287 ( .B0(n460), .B1(n431), .A0N(\Registers[7][2] ), .A1N(n431), 
        .Y(n244) );
  OAI2BB2X1M U288 ( .B0(n459), .B1(n165), .A0N(\Registers[7][3] ), .A1N(n431), 
        .Y(n245) );
  OAI2BB2X1M U289 ( .B0(n458), .B1(n165), .A0N(\Registers[7][4] ), .A1N(n431), 
        .Y(n246) );
  OAI2BB2X1M U290 ( .B0(n457), .B1(n165), .A0N(\Registers[7][5] ), .A1N(n431), 
        .Y(n247) );
  OAI2BB2X1M U291 ( .B0(n456), .B1(n165), .A0N(\Registers[7][6] ), .A1N(n431), 
        .Y(n248) );
  OAI2BB2X1M U292 ( .B0(n455), .B1(n165), .A0N(\Registers[7][7] ), .A1N(n431), 
        .Y(n249) );
  OAI2BB2X1M U293 ( .B0(n462), .B1(n430), .A0N(\Registers[8][0] ), .A1N(n430), 
        .Y(n250) );
  OAI2BB2X1M U294 ( .B0(n461), .B1(n430), .A0N(\Registers[8][1] ), .A1N(n430), 
        .Y(n251) );
  OAI2BB2X1M U295 ( .B0(n460), .B1(n430), .A0N(\Registers[8][2] ), .A1N(n430), 
        .Y(n252) );
  OAI2BB2X1M U296 ( .B0(n459), .B1(n166), .A0N(\Registers[8][3] ), .A1N(n430), 
        .Y(n253) );
  OAI2BB2X1M U297 ( .B0(n458), .B1(n166), .A0N(\Registers[8][4] ), .A1N(n430), 
        .Y(n254) );
  OAI2BB2X1M U298 ( .B0(n457), .B1(n166), .A0N(\Registers[8][5] ), .A1N(n430), 
        .Y(n255) );
  OAI2BB2X1M U299 ( .B0(n456), .B1(n166), .A0N(\Registers[8][6] ), .A1N(n430), 
        .Y(n256) );
  OAI2BB2X1M U300 ( .B0(n455), .B1(n166), .A0N(\Registers[8][7] ), .A1N(n430), 
        .Y(n257) );
  OAI2BB2X1M U301 ( .B0(n462), .B1(n429), .A0N(\Registers[9][0] ), .A1N(n429), 
        .Y(n258) );
  OAI2BB2X1M U302 ( .B0(n461), .B1(n429), .A0N(\Registers[9][1] ), .A1N(n429), 
        .Y(n259) );
  OAI2BB2X1M U303 ( .B0(n460), .B1(n429), .A0N(\Registers[9][2] ), .A1N(n429), 
        .Y(n260) );
  OAI2BB2X1M U304 ( .B0(n459), .B1(n168), .A0N(\Registers[9][3] ), .A1N(n429), 
        .Y(n261) );
  OAI2BB2X1M U305 ( .B0(n458), .B1(n168), .A0N(\Registers[9][4] ), .A1N(n429), 
        .Y(n262) );
  OAI2BB2X1M U306 ( .B0(n457), .B1(n168), .A0N(\Registers[9][5] ), .A1N(n429), 
        .Y(n263) );
  OAI2BB2X1M U307 ( .B0(n456), .B1(n168), .A0N(\Registers[9][6] ), .A1N(n429), 
        .Y(n264) );
  OAI2BB2X1M U308 ( .B0(n455), .B1(n168), .A0N(\Registers[9][7] ), .A1N(n429), 
        .Y(n265) );
  OAI2BB2X1M U309 ( .B0(n462), .B1(n428), .A0N(\Registers[10][0] ), .A1N(n428), 
        .Y(n266) );
  OAI2BB2X1M U310 ( .B0(n461), .B1(n428), .A0N(\Registers[10][1] ), .A1N(n428), 
        .Y(n267) );
  OAI2BB2X1M U311 ( .B0(n460), .B1(n428), .A0N(\Registers[10][2] ), .A1N(n428), 
        .Y(n268) );
  OAI2BB2X1M U312 ( .B0(n459), .B1(n170), .A0N(\Registers[10][3] ), .A1N(n428), 
        .Y(n269) );
  OAI2BB2X1M U313 ( .B0(n458), .B1(n170), .A0N(\Registers[10][4] ), .A1N(n428), 
        .Y(n270) );
  OAI2BB2X1M U314 ( .B0(n457), .B1(n170), .A0N(\Registers[10][5] ), .A1N(n428), 
        .Y(n271) );
  OAI2BB2X1M U315 ( .B0(n456), .B1(n170), .A0N(\Registers[10][6] ), .A1N(n428), 
        .Y(n272) );
  OAI2BB2X1M U316 ( .B0(n455), .B1(n170), .A0N(\Registers[10][7] ), .A1N(n428), 
        .Y(n273) );
  OAI2BB2X1M U317 ( .B0(n462), .B1(n427), .A0N(\Registers[11][0] ), .A1N(n427), 
        .Y(n274) );
  OAI2BB2X1M U318 ( .B0(n461), .B1(n427), .A0N(\Registers[11][1] ), .A1N(n427), 
        .Y(n275) );
  OAI2BB2X1M U319 ( .B0(n460), .B1(n427), .A0N(\Registers[11][2] ), .A1N(n427), 
        .Y(n276) );
  OAI2BB2X1M U320 ( .B0(n459), .B1(n171), .A0N(\Registers[11][3] ), .A1N(n427), 
        .Y(n277) );
  OAI2BB2X1M U321 ( .B0(n458), .B1(n171), .A0N(\Registers[11][4] ), .A1N(n427), 
        .Y(n278) );
  OAI2BB2X1M U322 ( .B0(n457), .B1(n171), .A0N(\Registers[11][5] ), .A1N(n427), 
        .Y(n279) );
  OAI2BB2X1M U323 ( .B0(n456), .B1(n171), .A0N(\Registers[11][6] ), .A1N(n427), 
        .Y(n280) );
  OAI2BB2X1M U324 ( .B0(n455), .B1(n171), .A0N(\Registers[11][7] ), .A1N(n427), 
        .Y(n281) );
  OAI2BB2X1M U325 ( .B0(n462), .B1(n426), .A0N(\Registers[12][0] ), .A1N(n426), 
        .Y(n282) );
  OAI2BB2X1M U326 ( .B0(n461), .B1(n426), .A0N(\Registers[12][1] ), .A1N(n426), 
        .Y(n283) );
  OAI2BB2X1M U327 ( .B0(n460), .B1(n426), .A0N(\Registers[12][2] ), .A1N(n426), 
        .Y(n284) );
  OAI2BB2X1M U328 ( .B0(n459), .B1(n426), .A0N(\Registers[12][3] ), .A1N(n426), 
        .Y(n285) );
  OAI2BB2X1M U329 ( .B0(n458), .B1(n426), .A0N(\Registers[12][4] ), .A1N(n426), 
        .Y(n286) );
  OAI2BB2X1M U330 ( .B0(n457), .B1(n426), .A0N(\Registers[12][5] ), .A1N(n426), 
        .Y(n287) );
  OAI2BB2X1M U331 ( .B0(n456), .B1(n426), .A0N(\Registers[12][6] ), .A1N(n426), 
        .Y(n288) );
  OAI2BB2X1M U332 ( .B0(n455), .B1(n426), .A0N(\Registers[12][7] ), .A1N(n426), 
        .Y(n289) );
  OAI2BB2X1M U333 ( .B0(n462), .B1(n425), .A0N(\Registers[13][0] ), .A1N(n425), 
        .Y(n290) );
  OAI2BB2X1M U334 ( .B0(n461), .B1(n425), .A0N(\Registers[13][1] ), .A1N(n425), 
        .Y(n291) );
  OAI2BB2X1M U335 ( .B0(n460), .B1(n425), .A0N(\Registers[13][2] ), .A1N(n425), 
        .Y(n292) );
  OAI2BB2X1M U336 ( .B0(n459), .B1(n173), .A0N(\Registers[13][3] ), .A1N(n425), 
        .Y(n293) );
  OAI2BB2X1M U337 ( .B0(n458), .B1(n173), .A0N(\Registers[13][4] ), .A1N(n425), 
        .Y(n294) );
  OAI2BB2X1M U338 ( .B0(n457), .B1(n173), .A0N(\Registers[13][5] ), .A1N(n425), 
        .Y(n295) );
  OAI2BB2X1M U339 ( .B0(n456), .B1(n173), .A0N(\Registers[13][6] ), .A1N(n425), 
        .Y(n296) );
  OAI2BB2X1M U340 ( .B0(n455), .B1(n173), .A0N(\Registers[13][7] ), .A1N(n425), 
        .Y(n297) );
  OAI2BB2X1M U341 ( .B0(n462), .B1(n424), .A0N(\Registers[14][0] ), .A1N(n424), 
        .Y(n298) );
  OAI2BB2X1M U342 ( .B0(n461), .B1(n424), .A0N(\Registers[14][1] ), .A1N(n424), 
        .Y(n299) );
  OAI2BB2X1M U343 ( .B0(n460), .B1(n424), .A0N(\Registers[14][2] ), .A1N(n424), 
        .Y(n300) );
  OAI2BB2X1M U344 ( .B0(n459), .B1(n424), .A0N(\Registers[14][3] ), .A1N(n424), 
        .Y(n301) );
  OAI2BB2X1M U345 ( .B0(n458), .B1(n424), .A0N(\Registers[14][4] ), .A1N(n424), 
        .Y(n302) );
  OAI2BB2X1M U346 ( .B0(n457), .B1(n424), .A0N(\Registers[14][5] ), .A1N(n424), 
        .Y(n303) );
  OAI2BB2X1M U347 ( .B0(n456), .B1(n424), .A0N(\Registers[14][6] ), .A1N(n424), 
        .Y(n304) );
  OAI2BB2X1M U348 ( .B0(n455), .B1(n424), .A0N(\Registers[14][7] ), .A1N(n424), 
        .Y(n305) );
  OAI2BB2X1M U349 ( .B0(n462), .B1(n423), .A0N(\Registers[15][0] ), .A1N(n423), 
        .Y(n306) );
  OAI2BB2X1M U350 ( .B0(n461), .B1(n423), .A0N(\Registers[15][1] ), .A1N(n423), 
        .Y(n307) );
  OAI2BB2X1M U351 ( .B0(n460), .B1(n423), .A0N(\Registers[15][2] ), .A1N(n423), 
        .Y(n308) );
  OAI2BB2X1M U352 ( .B0(n459), .B1(n423), .A0N(\Registers[15][3] ), .A1N(n423), 
        .Y(n309) );
  OAI2BB2X1M U353 ( .B0(n458), .B1(n423), .A0N(\Registers[15][4] ), .A1N(n423), 
        .Y(n310) );
  OAI2BB2X1M U354 ( .B0(n457), .B1(n423), .A0N(\Registers[15][5] ), .A1N(n423), 
        .Y(n311) );
  OAI2BB2X1M U355 ( .B0(n456), .B1(n423), .A0N(\Registers[15][6] ), .A1N(n423), 
        .Y(n312) );
  OAI2BB2X1M U356 ( .B0(n455), .B1(n423), .A0N(\Registers[15][7] ), .A1N(n423), 
        .Y(n313) );
  OAI2BB2X1M U357 ( .B0(n462), .B1(n436), .A0N(REG2[0]), .A1N(n436), .Y(n202)
         );
  OAI2BB2X1M U358 ( .B0(n455), .B1(n436), .A0N(n490), .A1N(n436), .Y(n209) );
  OAI2BB2X1M U359 ( .B0(n457), .B1(n435), .A0N(REG3[5]), .A1N(n435), .Y(n215)
         );
  OAI2BB1X2M U360 ( .A0N(Rd_Data_Valid), .A1N(n150), .B0(n149), .Y(n185) );
  NOR2X1M U361 ( .A(n409), .B(N10), .Y(n397) );
  NOR2X1M U362 ( .A(n409), .B(n410), .Y(n396) );
  AOI22X1M U363 ( .A0(\Registers[10][0] ), .A1(n416), .B0(\Registers[11][0] ), 
        .B1(n413), .Y(n139) );
  NOR2X1M U364 ( .A(N10), .B(N11), .Y(n399) );
  NOR2X1M U365 ( .A(n410), .B(N11), .Y(n398) );
  AOI22X1M U366 ( .A0(\Registers[8][0] ), .A1(n422), .B0(\Registers[9][0] ), 
        .B1(n419), .Y(n138) );
  CLKNAND2X2M U367 ( .A(N13), .B(n408), .Y(n387) );
  AOI21X1M U368 ( .A0(n139), .A1(n138), .B0(n387), .Y(n314) );
  AOI22X1M U369 ( .A0(\Registers[14][0] ), .A1(n416), .B0(\Registers[15][0] ), 
        .B1(n413), .Y(n141) );
  AOI22X1M U370 ( .A0(\Registers[12][0] ), .A1(n422), .B0(\Registers[13][0] ), 
        .B1(n419), .Y(n140) );
  CLKNAND2X2M U371 ( .A(N13), .B(N12), .Y(n390) );
  AOI21X1M U372 ( .A0(n141), .A1(n140), .B0(n390), .Y(n148) );
  AOI22X1M U373 ( .A0(REG2[0]), .A1(n416), .B0(REG3[0]), .B1(n413), .Y(n143)
         );
  AOI22X1M U374 ( .A0(REG0[0]), .A1(n422), .B0(REG1[0]), .B1(n419), .Y(n142)
         );
  CLKNAND2X2M U375 ( .A(n408), .B(n407), .Y(n393) );
  AOI21X1M U376 ( .A0(n143), .A1(n142), .B0(n393), .Y(n147) );
  AOI22X1M U377 ( .A0(\Registers[6][0] ), .A1(n416), .B0(\Registers[7][0] ), 
        .B1(n413), .Y(n145) );
  AOI22X1M U378 ( .A0(\Registers[4][0] ), .A1(n422), .B0(\Registers[5][0] ), 
        .B1(n419), .Y(n144) );
  CLKNAND2X2M U379 ( .A(N12), .B(n407), .Y(n400) );
  AOI21X1M U380 ( .A0(n145), .A1(n144), .B0(n400), .Y(n146) );
  OR4X1M U381 ( .A(n314), .B(n148), .C(n147), .D(n146), .Y(N42) );
  AOI22X1M U382 ( .A0(\Registers[10][1] ), .A1(n416), .B0(\Registers[11][1] ), 
        .B1(n413), .Y(n316) );
  AOI22X1M U383 ( .A0(\Registers[8][1] ), .A1(n422), .B0(\Registers[9][1] ), 
        .B1(n419), .Y(n315) );
  AOI21X1M U384 ( .A0(n316), .A1(n315), .B0(n387), .Y(n326) );
  AOI22X1M U385 ( .A0(\Registers[14][1] ), .A1(n416), .B0(\Registers[15][1] ), 
        .B1(n413), .Y(n318) );
  AOI22X1M U386 ( .A0(\Registers[12][1] ), .A1(n422), .B0(\Registers[13][1] ), 
        .B1(n419), .Y(n317) );
  AOI21X1M U387 ( .A0(n318), .A1(n317), .B0(n390), .Y(n325) );
  AOI22X1M U388 ( .A0(REG2[1]), .A1(n416), .B0(REG3[1]), .B1(n413), .Y(n320)
         );
  AOI22X1M U389 ( .A0(REG0[1]), .A1(n422), .B0(REG1[1]), .B1(n419), .Y(n319)
         );
  AOI21X1M U390 ( .A0(n320), .A1(n319), .B0(n393), .Y(n324) );
  AOI22X1M U391 ( .A0(\Registers[6][1] ), .A1(n416), .B0(\Registers[7][1] ), 
        .B1(n413), .Y(n322) );
  AOI22X1M U392 ( .A0(\Registers[4][1] ), .A1(n422), .B0(\Registers[5][1] ), 
        .B1(n419), .Y(n321) );
  AOI21X1M U393 ( .A0(n322), .A1(n321), .B0(n400), .Y(n323) );
  OR4X1M U394 ( .A(n326), .B(n325), .C(n324), .D(n323), .Y(N41) );
  AOI22X1M U395 ( .A0(\Registers[10][2] ), .A1(n416), .B0(\Registers[11][2] ), 
        .B1(n413), .Y(n328) );
  AOI22X1M U396 ( .A0(\Registers[8][2] ), .A1(n422), .B0(\Registers[9][2] ), 
        .B1(n419), .Y(n327) );
  AOI21X1M U397 ( .A0(n328), .A1(n327), .B0(n387), .Y(n338) );
  AOI22X1M U398 ( .A0(\Registers[14][2] ), .A1(n416), .B0(\Registers[15][2] ), 
        .B1(n413), .Y(n330) );
  AOI22X1M U399 ( .A0(\Registers[12][2] ), .A1(n422), .B0(\Registers[13][2] ), 
        .B1(n419), .Y(n329) );
  AOI21X1M U400 ( .A0(n330), .A1(n329), .B0(n390), .Y(n337) );
  AOI22X1M U401 ( .A0(REG2[2]), .A1(n416), .B0(REG3[2]), .B1(n413), .Y(n332)
         );
  AOI22X1M U402 ( .A0(REG0[2]), .A1(n422), .B0(REG1[2]), .B1(n419), .Y(n331)
         );
  AOI21X1M U403 ( .A0(n332), .A1(n331), .B0(n393), .Y(n336) );
  AOI22X1M U404 ( .A0(\Registers[6][2] ), .A1(n416), .B0(\Registers[7][2] ), 
        .B1(n413), .Y(n334) );
  AOI22X1M U405 ( .A0(\Registers[4][2] ), .A1(n422), .B0(\Registers[5][2] ), 
        .B1(n419), .Y(n333) );
  AOI21X1M U406 ( .A0(n334), .A1(n333), .B0(n400), .Y(n335) );
  OR4X1M U407 ( .A(n338), .B(n337), .C(n336), .D(n335), .Y(N40) );
  AOI22X1M U408 ( .A0(\Registers[10][3] ), .A1(n415), .B0(\Registers[11][3] ), 
        .B1(n412), .Y(n340) );
  AOI22X1M U409 ( .A0(\Registers[8][3] ), .A1(n421), .B0(\Registers[9][3] ), 
        .B1(n418), .Y(n339) );
  AOI21X1M U410 ( .A0(n340), .A1(n339), .B0(n387), .Y(n350) );
  AOI22X1M U411 ( .A0(\Registers[14][3] ), .A1(n415), .B0(\Registers[15][3] ), 
        .B1(n412), .Y(n342) );
  AOI22X1M U412 ( .A0(\Registers[12][3] ), .A1(n421), .B0(\Registers[13][3] ), 
        .B1(n418), .Y(n341) );
  AOI21X1M U413 ( .A0(n342), .A1(n341), .B0(n390), .Y(n349) );
  AOI22X1M U414 ( .A0(REG2[3]), .A1(n415), .B0(REG3[3]), .B1(n412), .Y(n344)
         );
  AOI22X1M U415 ( .A0(REG0[3]), .A1(n421), .B0(REG1[3]), .B1(n418), .Y(n343)
         );
  AOI21X1M U416 ( .A0(n344), .A1(n343), .B0(n393), .Y(n348) );
  AOI22X1M U417 ( .A0(\Registers[6][3] ), .A1(n415), .B0(\Registers[7][3] ), 
        .B1(n412), .Y(n346) );
  AOI22X1M U418 ( .A0(\Registers[4][3] ), .A1(n421), .B0(\Registers[5][3] ), 
        .B1(n418), .Y(n345) );
  AOI21X1M U419 ( .A0(n346), .A1(n345), .B0(n400), .Y(n347) );
  OR4X1M U420 ( .A(n350), .B(n349), .C(n348), .D(n347), .Y(N39) );
  AOI22X1M U421 ( .A0(\Registers[10][4] ), .A1(n415), .B0(\Registers[11][4] ), 
        .B1(n412), .Y(n352) );
  AOI22X1M U422 ( .A0(\Registers[8][4] ), .A1(n421), .B0(\Registers[9][4] ), 
        .B1(n418), .Y(n351) );
  AOI21X1M U423 ( .A0(n352), .A1(n351), .B0(n387), .Y(n362) );
  AOI22X1M U424 ( .A0(\Registers[14][4] ), .A1(n415), .B0(\Registers[15][4] ), 
        .B1(n412), .Y(n354) );
  AOI22X1M U425 ( .A0(\Registers[12][4] ), .A1(n421), .B0(\Registers[13][4] ), 
        .B1(n418), .Y(n353) );
  AOI21X1M U426 ( .A0(n354), .A1(n353), .B0(n390), .Y(n361) );
  AOI22X1M U427 ( .A0(REG2[4]), .A1(n415), .B0(REG3[4]), .B1(n412), .Y(n356)
         );
  AOI22X1M U428 ( .A0(REG0[4]), .A1(n421), .B0(REG1[4]), .B1(n418), .Y(n355)
         );
  AOI21X1M U429 ( .A0(n356), .A1(n355), .B0(n393), .Y(n360) );
  AOI22X1M U430 ( .A0(\Registers[6][4] ), .A1(n415), .B0(\Registers[7][4] ), 
        .B1(n412), .Y(n358) );
  AOI22X1M U431 ( .A0(\Registers[4][4] ), .A1(n421), .B0(\Registers[5][4] ), 
        .B1(n418), .Y(n357) );
  AOI21X1M U432 ( .A0(n358), .A1(n357), .B0(n400), .Y(n359) );
  OR4X1M U433 ( .A(n362), .B(n361), .C(n360), .D(n359), .Y(N38) );
  AOI22X1M U434 ( .A0(\Registers[10][5] ), .A1(n415), .B0(\Registers[11][5] ), 
        .B1(n412), .Y(n364) );
  AOI22X1M U435 ( .A0(\Registers[8][5] ), .A1(n421), .B0(\Registers[9][5] ), 
        .B1(n418), .Y(n363) );
  AOI21X1M U436 ( .A0(n364), .A1(n363), .B0(n387), .Y(n374) );
  AOI22X1M U437 ( .A0(\Registers[14][5] ), .A1(n415), .B0(\Registers[15][5] ), 
        .B1(n412), .Y(n366) );
  AOI22X1M U438 ( .A0(\Registers[12][5] ), .A1(n421), .B0(\Registers[13][5] ), 
        .B1(n418), .Y(n365) );
  AOI21X1M U439 ( .A0(n366), .A1(n365), .B0(n390), .Y(n373) );
  AOI22X1M U440 ( .A0(REG2[5]), .A1(n415), .B0(REG3[5]), .B1(n412), .Y(n368)
         );
  AOI22X1M U441 ( .A0(REG0[5]), .A1(n421), .B0(REG1[5]), .B1(n418), .Y(n367)
         );
  AOI21X1M U442 ( .A0(n368), .A1(n367), .B0(n393), .Y(n372) );
  AOI22X1M U443 ( .A0(\Registers[6][5] ), .A1(n415), .B0(\Registers[7][5] ), 
        .B1(n412), .Y(n370) );
  AOI22X1M U444 ( .A0(\Registers[4][5] ), .A1(n421), .B0(\Registers[5][5] ), 
        .B1(n418), .Y(n369) );
  AOI21X1M U445 ( .A0(n370), .A1(n369), .B0(n400), .Y(n371) );
  OR4X1M U446 ( .A(n374), .B(n373), .C(n372), .D(n371), .Y(N37) );
  AOI22X1M U447 ( .A0(\Registers[10][6] ), .A1(n414), .B0(\Registers[11][6] ), 
        .B1(n411), .Y(n376) );
  AOI22X1M U448 ( .A0(\Registers[8][6] ), .A1(n420), .B0(\Registers[9][6] ), 
        .B1(n417), .Y(n375) );
  AOI21X1M U449 ( .A0(n376), .A1(n375), .B0(n387), .Y(n386) );
  AOI22X1M U450 ( .A0(\Registers[14][6] ), .A1(n414), .B0(\Registers[15][6] ), 
        .B1(n411), .Y(n378) );
  AOI22X1M U451 ( .A0(\Registers[12][6] ), .A1(n420), .B0(\Registers[13][6] ), 
        .B1(n417), .Y(n377) );
  AOI21X1M U452 ( .A0(n378), .A1(n377), .B0(n390), .Y(n385) );
  AOI22X1M U453 ( .A0(REG2[6]), .A1(n414), .B0(REG3[6]), .B1(n411), .Y(n380)
         );
  AOI22X1M U454 ( .A0(REG0[6]), .A1(n420), .B0(REG1[6]), .B1(n417), .Y(n379)
         );
  AOI21X1M U455 ( .A0(n380), .A1(n379), .B0(n393), .Y(n384) );
  AOI22X1M U456 ( .A0(\Registers[6][6] ), .A1(n414), .B0(\Registers[7][6] ), 
        .B1(n411), .Y(n382) );
  AOI22X1M U457 ( .A0(\Registers[4][6] ), .A1(n420), .B0(\Registers[5][6] ), 
        .B1(n417), .Y(n381) );
  AOI21X1M U458 ( .A0(n382), .A1(n381), .B0(n400), .Y(n383) );
  OR4X1M U459 ( .A(n386), .B(n385), .C(n384), .D(n383), .Y(N36) );
  AOI22X1M U460 ( .A0(\Registers[10][7] ), .A1(n414), .B0(\Registers[11][7] ), 
        .B1(n411), .Y(n389) );
  AOI22X1M U461 ( .A0(\Registers[8][7] ), .A1(n420), .B0(\Registers[9][7] ), 
        .B1(n417), .Y(n388) );
  AOI21X1M U462 ( .A0(n389), .A1(n388), .B0(n387), .Y(n406) );
  AOI22X1M U463 ( .A0(\Registers[14][7] ), .A1(n414), .B0(\Registers[15][7] ), 
        .B1(n411), .Y(n392) );
  AOI22X1M U464 ( .A0(\Registers[12][7] ), .A1(n420), .B0(\Registers[13][7] ), 
        .B1(n417), .Y(n391) );
  AOI21X1M U465 ( .A0(n392), .A1(n391), .B0(n390), .Y(n405) );
  AOI22X1M U466 ( .A0(REG2[7]), .A1(n414), .B0(REG3[7]), .B1(n411), .Y(n395)
         );
  AOI22X1M U467 ( .A0(REG0[7]), .A1(n420), .B0(REG1[7]), .B1(n417), .Y(n394)
         );
  AOI21X1M U468 ( .A0(n395), .A1(n394), .B0(n393), .Y(n404) );
  AOI22X1M U469 ( .A0(\Registers[6][7] ), .A1(n414), .B0(\Registers[7][7] ), 
        .B1(n411), .Y(n402) );
  AOI22X1M U470 ( .A0(\Registers[4][7] ), .A1(n420), .B0(\Registers[5][7] ), 
        .B1(n417), .Y(n401) );
  AOI21X1M U471 ( .A0(n402), .A1(n401), .B0(n400), .Y(n403) );
  OR4X1M U472 ( .A(n406), .B(n405), .C(n404), .D(n403), .Y(N35) );
  DLY1X1M U473 ( .A(test_se), .Y(n466) );
  INVXLM U474 ( .A(n478), .Y(n467) );
  INVXLM U475 ( .A(n471), .Y(n478) );
  INVXLM U476 ( .A(n478), .Y(n468) );
  INVXLM U477 ( .A(n478), .Y(n469) );
  INVXLM U478 ( .A(n478), .Y(n470) );
  DLY1X1M U479 ( .A(test_se), .Y(n471) );
  DLY1X1M U480 ( .A(test_se), .Y(n472) );
  DLY1X1M U481 ( .A(test_se), .Y(n473) );
  DLY1X1M U482 ( .A(test_se), .Y(n474) );
  DLY1X1M U484 ( .A(test_se), .Y(n476) );
  DLY1X1M U485 ( .A(n473), .Y(n477) );
  DLY1X1M U486 ( .A(n489), .Y(n479) );
  DLY1X1M U487 ( .A(n474), .Y(n480) );
  DLY1X1M U489 ( .A(n476), .Y(n482) );
  DLY1X1M U490 ( .A(n474), .Y(n483) );
  DLY1X1M U491 ( .A(n475), .Y(n484) );
  DLY1X1M U492 ( .A(n471), .Y(n485) );
  DLY1X1M U493 ( .A(n476), .Y(n486) );
  DLY1X1M U494 ( .A(n472), .Y(n487) );
  DLY1X1M U495 ( .A(n466), .Y(n488) );
  DLY1X1M U496 ( .A(n473), .Y(n489) );
  DLY1X1M U497 ( .A(REG2[7]), .Y(n490) );
  SDFFRQX4M \Registers_reg[2][6]  ( .D(n208), .SI(REG2[5]), .SE(n481), .CK(clk), .RN(n441), .Q(REG2[6]) );
  SDFFRQX4M \Registers_reg[2][3]  ( .D(n205), .SI(REG2[2]), .SE(n487), .CK(clk), .RN(n441), .Q(REG2[3]) );
  SDFFRQX4M \Registers_reg[2][4]  ( .D(n206), .SI(REG2[3]), .SE(n489), .CK(clk), .RN(n441), .Q(REG2[4]) );
  SDFFRQX4M \Registers_reg[2][2]  ( .D(n204), .SI(REG2[1]), .SE(n475), .CK(clk), .RN(n441), .Q(REG2[2]) );
  SDFFRQX4M \Registers_reg[2][5]  ( .D(n207), .SI(REG2[4]), .SE(n481), .CK(clk), .RN(n441), .Q(REG2[5]) );
  BUFX2M U3 ( .A(n480), .Y(n481) );
  BUFX2M U4 ( .A(test_se), .Y(n475) );
endmodule


module ALU_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][0] , \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] ,
         \u_div/SumTmp[1][3] , \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] ,
         \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] , \u_div/SumTmp[2][1] ,
         \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] , \u_div/SumTmp[2][4] ,
         \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] , \u_div/SumTmp[3][1] ,
         \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] ,
         \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] ,
         \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] ,
         \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
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
         \u_div/PartRem[1][1] , \u_div/PartRem[1][2] , \u_div/PartRem[1][3] ,
         \u_div/PartRem[1][4] , \u_div/PartRem[1][5] , \u_div/PartRem[1][6] ,
         \u_div/PartRem[1][7] , \u_div/PartRem[2][1] , \u_div/PartRem[2][2] ,
         \u_div/PartRem[2][3] , \u_div/PartRem[2][4] , \u_div/PartRem[2][5] ,
         \u_div/PartRem[2][6] , \u_div/PartRem[3][1] , \u_div/PartRem[3][2] ,
         \u_div/PartRem[3][3] , \u_div/PartRem[3][4] , \u_div/PartRem[3][5] ,
         \u_div/PartRem[4][1] , \u_div/PartRem[4][2] , \u_div/PartRem[4][3] ,
         \u_div/PartRem[4][4] , \u_div/PartRem[5][1] , \u_div/PartRem[5][2] ,
         \u_div/PartRem[5][3] , \u_div/PartRem[6][1] , \u_div/PartRem[6][2] ,
         \u_div/PartRem[7][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22;

  ADDFX2M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n13), 
        .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n14), 
        .CI(\u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n16), 
        .CI(\u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n17), 
        .CI(\u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n15), 
        .CI(\u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n18), 
        .CI(\u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n14), 
        .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n15), 
        .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n16), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n17), 
        .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n18), 
        .CI(\u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n15), 
        .CI(\u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n16), 
        .CI(\u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n16), 
        .CI(\u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n17), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n17), 
        .CI(\u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n18), 
        .CI(\u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n17), 
        .CI(\u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n18), 
        .CI(\u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n18), 
        .CI(\u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n18), 
        .CI(\u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n15), 
        .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n14), 
        .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n17), 
        .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n16), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n18), 
        .CI(\u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n13), 
        .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n12), 
        .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  AND2X2M U1 ( .A(\u_div/CryTmp[1][7] ), .B(n12), .Y(quotient[1]) );
  AND2X2M U2 ( .A(\u_div/CryTmp[2][6] ), .B(n22), .Y(quotient[2]) );
  INVX2M U3 ( .A(b[1]), .Y(n18) );
  INVX2M U4 ( .A(b[2]), .Y(n17) );
  INVX2M U5 ( .A(b[3]), .Y(n16) );
  OR2X2M U6 ( .A(n19), .B(a[7]), .Y(\u_div/CryTmp[7][1] ) );
  XNOR2X2M U7 ( .A(n19), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  XNOR2X2M U8 ( .A(n19), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X2M U9 ( .A(n19), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  XNOR2X2M U10 ( .A(n19), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X2M U11 ( .A(n19), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X2M U12 ( .A(n19), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  NAND2X2M U13 ( .A(n7), .B(n11), .Y(\u_div/CryTmp[0][1] ) );
  INVX2M U14 ( .A(a[0]), .Y(n11) );
  NAND2X2M U15 ( .A(n3), .B(n4), .Y(\u_div/CryTmp[5][1] ) );
  INVX2M U16 ( .A(a[5]), .Y(n4) );
  INVX2M U17 ( .A(n19), .Y(n3) );
  NAND2X2M U18 ( .A(n5), .B(n6), .Y(\u_div/CryTmp[4][1] ) );
  INVX2M U19 ( .A(a[4]), .Y(n6) );
  INVX2M U20 ( .A(n19), .Y(n5) );
  NAND2X2M U21 ( .A(n7), .B(n8), .Y(\u_div/CryTmp[3][1] ) );
  INVX2M U22 ( .A(a[3]), .Y(n8) );
  INVX2M U23 ( .A(n19), .Y(n7) );
  NAND2X2M U24 ( .A(n7), .B(n9), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U25 ( .A(a[2]), .Y(n9) );
  NAND2X2M U26 ( .A(n7), .B(n10), .Y(\u_div/CryTmp[1][1] ) );
  INVX2M U27 ( .A(a[1]), .Y(n10) );
  NAND2X2M U28 ( .A(n1), .B(n2), .Y(\u_div/CryTmp[6][1] ) );
  INVX2M U29 ( .A(a[6]), .Y(n2) );
  INVX2M U30 ( .A(n19), .Y(n1) );
  XNOR2X2M U31 ( .A(n19), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  INVX4M U32 ( .A(b[0]), .Y(n19) );
  INVX2M U33 ( .A(b[4]), .Y(n15) );
  INVX2M U34 ( .A(b[5]), .Y(n14) );
  INVX2M U35 ( .A(b[6]), .Y(n13) );
  INVX2M U36 ( .A(b[7]), .Y(n12) );
  CLKMX2X2M U37 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  CLKMX2X2M U38 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  CLKMX2X2M U39 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  CLKMX2X2M U40 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  CLKMX2X2M U41 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  CLKMX2X2M U42 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  CLKMX2X2M U43 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  CLKMX2X2M U44 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U45 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  CLKMX2X2M U46 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  CLKMX2X2M U47 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  CLKMX2X2M U48 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  CLKMX2X2M U49 ( .A(a[6]), .B(\u_div/SumTmp[6][0] ), .S0(quotient[6]), .Y(
        \u_div/PartRem[6][1] ) );
  CLKMX2X2M U50 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U51 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  CLKMX2X2M U52 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  CLKMX2X2M U53 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  CLKMX2X2M U54 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  CLKMX2X2M U55 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
  CLKMX2X2M U56 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  CLKMX2X2M U57 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  CLKMX2X2M U58 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  CLKMX2X2M U59 ( .A(\u_div/PartRem[2][2] ), .B(\u_div/SumTmp[1][2] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  CLKMX2X2M U60 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  CLKMX2X2M U61 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  CLKMX2X2M U62 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  CLKMX2X2M U63 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  CLKMX2X2M U64 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][1] ) );
  AND4X1M U65 ( .A(\u_div/CryTmp[7][1] ), .B(n20), .C(n18), .D(n17), .Y(
        quotient[7]) );
  AND3X1M U66 ( .A(n20), .B(n17), .C(\u_div/CryTmp[6][2] ), .Y(quotient[6]) );
  AND2X1M U67 ( .A(\u_div/CryTmp[5][3] ), .B(n20), .Y(quotient[5]) );
  AND2X1M U68 ( .A(n21), .B(n16), .Y(n20) );
  AND2X1M U69 ( .A(\u_div/CryTmp[4][4] ), .B(n21), .Y(quotient[4]) );
  AND3X1M U70 ( .A(n22), .B(n15), .C(n14), .Y(n21) );
  AND3X1M U71 ( .A(n22), .B(n14), .C(\u_div/CryTmp[3][5] ), .Y(quotient[3]) );
  NOR2X1M U72 ( .A(b[6]), .B(b[7]), .Y(n22) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFX2M U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
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
  XNOR2X2M U1 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U2 ( .A(B[0]), .Y(n9) );
  INVX2M U3 ( .A(B[1]), .Y(n8) );
  NAND2X2M U4 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX2M U5 ( .A(A[0]), .Y(n1) );
  INVX2M U6 ( .A(B[2]), .Y(n7) );
  INVX2M U7 ( .A(B[3]), .Y(n6) );
  INVX2M U8 ( .A(B[4]), .Y(n5) );
  INVX2M U9 ( .A(B[5]), .Y(n4) );
  INVX2M U10 ( .A(B[6]), .Y(n3) );
  INVX2M U11 ( .A(B[7]), .Y(n2) );
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

  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
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
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26;

  NAND2X2M U2 ( .A(A[7]), .B(B[7]), .Y(n13) );
  CLKXOR2X2M U3 ( .A(B[13]), .B(n16), .Y(SUM[13]) );
  CLKXOR2X2M U4 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  INVX2M U5 ( .A(n7), .Y(SUM[6]) );
  INVX2M U6 ( .A(A[6]), .Y(n7) );
  BUFX2M U7 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U8 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U9 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U10 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U11 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U12 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U13 ( .A(n8), .B(n9), .Y(SUM[9]) );
  NOR2X1M U14 ( .A(n10), .B(n11), .Y(n9) );
  CLKXOR2X2M U15 ( .A(n12), .B(n13), .Y(SUM[8]) );
  NAND2BX1M U16 ( .AN(n14), .B(n15), .Y(n12) );
  OAI2BB1X1M U17 ( .A0N(n17), .A1N(A[12]), .B0(n18), .Y(n16) );
  OAI21X1M U18 ( .A0(A[12]), .A1(n17), .B0(B[12]), .Y(n18) );
  XOR3XLM U19 ( .A(B[12]), .B(A[12]), .C(n17), .Y(SUM[12]) );
  OAI21BX1M U20 ( .A0(n19), .A1(n20), .B0N(n21), .Y(n17) );
  XNOR2X1M U21 ( .A(n20), .B(n22), .Y(SUM[11]) );
  NOR2X1M U22 ( .A(n21), .B(n19), .Y(n22) );
  NOR2X1M U23 ( .A(B[11]), .B(A[11]), .Y(n19) );
  AND2X1M U24 ( .A(B[11]), .B(A[11]), .Y(n21) );
  OA21X1M U25 ( .A0(n23), .A1(n24), .B0(n25), .Y(n20) );
  CLKXOR2X2M U26 ( .A(n26), .B(n24), .Y(SUM[10]) );
  AOI2BB1X1M U27 ( .A0N(n8), .A1N(n11), .B0(n10), .Y(n24) );
  AND2X1M U28 ( .A(B[9]), .B(A[9]), .Y(n10) );
  NOR2X1M U29 ( .A(B[9]), .B(A[9]), .Y(n11) );
  OA21X1M U30 ( .A0(n13), .A1(n14), .B0(n15), .Y(n8) );
  CLKNAND2X2M U31 ( .A(B[8]), .B(A[8]), .Y(n15) );
  NOR2X1M U32 ( .A(B[8]), .B(A[8]), .Y(n14) );
  NAND2BX1M U33 ( .AN(n23), .B(n25), .Y(n26) );
  CLKNAND2X2M U34 ( .A(B[10]), .B(A[10]), .Y(n25) );
  NOR2X1M U35 ( .A(B[10]), .B(A[10]), .Y(n23) );
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
         n27, n28, n29, n30, n31, n32;

  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n9), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n7), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n8), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n6), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n5), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n4), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n3), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  AND2X2M U2 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  CLKXOR2X2M U10 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U11 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  AND2X2M U12 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n11) );
  AND2X2M U13 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n12) );
  CLKXOR2X2M U14 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U15 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  CLKXOR2X2M U16 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  AND2X2M U17 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n13) );
  AND2X2M U18 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n14) );
  AND2X2M U19 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n15) );
  CLKXOR2X2M U20 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U21 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(\A1[6] ) );
  AND2X2M U22 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n16) );
  CLKXOR2X2M U23 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  INVX2M U24 ( .A(A[0]), .Y(n32) );
  INVX2M U25 ( .A(A[1]), .Y(n31) );
  CLKXOR2X2M U26 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Y(\SUMB[1][2] ) );
  CLKXOR2X2M U27 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Y(\SUMB[1][3] ) );
  CLKXOR2X2M U28 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Y(\SUMB[1][4] ) );
  CLKXOR2X2M U29 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Y(\SUMB[1][5] ) );
  CLKXOR2X2M U30 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Y(\SUMB[1][1] ) );
  CLKXOR2X2M U31 ( .A(\ab[1][6] ), .B(\ab[0][7] ), .Y(\SUMB[1][6] ) );
  INVX2M U32 ( .A(A[2]), .Y(n30) );
  INVX2M U33 ( .A(A[3]), .Y(n29) );
  INVX2M U34 ( .A(A[4]), .Y(n28) );
  INVX2M U35 ( .A(A[7]), .Y(n25) );
  INVX2M U36 ( .A(A[5]), .Y(n27) );
  INVX2M U37 ( .A(A[6]), .Y(n26) );
  INVX2M U38 ( .A(B[6]), .Y(n18) );
  INVX2M U39 ( .A(B[7]), .Y(n17) );
  INVX2M U40 ( .A(B[0]), .Y(n24) );
  INVX2M U41 ( .A(B[1]), .Y(n23) );
  INVX2M U42 ( .A(B[4]), .Y(n20) );
  INVX2M U43 ( .A(B[5]), .Y(n19) );
  INVX2M U44 ( .A(B[2]), .Y(n22) );
  INVX2M U45 ( .A(B[3]), .Y(n21) );
  NOR2X1M U47 ( .A(n25), .B(n17), .Y(\ab[7][7] ) );
  NOR2X1M U48 ( .A(n25), .B(n18), .Y(\ab[7][6] ) );
  NOR2X1M U49 ( .A(n25), .B(n19), .Y(\ab[7][5] ) );
  NOR2X1M U50 ( .A(n25), .B(n20), .Y(\ab[7][4] ) );
  NOR2X1M U51 ( .A(n25), .B(n21), .Y(\ab[7][3] ) );
  NOR2X1M U52 ( .A(n25), .B(n22), .Y(\ab[7][2] ) );
  NOR2X1M U53 ( .A(n25), .B(n23), .Y(\ab[7][1] ) );
  NOR2X1M U54 ( .A(n25), .B(n24), .Y(\ab[7][0] ) );
  NOR2X1M U55 ( .A(n17), .B(n26), .Y(\ab[6][7] ) );
  NOR2X1M U56 ( .A(n18), .B(n26), .Y(\ab[6][6] ) );
  NOR2X1M U57 ( .A(n19), .B(n26), .Y(\ab[6][5] ) );
  NOR2X1M U58 ( .A(n20), .B(n26), .Y(\ab[6][4] ) );
  NOR2X1M U59 ( .A(n21), .B(n26), .Y(\ab[6][3] ) );
  NOR2X1M U60 ( .A(n22), .B(n26), .Y(\ab[6][2] ) );
  NOR2X1M U61 ( .A(n23), .B(n26), .Y(\ab[6][1] ) );
  NOR2X1M U62 ( .A(n24), .B(n26), .Y(\ab[6][0] ) );
  NOR2X1M U63 ( .A(n17), .B(n27), .Y(\ab[5][7] ) );
  NOR2X1M U64 ( .A(n18), .B(n27), .Y(\ab[5][6] ) );
  NOR2X1M U65 ( .A(n19), .B(n27), .Y(\ab[5][5] ) );
  NOR2X1M U66 ( .A(n20), .B(n27), .Y(\ab[5][4] ) );
  NOR2X1M U67 ( .A(n21), .B(n27), .Y(\ab[5][3] ) );
  NOR2X1M U68 ( .A(n22), .B(n27), .Y(\ab[5][2] ) );
  NOR2X1M U69 ( .A(n23), .B(n27), .Y(\ab[5][1] ) );
  NOR2X1M U70 ( .A(n24), .B(n27), .Y(\ab[5][0] ) );
  NOR2X1M U71 ( .A(n17), .B(n28), .Y(\ab[4][7] ) );
  NOR2X1M U72 ( .A(n18), .B(n28), .Y(\ab[4][6] ) );
  NOR2X1M U73 ( .A(n19), .B(n28), .Y(\ab[4][5] ) );
  NOR2X1M U74 ( .A(n20), .B(n28), .Y(\ab[4][4] ) );
  NOR2X1M U75 ( .A(n21), .B(n28), .Y(\ab[4][3] ) );
  NOR2X1M U76 ( .A(n22), .B(n28), .Y(\ab[4][2] ) );
  NOR2X1M U77 ( .A(n23), .B(n28), .Y(\ab[4][1] ) );
  NOR2X1M U78 ( .A(n24), .B(n28), .Y(\ab[4][0] ) );
  NOR2X1M U79 ( .A(n17), .B(n29), .Y(\ab[3][7] ) );
  NOR2X1M U80 ( .A(n18), .B(n29), .Y(\ab[3][6] ) );
  NOR2X1M U81 ( .A(n19), .B(n29), .Y(\ab[3][5] ) );
  NOR2X1M U82 ( .A(n20), .B(n29), .Y(\ab[3][4] ) );
  NOR2X1M U83 ( .A(n21), .B(n29), .Y(\ab[3][3] ) );
  NOR2X1M U84 ( .A(n22), .B(n29), .Y(\ab[3][2] ) );
  NOR2X1M U85 ( .A(n23), .B(n29), .Y(\ab[3][1] ) );
  NOR2X1M U86 ( .A(n24), .B(n29), .Y(\ab[3][0] ) );
  NOR2X1M U87 ( .A(n17), .B(n30), .Y(\ab[2][7] ) );
  NOR2X1M U88 ( .A(n18), .B(n30), .Y(\ab[2][6] ) );
  NOR2X1M U89 ( .A(n19), .B(n30), .Y(\ab[2][5] ) );
  NOR2X1M U90 ( .A(n20), .B(n30), .Y(\ab[2][4] ) );
  NOR2X1M U91 ( .A(n21), .B(n30), .Y(\ab[2][3] ) );
  NOR2X1M U92 ( .A(n22), .B(n30), .Y(\ab[2][2] ) );
  NOR2X1M U93 ( .A(n23), .B(n30), .Y(\ab[2][1] ) );
  NOR2X1M U94 ( .A(n24), .B(n30), .Y(\ab[2][0] ) );
  NOR2X1M U95 ( .A(n17), .B(n31), .Y(\ab[1][7] ) );
  NOR2X1M U96 ( .A(n18), .B(n31), .Y(\ab[1][6] ) );
  NOR2X1M U97 ( .A(n19), .B(n31), .Y(\ab[1][5] ) );
  NOR2X1M U98 ( .A(n20), .B(n31), .Y(\ab[1][4] ) );
  NOR2X1M U99 ( .A(n21), .B(n31), .Y(\ab[1][3] ) );
  NOR2X1M U100 ( .A(n22), .B(n31), .Y(\ab[1][2] ) );
  NOR2X1M U101 ( .A(n23), .B(n31), .Y(\ab[1][1] ) );
  NOR2X1M U102 ( .A(n24), .B(n31), .Y(\ab[1][0] ) );
  NOR2X1M U103 ( .A(n17), .B(n32), .Y(\ab[0][7] ) );
  NOR2X1M U104 ( .A(n18), .B(n32), .Y(\ab[0][6] ) );
  NOR2X1M U105 ( .A(n19), .B(n32), .Y(\ab[0][5] ) );
  NOR2X1M U106 ( .A(n20), .B(n32), .Y(\ab[0][4] ) );
  NOR2X1M U107 ( .A(n21), .B(n32), .Y(\ab[0][3] ) );
  NOR2X1M U108 ( .A(n22), .B(n32), .Y(\ab[0][2] ) );
  NOR2X1M U109 ( .A(n23), .B(n32), .Y(\ab[0][1] ) );
  NOR2X1M U110 ( .A(n24), .B(n32), .Y(PRODUCT[0]) );
  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n16, n15, n13, n14, n12, n11, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
endmodule


module ALU_test_1 ( A, B, ALU_FUN, clk, en, rst, ALU_OUT, out_valid, test_si, 
        test_se );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input clk, en, rst, test_si, test_se;
  output out_valid;
  wire   out_valid_comb, N68, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78,
         N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90, N91, N92,
         N93, N94, N95, N96, N97, N98, N99, N100, N101, N104, N105, N106, N107,
         N108, N109, N110, N111, N168, N169, N170, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n3, n4, n5, n6, n7, n8, n9,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n172, n176, n177,
         n178, n179, n180;
  wire   [15:0] ALU_OUT_comb;

  SDFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_comb[15]), .SI(ALU_OUT[14]), .SE(
        n179), .CK(clk), .RN(n28), .Q(ALU_OUT[15]) );
  SDFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_comb[14]), .SI(ALU_OUT[13]), .SE(
        n178), .CK(clk), .RN(n28), .Q(ALU_OUT[14]) );
  SDFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_comb[13]), .SI(ALU_OUT[12]), .SE(
        n180), .CK(clk), .RN(n28), .Q(ALU_OUT[13]) );
  SDFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_comb[12]), .SI(ALU_OUT[11]), .SE(
        n179), .CK(clk), .RN(n28), .Q(ALU_OUT[12]) );
  SDFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_comb[11]), .SI(ALU_OUT[10]), .SE(
        n178), .CK(clk), .RN(n28), .Q(ALU_OUT[11]) );
  SDFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_comb[10]), .SI(ALU_OUT[9]), .SE(
        n180), .CK(clk), .RN(n28), .Q(ALU_OUT[10]) );
  SDFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_comb[9]), .SI(ALU_OUT[8]), .SE(n179), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[9]) );
  SDFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_comb[8]), .SI(ALU_OUT[7]), .SE(n178), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[8]) );
  SDFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_comb[7]), .SI(ALU_OUT[6]), .SE(n180), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[7]) );
  SDFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_comb[6]), .SI(ALU_OUT[5]), .SE(n179), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[6]) );
  SDFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_comb[5]), .SI(ALU_OUT[4]), .SE(n178), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[5]) );
  SDFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_comb[4]), .SI(ALU_OUT[3]), .SE(n180), 
        .CK(clk), .RN(n28), .Q(ALU_OUT[4]) );
  SDFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_comb[3]), .SI(ALU_OUT[2]), .SE(n179), 
        .CK(clk), .RN(n29), .Q(ALU_OUT[3]) );
  SDFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_comb[2]), .SI(ALU_OUT[1]), .SE(n178), 
        .CK(clk), .RN(n29), .Q(ALU_OUT[2]) );
  SDFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_comb[1]), .SI(ALU_OUT[0]), .SE(n180), 
        .CK(clk), .RN(n29), .Q(ALU_OUT[1]) );
  SDFFRQX2M \ALU_OUT_reg[0]  ( .D(ALU_OUT_comb[0]), .SI(test_si), .SE(n179), 
        .CK(clk), .RN(n29), .Q(ALU_OUT[0]) );
  SDFFRQX2M out_valid_reg ( .D(out_valid_comb), .SI(ALU_OUT[15]), .SE(n178), 
        .CK(clk), .RN(n28), .Q(out_valid) );
  NAND3X2M U8 ( .A(n57), .B(en), .C(N85), .Y(n69) );
  BUFX2M U23 ( .A(A[7]), .Y(n27) );
  NAND2X2M U24 ( .A(n123), .B(n131), .Y(n60) );
  NOR2BX2M U25 ( .AN(ALU_FUN[3]), .B(ALU_FUN[0]), .Y(n122) );
  NOR2X2M U26 ( .A(ALU_FUN[3]), .B(ALU_FUN[0]), .Y(n131) );
  NOR2X2M U27 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n140) );
  INVX2M U28 ( .A(n124), .Y(n165) );
  INVX2M U29 ( .A(n113), .Y(n169) );
  NAND3X2M U30 ( .A(n60), .B(n61), .C(n62), .Y(n56) );
  INVX4M U31 ( .A(n61), .Y(n164) );
  INVX2M U32 ( .A(n60), .Y(n166) );
  INVX2M U33 ( .A(n66), .Y(n168) );
  INVX2M U34 ( .A(n65), .Y(n167) );
  NAND2X2M U35 ( .A(n62), .B(n133), .Y(n124) );
  NAND2X2M U36 ( .A(n123), .B(n139), .Y(n62) );
  NAND2X2M U37 ( .A(n132), .B(n139), .Y(n61) );
  NAND2X2M U38 ( .A(n122), .B(n140), .Y(n66) );
  INVX2M U39 ( .A(n67), .Y(n170) );
  AND2X2M U40 ( .A(n131), .B(n140), .Y(n58) );
  AND2X2M U41 ( .A(n139), .B(n140), .Y(n57) );
  AND2X2M U42 ( .A(n59), .B(n131), .Y(n71) );
  NAND2X2M U43 ( .A(n122), .B(n123), .Y(n113) );
  NAND2X2M U44 ( .A(n122), .B(n132), .Y(n65) );
  AOI21X2M U45 ( .A0(n54), .A1(n55), .B0(n172), .Y(out_valid_comb) );
  NOR3X2M U46 ( .A(n63), .B(n169), .C(n64), .Y(n54) );
  NOR4X1M U47 ( .A(n56), .B(n57), .C(n58), .D(n59), .Y(n55) );
  NAND3X2M U48 ( .A(n65), .B(n66), .C(n67), .Y(n63) );
  OAI2BB1X2M U49 ( .A0N(n131), .A1N(n132), .B0(n133), .Y(n64) );
  OAI2BB1X2M U50 ( .A0N(N100), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[14]) );
  OAI2BB1X2M U51 ( .A0N(N101), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[15]) );
  OAI2BB1X2M U52 ( .A0N(N99), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[13]) );
  OAI2BB1X2M U53 ( .A0N(N96), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[10]) );
  OAI2BB1X2M U54 ( .A0N(N97), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[11]) );
  OAI2BB1X2M U55 ( .A0N(N98), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[12]) );
  NOR2BX2M U56 ( .AN(ALU_FUN[0]), .B(ALU_FUN[3]), .Y(n139) );
  OAI2BB1X2M U57 ( .A0N(N95), .A1N(n68), .B0(n69), .Y(ALU_OUT_comb[9]) );
  OAI2BB2X1M U58 ( .B0(n156), .B1(n61), .A0N(N93), .A1N(n71), .Y(n75) );
  NAND3X2M U59 ( .A(n132), .B(ALU_FUN[0]), .C(ALU_FUN[3]), .Y(n67) );
  NOR2X2M U60 ( .A(n171), .B(ALU_FUN[1]), .Y(n132) );
  NAND3X2M U61 ( .A(ALU_FUN[0]), .B(n140), .C(ALU_FUN[3]), .Y(n133) );
  AND2X2M U62 ( .A(ALU_FUN[1]), .B(n171), .Y(n59) );
  INVX2M U63 ( .A(ALU_FUN[2]), .Y(n171) );
  AND2X2M U64 ( .A(n71), .B(en), .Y(n68) );
  AND2X2M U65 ( .A(ALU_FUN[1]), .B(ALU_FUN[2]), .Y(n123) );
  INVX2M U66 ( .A(en), .Y(n172) );
  INVX4M U67 ( .A(n30), .Y(n28) );
  INVX2M U68 ( .A(n30), .Y(n29) );
  AOI31X2M U69 ( .A0(n125), .A1(n126), .A2(n127), .B0(n172), .Y(
        ALU_OUT_comb[0]) );
  AOI22X1M U70 ( .A0(N77), .A1(n57), .B0(N68), .B1(n58), .Y(n125) );
  AOI222X1M U71 ( .A0(N86), .A1(n71), .B0(n166), .B1(n163), .C0(n3), .C1(n164), 
        .Y(n126) );
  AOI211X2M U72 ( .A0(N170), .A1(n167), .B0(n128), .C0(n129), .Y(n127) );
  AOI31X2M U73 ( .A0(n114), .A1(n115), .A2(n116), .B0(n172), .Y(
        ALU_OUT_comb[1]) );
  AOI222X1M U74 ( .A0(N69), .A1(n58), .B0(N87), .B1(n71), .C0(N78), .C1(n57), 
        .Y(n114) );
  AOI222X1M U75 ( .A0(n4), .A1(n164), .B0(N170), .B1(n167), .C0(n166), .C1(
        n162), .Y(n115) );
  AOI211X2M U76 ( .A0(n117), .A1(n154), .B0(n118), .C0(n119), .Y(n116) );
  OAI2BB1XLM U77 ( .A0N(N105), .A1N(n147), .B0(n120), .Y(n119) );
  NAND4X2M U78 ( .A(N169), .B(n59), .C(ALU_FUN[3]), .D(ALU_FUN[0]), .Y(n120)
         );
  OAI21X2M U79 ( .A0(n110), .A1(n153), .B0(n111), .Y(n109) );
  AOI221XLM U80 ( .A0(n168), .A1(n161), .B0(n5), .B1(n64), .C0(n164), .Y(n110)
         );
  AOI22XLM U81 ( .A0(N106), .A1(n147), .B0(n112), .B1(n153), .Y(n111) );
  OAI221X1M U82 ( .A0(n5), .A1(n165), .B0(n66), .B1(n161), .C0(n60), .Y(n112)
         );
  AOI31X2M U83 ( .A0(n106), .A1(n107), .A2(n108), .B0(n172), .Y(
        ALU_OUT_comb[2]) );
  AOI22X1M U84 ( .A0(N79), .A1(n57), .B0(N70), .B1(n58), .Y(n106) );
  AOI222X1M U85 ( .A0(N88), .A1(n71), .B0(n166), .B1(n161), .C0(n5), .C1(n164), 
        .Y(n107) );
  AOI221XLM U86 ( .A0(n4), .A1(n169), .B0(n6), .B1(n170), .C0(n109), .Y(n108)
         );
  AOI31X2M U87 ( .A0(n99), .A1(n100), .A2(n101), .B0(n172), .Y(ALU_OUT_comb[3]) );
  AOI22X1M U88 ( .A0(N80), .A1(n57), .B0(N71), .B1(n58), .Y(n99) );
  AOI222X1M U89 ( .A0(N89), .A1(n71), .B0(n166), .B1(n160), .C0(n6), .C1(n164), 
        .Y(n100) );
  AOI221XLM U90 ( .A0(n5), .A1(n169), .B0(n7), .B1(n170), .C0(n102), .Y(n101)
         );
  OAI21X2M U91 ( .A0(n103), .A1(n152), .B0(n104), .Y(n102) );
  AOI221XLM U92 ( .A0(n168), .A1(n160), .B0(n6), .B1(n64), .C0(n164), .Y(n103)
         );
  AOI22X1M U93 ( .A0(N107), .A1(n147), .B0(n105), .B1(n152), .Y(n104) );
  OAI221X1M U94 ( .A0(n6), .A1(n165), .B0(n66), .B1(n160), .C0(n60), .Y(n105)
         );
  AOI31X2M U95 ( .A0(n92), .A1(n93), .A2(n94), .B0(n172), .Y(ALU_OUT_comb[4])
         );
  AOI22X1M U96 ( .A0(N81), .A1(n57), .B0(N72), .B1(n58), .Y(n92) );
  AOI222X1M U97 ( .A0(N90), .A1(n71), .B0(n166), .B1(n159), .C0(n7), .C1(n164), 
        .Y(n93) );
  AOI221XLM U98 ( .A0(n6), .A1(n169), .B0(n170), .B1(n8), .C0(n95), .Y(n94) );
  OAI21X2M U99 ( .A0(n96), .A1(n151), .B0(n97), .Y(n95) );
  AOI221XLM U100 ( .A0(n168), .A1(n159), .B0(n7), .B1(n64), .C0(n164), .Y(n96)
         );
  AOI22X1M U101 ( .A0(N108), .A1(n147), .B0(n98), .B1(n151), .Y(n97) );
  OAI221X1M U102 ( .A0(n7), .A1(n165), .B0(n66), .B1(n159), .C0(n60), .Y(n98)
         );
  AOI31X2M U103 ( .A0(n85), .A1(n86), .A2(n87), .B0(n172), .Y(ALU_OUT_comb[5])
         );
  AOI22X1M U104 ( .A0(N82), .A1(n57), .B0(N73), .B1(n58), .Y(n85) );
  AOI222X1M U105 ( .A0(N91), .A1(n71), .B0(n166), .B1(n158), .C0(n8), .C1(n164), .Y(n86) );
  AOI221XLM U106 ( .A0(n7), .A1(n169), .B0(n170), .B1(n9), .C0(n88), .Y(n87)
         );
  OAI21X2M U107 ( .A0(n89), .A1(n150), .B0(n90), .Y(n88) );
  AOI221XLM U108 ( .A0(n168), .A1(n158), .B0(n8), .B1(n64), .C0(n164), .Y(n89)
         );
  AOI22X1M U109 ( .A0(N109), .A1(n147), .B0(n91), .B1(n150), .Y(n90) );
  OAI221X1M U110 ( .A0(n8), .A1(n165), .B0(n66), .B1(n158), .C0(n60), .Y(n91)
         );
  AOI31X2M U111 ( .A0(n78), .A1(n79), .A2(n80), .B0(n172), .Y(ALU_OUT_comb[6])
         );
  AOI22X1M U112 ( .A0(N83), .A1(n57), .B0(N74), .B1(n58), .Y(n78) );
  AOI222X1M U113 ( .A0(N92), .A1(n71), .B0(n166), .B1(n157), .C0(n164), .C1(n9), .Y(n79) );
  AOI221XLM U114 ( .A0(n8), .A1(n169), .B0(n170), .B1(n27), .C0(n81), .Y(n80)
         );
  OAI21X2M U115 ( .A0(n70), .A1(n172), .B0(n69), .Y(ALU_OUT_comb[8]) );
  AOI222X1M U116 ( .A0(N76), .A1(n58), .B0(n27), .B1(n169), .C0(N94), .C1(n71), 
        .Y(n70) );
  OAI21X2M U117 ( .A0(n82), .A1(n149), .B0(n83), .Y(n81) );
  AOI221XLM U118 ( .A0(n168), .A1(n157), .B0(n9), .B1(n64), .C0(n164), .Y(n82)
         );
  AOI22X1M U119 ( .A0(N110), .A1(n147), .B0(n84), .B1(n149), .Y(n83) );
  OAI221X1M U120 ( .A0(n9), .A1(n165), .B0(n66), .B1(n157), .C0(n60), .Y(n84)
         );
  OAI222X1M U121 ( .A0(n113), .A1(n163), .B0(n121), .B1(n154), .C0(n67), .C1(
        n161), .Y(n118) );
  AOI221XLM U122 ( .A0(n168), .A1(n162), .B0(n4), .B1(n64), .C0(n164), .Y(n121) );
  OAI221X1M U123 ( .A0(n27), .A1(n165), .B0(n156), .B1(n66), .C0(n60), .Y(n76)
         );
  OAI221X1M U124 ( .A0(n4), .A1(n165), .B0(n66), .B1(n162), .C0(n60), .Y(n117)
         );
  OAI22X1M U125 ( .A0(n67), .A1(n162), .B0(n130), .B1(n144), .Y(n129) );
  AOI221XLM U126 ( .A0(n168), .A1(n163), .B0(n3), .B1(n64), .C0(n164), .Y(n130) );
  INVX2M U127 ( .A(n136), .Y(n147) );
  OAI211X2M U128 ( .A0(n137), .A1(n138), .B0(n139), .C0(n59), .Y(n136) );
  NAND4X2M U129 ( .A(n144), .B(n154), .C(n153), .D(n152), .Y(n138) );
  NAND4X2M U130 ( .A(n151), .B(n150), .C(n149), .D(n148), .Y(n137) );
  INVX2M U131 ( .A(n77), .Y(n155) );
  AOI221XLM U132 ( .A0(n64), .A1(n27), .B0(n156), .B1(n168), .C0(n164), .Y(n77) );
  INVX2M U133 ( .A(n27), .Y(n156) );
  INVX2M U134 ( .A(n4), .Y(n162) );
  INVX2M U135 ( .A(n3), .Y(n163) );
  INVX2M U136 ( .A(n5), .Y(n161) );
  INVX2M U137 ( .A(n9), .Y(n157) );
  INVX2M U138 ( .A(n6), .Y(n160) );
  INVX2M U139 ( .A(n8), .Y(n158) );
  INVX2M U140 ( .A(n7), .Y(n159) );
  INVX2M U141 ( .A(rst), .Y(n30) );
  OAI21X2M U142 ( .A0(B[0]), .A1(n134), .B0(n135), .Y(n128) );
  AOI221XLM U143 ( .A0(n3), .A1(n168), .B0(n124), .B1(n163), .C0(n166), .Y(
        n134) );
  AOI32X1M U144 ( .A0(n59), .A1(n122), .A2(N168), .B0(N104), .B1(n147), .Y(
        n135) );
  BUFX4M U145 ( .A(A[6]), .Y(n9) );
  BUFX4M U146 ( .A(A[5]), .Y(n8) );
  BUFX4M U147 ( .A(A[4]), .Y(n7) );
  BUFX4M U148 ( .A(A[3]), .Y(n6) );
  BUFX4M U149 ( .A(A[2]), .Y(n5) );
  BUFX4M U150 ( .A(A[1]), .Y(n4) );
  BUFX4M U151 ( .A(A[0]), .Y(n3) );
  INVX2M U152 ( .A(n31), .Y(n145) );
  INVX2M U153 ( .A(B[0]), .Y(n144) );
  AOI31X2M U154 ( .A0(n72), .A1(n73), .A2(n74), .B0(n172), .Y(ALU_OUT_comb[7])
         );
  AOI22X1M U155 ( .A0(n9), .A1(n169), .B0(n166), .B1(n156), .Y(n72) );
  AOI222X1M U156 ( .A0(B[7]), .A1(n155), .B0(N111), .B1(n147), .C0(n76), .C1(
        n148), .Y(n73) );
  AOI221XLM U157 ( .A0(N84), .A1(n57), .B0(N75), .B1(n58), .C0(n75), .Y(n74)
         );
  INVX2M U158 ( .A(n42), .Y(n146) );
  INVX2M U159 ( .A(B[6]), .Y(n149) );
  INVX2M U160 ( .A(B[4]), .Y(n151) );
  INVX2M U161 ( .A(B[5]), .Y(n150) );
  INVX2M U162 ( .A(B[3]), .Y(n152) );
  INVX2M U163 ( .A(B[2]), .Y(n153) );
  INVX2M U164 ( .A(B[1]), .Y(n154) );
  INVX2M U165 ( .A(B[7]), .Y(n148) );
  NOR2X1M U166 ( .A(n156), .B(B[7]), .Y(n53) );
  NAND2BX1M U167 ( .AN(B[4]), .B(n7), .Y(n46) );
  NAND2BX1M U168 ( .AN(n7), .B(B[4]), .Y(n35) );
  CLKNAND2X2M U169 ( .A(n46), .B(n35), .Y(n48) );
  NOR2X1M U170 ( .A(n152), .B(n6), .Y(n43) );
  NOR2X1M U171 ( .A(n153), .B(n5), .Y(n34) );
  NOR2X1M U172 ( .A(n144), .B(n3), .Y(n31) );
  CLKNAND2X2M U173 ( .A(n5), .B(n153), .Y(n45) );
  NAND2BX1M U174 ( .AN(n34), .B(n45), .Y(n40) );
  AOI21X1M U175 ( .A0(n31), .A1(n162), .B0(B[1]), .Y(n32) );
  AOI211X1M U176 ( .A0(n4), .A1(n145), .B0(n40), .C0(n32), .Y(n33) );
  CLKNAND2X2M U177 ( .A(n6), .B(n152), .Y(n44) );
  OAI31X1M U178 ( .A0(n43), .A1(n34), .A2(n33), .B0(n44), .Y(n36) );
  NAND2BX1M U179 ( .AN(n8), .B(B[5]), .Y(n51) );
  OAI211X1M U180 ( .A0(n48), .A1(n36), .B0(n35), .C0(n51), .Y(n37) );
  NAND2BX1M U181 ( .AN(B[5]), .B(n8), .Y(n47) );
  XNOR2X1M U182 ( .A(n9), .B(B[6]), .Y(n50) );
  AOI32X1M U183 ( .A0(n37), .A1(n47), .A2(n50), .B0(B[6]), .B1(n157), .Y(n38)
         );
  CLKNAND2X2M U184 ( .A(B[7]), .B(n156), .Y(n141) );
  OAI21X1M U185 ( .A0(n53), .A1(n38), .B0(n141), .Y(N170) );
  CLKNAND2X2M U186 ( .A(n3), .B(n144), .Y(n41) );
  OA21X1M U187 ( .A0(n41), .A1(n162), .B0(B[1]), .Y(n39) );
  AOI211X1M U188 ( .A0(n41), .A1(n162), .B0(n40), .C0(n39), .Y(n42) );
  AOI31X1M U189 ( .A0(n146), .A1(n45), .A2(n44), .B0(n43), .Y(n49) );
  OAI2B11X1M U190 ( .A1N(n49), .A0(n48), .B0(n47), .C0(n46), .Y(n52) );
  AOI32X1M U191 ( .A0(n52), .A1(n51), .A2(n50), .B0(n9), .B1(n149), .Y(n142)
         );
  AOI2B1X1M U192 ( .A1N(n142), .A0(n141), .B0(n53), .Y(n143) );
  CLKINVX1M U193 ( .A(n143), .Y(N169) );
  NOR2X1M U194 ( .A(N170), .B(N169), .Y(N168) );
  INVXLM U196 ( .A(test_se), .Y(n176) );
  INVXLM U197 ( .A(n176), .Y(n177) );
  DLY1X1M U198 ( .A(n177), .Y(n178) );
  DLY1X1M U199 ( .A(n177), .Y(n179) );
  DLY1X1M U200 ( .A(n177), .Y(n180) );
  ALU_DW_div_uns_0 div_46 ( .a({n27, n9, n8, n7, n6, n5, n4, n3}), .b(B), 
        .quotient({N111, N110, N109, N108, N107, N106, N105, N104}) );
  ALU_DW01_sub_0 sub_37 ( .A({1'b0, n27, n9, n8, n7, n6, n5, n4, n3}), .B({
        1'b0, B}), .CI(1'b0), .DIFF({N85, N84, N83, N82, N81, N80, N79, N78, 
        N77}) );
  ALU_DW01_add_0 add_33 ( .A({1'b0, n27, n9, n8, n7, n6, n5, n4, n3}), .B({
        1'b0, B}), .CI(1'b0), .SUM({N76, N75, N74, N73, N72, N71, N70, N69, 
        N68}) );
  ALU_DW02_mult_0 mult_41 ( .A({n27, n9, n8, n7, n6, n5, n4, n3}), .B(B), .TC(
        1'b0), .PRODUCT({N101, N100, N99, N98, N97, N96, N95, N94, N93, N92, 
        N91, N90, N89, N88, N87, N86}) );
endmodule


module FIFO_RD_test_1 ( rinc, rclk, rrst_n, rq2_wptr, rempty, raddr, rptr_gray, 
        test_si, test_se );
  input [3:0] rq2_wptr;
  output [2:0] raddr;
  output [3:0] rptr_gray;
  input rinc, rclk, rrst_n, test_si, test_se;
  output rempty;
  wire   \rcounter[3] , N9, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n1, n2, n3, n6, n7, n8, n9;

  SDFFSQX2M rempty_reg_reg ( .D(N9), .SI(\rcounter[3] ), .SE(n9), .CK(rclk), 
        .SN(n2), .Q(rempty) );
  INVX2M U12 ( .A(n3), .Y(n2) );
  INVX2M U13 ( .A(rrst_n), .Y(n3) );
  XNOR2X2M U14 ( .A(n19), .B(n20), .Y(n15) );
  XNOR2X2M U15 ( .A(n18), .B(n19), .Y(n17) );
  BUFX2M U16 ( .A(n16), .Y(n1) );
  CLKXOR2X2M U17 ( .A(n30), .B(raddr[2]), .Y(n19) );
  XNOR2X2M U18 ( .A(raddr[1]), .B(raddr[0]), .Y(n20) );
  OAI31X1M U19 ( .A0(n23), .A1(n24), .A2(n25), .B0(n22), .Y(N9) );
  XNOR2X2M U20 ( .A(rq2_wptr[1]), .B(n15), .Y(n25) );
  NAND3X2M U21 ( .A(rinc), .B(n31), .C(n32), .Y(n23) );
  XNOR2X2M U22 ( .A(rq2_wptr[2]), .B(n17), .Y(n24) );
  XNOR2X2M U23 ( .A(n20), .B(raddr[0]), .Y(n21) );
  CLKXOR2X2M U24 ( .A(rq2_wptr[0]), .B(n21), .Y(n31) );
  CLKXOR2X2M U25 ( .A(n18), .B(rq2_wptr[3]), .Y(n32) );
  NAND2X2M U26 ( .A(raddr[0]), .B(raddr[1]), .Y(n30) );
  XNOR2X2M U27 ( .A(\rcounter[3] ), .B(n33), .Y(n18) );
  NOR2BX2M U28 ( .AN(raddr[2]), .B(n30), .Y(n33) );
  OAI2BB2X1M U29 ( .B0(n17), .B1(n16), .A0N(n1), .A1N(rptr_gray[2]), .Y(n35)
         );
  XNOR2X2M U30 ( .A(rptr_gray[2]), .B(rq2_wptr[2]), .Y(n29) );
  NAND4X2M U31 ( .A(n26), .B(n27), .C(n28), .D(n29), .Y(n22) );
  XNOR2X2M U32 ( .A(rptr_gray[1]), .B(rq2_wptr[1]), .Y(n27) );
  XNOR2X2M U33 ( .A(rptr_gray[0]), .B(rq2_wptr[0]), .Y(n26) );
  XNOR2X2M U34 ( .A(rptr_gray[3]), .B(rq2_wptr[3]), .Y(n28) );
  XNOR2X2M U35 ( .A(raddr[0]), .B(n1), .Y(n40) );
  OAI2BB2X1M U36 ( .B0(n20), .B1(n16), .A0N(n1), .A1N(raddr[1]), .Y(n39) );
  OAI2BB2X1M U37 ( .B0(n18), .B1(n16), .A0N(n1), .A1N(\rcounter[3] ), .Y(n37)
         );
  OAI2BB2X1M U38 ( .B0(n18), .B1(n16), .A0N(n1), .A1N(rptr_gray[3]), .Y(n36)
         );
  OAI2BB2X1M U39 ( .B0(n19), .B1(n16), .A0N(n1), .A1N(raddr[2]), .Y(n38) );
  OAI2BB2X1M U40 ( .B0(n15), .B1(n16), .A0N(n1), .A1N(rptr_gray[1]), .Y(n34)
         );
  OAI2BB2X1M U41 ( .B0(n1), .B1(n21), .A0N(n1), .A1N(rptr_gray[0]), .Y(n41) );
  NAND2X2M U42 ( .A(rinc), .B(n22), .Y(n16) );
  INVXLM U43 ( .A(test_se), .Y(n6) );
  INVXLM U44 ( .A(n6), .Y(n7) );
  INVXLM U45 ( .A(n6), .Y(n8) );
  INVXLM U46 ( .A(n6), .Y(n9) );
  SDFFRQX2M \rptr_gray_reg_reg[3]  ( .D(n36), .SI(rptr_gray[2]), .SE(n7), .CK(
        rclk), .RN(n2), .Q(rptr_gray[3]) );
  SDFFRQX2M \rptr_gray_reg_reg[1]  ( .D(n34), .SI(rptr_gray[0]), .SE(n8), .CK(
        rclk), .RN(n2), .Q(rptr_gray[1]) );
  SDFFRQX2M \rptr_gray_reg_reg[0]  ( .D(n41), .SI(rempty), .SE(n8), .CK(rclk), 
        .RN(n2), .Q(rptr_gray[0]) );
  SDFFRQX2M \rcounter_reg[3]  ( .D(n37), .SI(raddr[2]), .SE(n7), .CK(rclk), 
        .RN(n2), .Q(\rcounter[3] ) );
  SDFFRQX2M \rcounter_reg[2]  ( .D(n38), .SI(raddr[1]), .SE(n8), .CK(rclk), 
        .RN(n2), .Q(raddr[2]) );
  SDFFRQX2M \rcounter_reg[1]  ( .D(n39), .SI(raddr[0]), .SE(n7), .CK(rclk), 
        .RN(n2), .Q(raddr[1]) );
  SDFFRQX2M \rptr_gray_reg_reg[2]  ( .D(n35), .SI(rptr_gray[1]), .SE(n9), .CK(
        rclk), .RN(n2), .Q(rptr_gray[2]) );
  SDFFRQX2M \rcounter_reg[0]  ( .D(n40), .SI(test_si), .SE(n9), .CK(rclk), 
        .RN(n2), .Q(raddr[0]) );
endmodule


module FIFO_WR_test_1 ( winc, wrst_n, wclk, wq2_rptr, waddr, wptr_gray, wfull, 
        test_si, test_se );
  input [3:0] wq2_rptr;
  output [2:0] waddr;
  output [3:0] wptr_gray;
  input winc, wrst_n, wclk, test_si, test_se;
  output wfull;
  wire   \wcounter[3] , N11, n12, n13, n14, n15, n16, n17, n18, n19, n1, n2,
         n5, n6, n7, n8;
  wire   [3:0] wcounter_next;
  wire   [2:0] wcounter_gray_next;

  SDFFRQX2M \wcounter_reg[3]  ( .D(wcounter_next[3]), .SI(waddr[2]), .SE(n8), 
        .CK(wclk), .RN(n1), .Q(\wcounter[3] ) );
  SDFFRQX2M \wcounter_reg[2]  ( .D(wcounter_next[2]), .SI(waddr[1]), .SE(n7), 
        .CK(wclk), .RN(n1), .Q(waddr[2]) );
  SDFFRQX2M wfull_reg_reg ( .D(N11), .SI(\wcounter[3] ), .SE(n6), .CK(wclk), 
        .RN(n1), .Q(wfull) );
  SDFFRQX2M \wptr_gray_reg_reg[3]  ( .D(wcounter_next[3]), .SI(wptr_gray[2]), 
        .SE(n8), .CK(wclk), .RN(n1), .Q(wptr_gray[3]) );
  SDFFRQX2M \wptr_gray_reg_reg[2]  ( .D(wcounter_gray_next[2]), .SI(
        wptr_gray[1]), .SE(n7), .CK(wclk), .RN(n1), .Q(wptr_gray[2]) );
  SDFFRQX2M \wptr_gray_reg_reg[1]  ( .D(wcounter_gray_next[1]), .SI(
        wptr_gray[0]), .SE(n6), .CK(wclk), .RN(n1), .Q(wptr_gray[1]) );
  SDFFRQX2M \wptr_gray_reg_reg[0]  ( .D(wcounter_gray_next[0]), .SI(wfull), 
        .SE(n8), .CK(wclk), .RN(n1), .Q(wptr_gray[0]) );
  SDFFRQX2M \wcounter_reg[1]  ( .D(wcounter_next[1]), .SI(waddr[0]), .SE(n7), 
        .CK(wclk), .RN(n1), .Q(waddr[1]) );
  SDFFRQX2M \wcounter_reg[0]  ( .D(wcounter_next[0]), .SI(test_si), .SE(n6), 
        .CK(wclk), .RN(n1), .Q(waddr[0]) );
  INVX2M U12 ( .A(n2), .Y(n1) );
  INVX2M U13 ( .A(wrst_n), .Y(n2) );
  CLKXOR2X2M U14 ( .A(wcounter_next[2]), .B(wcounter_next[1]), .Y(
        wcounter_gray_next[1]) );
  CLKXOR2X2M U15 ( .A(wcounter_next[1]), .B(wcounter_next[0]), .Y(
        wcounter_gray_next[0]) );
  CLKXOR2X2M U16 ( .A(wcounter_next[3]), .B(wcounter_next[2]), .Y(
        wcounter_gray_next[2]) );
  XNOR2X2M U17 ( .A(n19), .B(\wcounter[3] ), .Y(wcounter_next[3]) );
  NAND2X2M U18 ( .A(waddr[2]), .B(n18), .Y(n19) );
  CLKXOR2X2M U19 ( .A(n18), .B(waddr[2]), .Y(wcounter_next[2]) );
  XNOR2X2M U20 ( .A(n17), .B(waddr[1]), .Y(wcounter_next[1]) );
  CLKXOR2X2M U21 ( .A(n16), .B(waddr[0]), .Y(wcounter_next[0]) );
  XNOR2X2M U22 ( .A(wcounter_gray_next[2]), .B(wq2_rptr[2]), .Y(n13) );
  NAND2X2M U23 ( .A(waddr[0]), .B(n16), .Y(n17) );
  NOR2BX2M U24 ( .AN(winc), .B(wfull), .Y(n16) );
  NOR2BX2M U25 ( .AN(waddr[1]), .B(n17), .Y(n18) );
  NOR4X1M U26 ( .A(n12), .B(n13), .C(n14), .D(n15), .Y(N11) );
  CLKXOR2X2M U27 ( .A(wq2_rptr[0]), .B(wcounter_gray_next[0]), .Y(n14) );
  XNOR2X2M U28 ( .A(wcounter_next[3]), .B(wq2_rptr[3]), .Y(n12) );
  CLKXOR2X2M U29 ( .A(wq2_rptr[1]), .B(wcounter_gray_next[1]), .Y(n15) );
  INVXLM U30 ( .A(test_se), .Y(n5) );
  INVXLM U31 ( .A(n5), .Y(n6) );
  INVXLM U32 ( .A(n5), .Y(n7) );
  INVXLM U33 ( .A(n5), .Y(n8) );
endmodule


module FIFO_MEM_CNTRL_test_1 ( wclken, wclk, wrst_n, wdata, waddr, raddr, 
        rdata, test_si2, test_si1, test_so2, test_so1, test_se );
  input [7:0] wdata;
  input [2:0] waddr;
  input [2:0] raddr;
  output [7:0] rdata;
  input wclken, wclk, wrst_n, test_si2, test_si1, test_se;
  output test_so2, test_so1;
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
         \fifo_mem[0][0] , n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222;
  assign N10 = raddr[0];
  assign N11 = raddr[1];
  assign N12 = raddr[2];
  assign test_so2 = \fifo_mem[7][7] ;
  assign test_so1 = \fifo_mem[7][3] ;

  SDFFRQX2M \fifo_mem_reg[1][7]  ( .D(n100), .SI(\fifo_mem[1][6] ), .SE(n212), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[1][7] ) );
  SDFFRQX2M \fifo_mem_reg[1][6]  ( .D(n99), .SI(\fifo_mem[1][5] ), .SE(n211), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[1][6] ) );
  SDFFRQX2M \fifo_mem_reg[1][5]  ( .D(n98), .SI(\fifo_mem[1][4] ), .SE(n213), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[1][5] ) );
  SDFFRQX2M \fifo_mem_reg[1][4]  ( .D(n97), .SI(\fifo_mem[1][3] ), .SE(n212), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[1][4] ) );
  SDFFRQX2M \fifo_mem_reg[1][3]  ( .D(n96), .SI(\fifo_mem[1][2] ), .SE(n211), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[1][3] ) );
  SDFFRQX2M \fifo_mem_reg[1][2]  ( .D(n95), .SI(\fifo_mem[1][1] ), .SE(n213), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[1][2] ) );
  SDFFRQX2M \fifo_mem_reg[1][1]  ( .D(n94), .SI(\fifo_mem[1][0] ), .SE(n212), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[1][1] ) );
  SDFFRQX2M \fifo_mem_reg[1][0]  ( .D(n93), .SI(\fifo_mem[0][7] ), .SE(n211), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[1][0] ) );
  SDFFRQX2M \fifo_mem_reg[0][7]  ( .D(n92), .SI(\fifo_mem[0][6] ), .SE(n219), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[0][7] ) );
  SDFFRQX2M \fifo_mem_reg[0][6]  ( .D(n91), .SI(\fifo_mem[0][5] ), .SE(n217), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[0][6] ) );
  SDFFRQX2M \fifo_mem_reg[0][5]  ( .D(n90), .SI(\fifo_mem[0][4] ), .SE(n220), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[0][5] ) );
  SDFFRQX2M \fifo_mem_reg[0][4]  ( .D(n89), .SI(\fifo_mem[0][3] ), .SE(n221), 
        .CK(wclk), .RN(wrst_n), .Q(\fifo_mem[0][4] ) );
  SDFFRQX2M \fifo_mem_reg[0][3]  ( .D(n88), .SI(\fifo_mem[0][2] ), .SE(n220), 
        .CK(wclk), .RN(wrst_n), .Q(\fifo_mem[0][3] ) );
  SDFFRQX2M \fifo_mem_reg[0][2]  ( .D(n87), .SI(\fifo_mem[0][1] ), .SE(n221), 
        .CK(wclk), .RN(wrst_n), .Q(\fifo_mem[0][2] ) );
  SDFFRQX2M \fifo_mem_reg[0][1]  ( .D(n86), .SI(\fifo_mem[0][0] ), .SE(n214), 
        .CK(wclk), .RN(wrst_n), .Q(\fifo_mem[0][1] ) );
  SDFFRQX2M \fifo_mem_reg[0][0]  ( .D(n85), .SI(test_si1), .SE(n219), .CK(wclk), .RN(wrst_n), .Q(\fifo_mem[0][0] ) );
  SDFFRQX2M \fifo_mem_reg[5][7]  ( .D(n132), .SI(\fifo_mem[5][6] ), .SE(n219), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][7] ) );
  SDFFRQX2M \fifo_mem_reg[5][6]  ( .D(n131), .SI(\fifo_mem[5][5] ), .SE(n220), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][6] ) );
  SDFFRQX2M \fifo_mem_reg[5][5]  ( .D(n130), .SI(\fifo_mem[5][4] ), .SE(n217), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][5] ) );
  SDFFRQX2M \fifo_mem_reg[5][4]  ( .D(n129), .SI(\fifo_mem[5][3] ), .SE(n219), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][4] ) );
  SDFFRQX2M \fifo_mem_reg[5][3]  ( .D(n128), .SI(\fifo_mem[5][2] ), .SE(n216), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][3] ) );
  SDFFRQX2M \fifo_mem_reg[5][2]  ( .D(n127), .SI(\fifo_mem[5][1] ), .SE(n216), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][2] ) );
  SDFFRQX2M \fifo_mem_reg[5][1]  ( .D(n126), .SI(\fifo_mem[5][0] ), .SE(n220), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][1] ) );
  SDFFRQX2M \fifo_mem_reg[5][0]  ( .D(n125), .SI(\fifo_mem[4][7] ), .SE(n215), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[5][0] ) );
  SDFFRQX2M \fifo_mem_reg[4][7]  ( .D(n124), .SI(\fifo_mem[4][6] ), .SE(n219), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[4][7] ) );
  SDFFRQX2M \fifo_mem_reg[4][6]  ( .D(n123), .SI(\fifo_mem[4][5] ), .SE(n221), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[4][6] ) );
  SDFFRQX2M \fifo_mem_reg[4][5]  ( .D(n122), .SI(\fifo_mem[4][4] ), .SE(n214), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][5] ) );
  SDFFRQX2M \fifo_mem_reg[4][4]  ( .D(n121), .SI(\fifo_mem[4][3] ), .SE(n221), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][4] ) );
  SDFFRQX2M \fifo_mem_reg[4][3]  ( .D(n120), .SI(\fifo_mem[4][2] ), .SE(n215), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][3] ) );
  SDFFRQX2M \fifo_mem_reg[4][2]  ( .D(n119), .SI(\fifo_mem[4][1] ), .SE(n209), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][2] ) );
  SDFFRQX2M \fifo_mem_reg[4][1]  ( .D(n118), .SI(\fifo_mem[4][0] ), .SE(n219), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][1] ) );
  SDFFRQX2M \fifo_mem_reg[4][0]  ( .D(n117), .SI(\fifo_mem[3][7] ), .SE(n214), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[4][0] ) );
  SDFFRQX2M \fifo_mem_reg[7][7]  ( .D(n148), .SI(\fifo_mem[7][6] ), .SE(n221), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][7] ) );
  SDFFRQX2M \fifo_mem_reg[7][6]  ( .D(n147), .SI(\fifo_mem[7][5] ), .SE(n209), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][6] ) );
  SDFFRQX2M \fifo_mem_reg[7][5]  ( .D(n146), .SI(\fifo_mem[7][4] ), .SE(n221), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][5] ) );
  SDFFRQX2M \fifo_mem_reg[7][4]  ( .D(n145), .SI(test_si2), .SE(n220), .CK(
        wclk), .RN(n191), .Q(\fifo_mem[7][4] ) );
  SDFFRQX2M \fifo_mem_reg[7][3]  ( .D(n144), .SI(\fifo_mem[7][2] ), .SE(n215), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][3] ) );
  SDFFRQX2M \fifo_mem_reg[7][2]  ( .D(n143), .SI(\fifo_mem[7][1] ), .SE(n217), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][2] ) );
  SDFFRQX2M \fifo_mem_reg[7][1]  ( .D(n142), .SI(\fifo_mem[7][0] ), .SE(n215), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][1] ) );
  SDFFRQX2M \fifo_mem_reg[7][0]  ( .D(n141), .SI(\fifo_mem[6][7] ), .SE(n214), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[7][0] ) );
  SDFFRQX2M \fifo_mem_reg[6][7]  ( .D(n140), .SI(\fifo_mem[6][6] ), .SE(n217), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[6][7] ) );
  SDFFRQX2M \fifo_mem_reg[6][6]  ( .D(n139), .SI(\fifo_mem[6][5] ), .SE(n217), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[6][6] ) );
  SDFFRQX2M \fifo_mem_reg[6][5]  ( .D(n138), .SI(\fifo_mem[6][4] ), .SE(n216), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[6][5] ) );
  SDFFRQX2M \fifo_mem_reg[6][4]  ( .D(n137), .SI(\fifo_mem[6][3] ), .SE(n214), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[6][4] ) );
  SDFFRQX2M \fifo_mem_reg[6][3]  ( .D(n136), .SI(\fifo_mem[6][2] ), .SE(n208), 
        .CK(wclk), .RN(n191), .Q(\fifo_mem[6][3] ) );
  SDFFRQX2M \fifo_mem_reg[6][2]  ( .D(n135), .SI(\fifo_mem[6][1] ), .SE(n216), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[6][2] ) );
  SDFFRQX2M \fifo_mem_reg[6][1]  ( .D(n134), .SI(\fifo_mem[6][0] ), .SE(n217), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[6][1] ) );
  SDFFRQX2M \fifo_mem_reg[6][0]  ( .D(n133), .SI(\fifo_mem[5][7] ), .SE(n209), 
        .CK(wclk), .RN(n192), .Q(\fifo_mem[6][0] ) );
  SDFFRQX2M \fifo_mem_reg[3][7]  ( .D(n116), .SI(\fifo_mem[3][6] ), .SE(n216), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][7] ) );
  SDFFRQX2M \fifo_mem_reg[3][6]  ( .D(n115), .SI(\fifo_mem[3][5] ), .SE(n220), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][6] ) );
  SDFFRQX2M \fifo_mem_reg[3][5]  ( .D(n114), .SI(\fifo_mem[3][4] ), .SE(n215), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][5] ) );
  SDFFRQX2M \fifo_mem_reg[3][4]  ( .D(n113), .SI(\fifo_mem[3][3] ), .SE(n220), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][4] ) );
  SDFFRQX2M \fifo_mem_reg[3][3]  ( .D(n112), .SI(\fifo_mem[3][2] ), .SE(n214), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][3] ) );
  SDFFRQX2M \fifo_mem_reg[3][2]  ( .D(n111), .SI(\fifo_mem[3][1] ), .SE(n221), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][2] ) );
  SDFFRQX2M \fifo_mem_reg[3][1]  ( .D(n110), .SI(\fifo_mem[3][0] ), .SE(n214), 
        .CK(wclk), .RN(n193), .Q(\fifo_mem[3][1] ) );
  SDFFRQX2M \fifo_mem_reg[3][0]  ( .D(n109), .SI(\fifo_mem[2][7] ), .SE(n215), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[3][0] ) );
  SDFFRQX2M \fifo_mem_reg[2][7]  ( .D(n108), .SI(\fifo_mem[2][6] ), .SE(n210), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][7] ) );
  SDFFRQX2M \fifo_mem_reg[2][6]  ( .D(n107), .SI(\fifo_mem[2][5] ), .SE(n216), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][6] ) );
  SDFFRQX2M \fifo_mem_reg[2][5]  ( .D(n106), .SI(\fifo_mem[2][4] ), .SE(n208), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][5] ) );
  SDFFRQX2M \fifo_mem_reg[2][4]  ( .D(n105), .SI(\fifo_mem[2][3] ), .SE(n217), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][4] ) );
  SDFFRQX2M \fifo_mem_reg[2][3]  ( .D(n104), .SI(\fifo_mem[2][2] ), .SE(n219), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][3] ) );
  SDFFRQX2M \fifo_mem_reg[2][2]  ( .D(n103), .SI(\fifo_mem[2][1] ), .SE(n216), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][2] ) );
  SDFFRQX2M \fifo_mem_reg[2][1]  ( .D(n102), .SI(\fifo_mem[2][0] ), .SE(n210), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][1] ) );
  SDFFRQX2M \fifo_mem_reg[2][0]  ( .D(n101), .SI(\fifo_mem[1][7] ), .SE(n215), 
        .CK(wclk), .RN(n194), .Q(\fifo_mem[2][0] ) );
  CLKBUFX4M U66 ( .A(wrst_n), .Y(n191) );
  BUFX4M U67 ( .A(n79), .Y(n187) );
  BUFX4M U68 ( .A(n82), .Y(n185) );
  BUFX4M U69 ( .A(n83), .Y(n184) );
  BUFX4M U70 ( .A(n84), .Y(n183) );
  BUFX4M U71 ( .A(n77), .Y(n189) );
  BUFX4M U72 ( .A(n78), .Y(n188) );
  INVX2M U73 ( .A(wdata[0]), .Y(n197) );
  INVX2M U74 ( .A(wdata[1]), .Y(n198) );
  INVX2M U75 ( .A(wdata[2]), .Y(n199) );
  INVX2M U76 ( .A(wdata[3]), .Y(n200) );
  INVX2M U77 ( .A(wdata[4]), .Y(n201) );
  INVX2M U78 ( .A(wdata[5]), .Y(n202) );
  INVX2M U79 ( .A(wdata[6]), .Y(n203) );
  INVX2M U80 ( .A(wdata[7]), .Y(n204) );
  BUFX4M U81 ( .A(wrst_n), .Y(n194) );
  BUFX4M U82 ( .A(wrst_n), .Y(n193) );
  BUFX4M U83 ( .A(wrst_n), .Y(n192) );
  BUFX2M U84 ( .A(n80), .Y(n186) );
  BUFX2M U85 ( .A(n75), .Y(n190) );
  BUFX4M U86 ( .A(n171), .Y(n180) );
  NOR2X2M U87 ( .A(n175), .B(n176), .Y(n171) );
  INVX2M U88 ( .A(n178), .Y(n177) );
  NAND3X2M U89 ( .A(n195), .B(n196), .C(n76), .Y(n75) );
  NAND3X2M U90 ( .A(n195), .B(n196), .C(n81), .Y(n80) );
  INVX2M U91 ( .A(N12), .Y(n175) );
  INVX2M U92 ( .A(N11), .Y(n176) );
  BUFX4M U93 ( .A(n169), .Y(n181) );
  NOR2X2M U94 ( .A(n176), .B(N12), .Y(n169) );
  BUFX4M U95 ( .A(n172), .Y(n179) );
  NOR2X2M U96 ( .A(n175), .B(N11), .Y(n172) );
  BUFX4M U97 ( .A(n168), .Y(n182) );
  NOR2X2M U98 ( .A(N11), .B(N12), .Y(n168) );
  NOR2BX2M U99 ( .AN(wclken), .B(waddr[2]), .Y(n76) );
  OAI2BB2X1M U100 ( .B0(n197), .B1(n189), .A0N(\fifo_mem[1][0] ), .A1N(n189), 
        .Y(n93) );
  OAI2BB2X1M U101 ( .B0(n198), .B1(n189), .A0N(\fifo_mem[1][1] ), .A1N(n189), 
        .Y(n94) );
  OAI2BB2X1M U102 ( .B0(n199), .B1(n189), .A0N(\fifo_mem[1][2] ), .A1N(n189), 
        .Y(n95) );
  OAI2BB2X1M U103 ( .B0(n200), .B1(n189), .A0N(\fifo_mem[1][3] ), .A1N(n189), 
        .Y(n96) );
  OAI2BB2X1M U104 ( .B0(n201), .B1(n189), .A0N(\fifo_mem[1][4] ), .A1N(n189), 
        .Y(n97) );
  OAI2BB2X1M U105 ( .B0(n202), .B1(n189), .A0N(\fifo_mem[1][5] ), .A1N(n189), 
        .Y(n98) );
  OAI2BB2X1M U106 ( .B0(n203), .B1(n189), .A0N(\fifo_mem[1][6] ), .A1N(n189), 
        .Y(n99) );
  OAI2BB2X1M U107 ( .B0(n204), .B1(n189), .A0N(\fifo_mem[1][7] ), .A1N(n189), 
        .Y(n100) );
  OAI2BB2X1M U108 ( .B0(n197), .B1(n188), .A0N(\fifo_mem[2][0] ), .A1N(n188), 
        .Y(n101) );
  OAI2BB2X1M U109 ( .B0(n198), .B1(n188), .A0N(\fifo_mem[2][1] ), .A1N(n188), 
        .Y(n102) );
  OAI2BB2X1M U110 ( .B0(n199), .B1(n188), .A0N(\fifo_mem[2][2] ), .A1N(n188), 
        .Y(n103) );
  OAI2BB2X1M U111 ( .B0(n200), .B1(n188), .A0N(\fifo_mem[2][3] ), .A1N(n188), 
        .Y(n104) );
  OAI2BB2X1M U112 ( .B0(n201), .B1(n188), .A0N(\fifo_mem[2][4] ), .A1N(n188), 
        .Y(n105) );
  OAI2BB2X1M U113 ( .B0(n202), .B1(n188), .A0N(\fifo_mem[2][5] ), .A1N(n188), 
        .Y(n106) );
  OAI2BB2X1M U114 ( .B0(n203), .B1(n188), .A0N(\fifo_mem[2][6] ), .A1N(n188), 
        .Y(n107) );
  OAI2BB2X1M U115 ( .B0(n204), .B1(n188), .A0N(\fifo_mem[2][7] ), .A1N(n188), 
        .Y(n108) );
  OAI2BB2X1M U116 ( .B0(n197), .B1(n187), .A0N(\fifo_mem[3][0] ), .A1N(n187), 
        .Y(n109) );
  OAI2BB2X1M U117 ( .B0(n198), .B1(n187), .A0N(\fifo_mem[3][1] ), .A1N(n187), 
        .Y(n110) );
  OAI2BB2X1M U118 ( .B0(n199), .B1(n187), .A0N(\fifo_mem[3][2] ), .A1N(n187), 
        .Y(n111) );
  OAI2BB2X1M U119 ( .B0(n200), .B1(n187), .A0N(\fifo_mem[3][3] ), .A1N(n187), 
        .Y(n112) );
  OAI2BB2X1M U120 ( .B0(n201), .B1(n187), .A0N(\fifo_mem[3][4] ), .A1N(n187), 
        .Y(n113) );
  OAI2BB2X1M U121 ( .B0(n202), .B1(n187), .A0N(\fifo_mem[3][5] ), .A1N(n187), 
        .Y(n114) );
  OAI2BB2X1M U122 ( .B0(n203), .B1(n187), .A0N(\fifo_mem[3][6] ), .A1N(n187), 
        .Y(n115) );
  OAI2BB2X1M U123 ( .B0(n204), .B1(n187), .A0N(\fifo_mem[3][7] ), .A1N(n187), 
        .Y(n116) );
  OAI2BB2X1M U124 ( .B0(n197), .B1(n186), .A0N(\fifo_mem[4][0] ), .A1N(n186), 
        .Y(n117) );
  OAI2BB2X1M U125 ( .B0(n198), .B1(n186), .A0N(\fifo_mem[4][1] ), .A1N(n186), 
        .Y(n118) );
  OAI2BB2X1M U126 ( .B0(n199), .B1(n186), .A0N(\fifo_mem[4][2] ), .A1N(n186), 
        .Y(n119) );
  OAI2BB2X1M U127 ( .B0(n200), .B1(n80), .A0N(\fifo_mem[4][3] ), .A1N(n186), 
        .Y(n120) );
  OAI2BB2X1M U128 ( .B0(n201), .B1(n80), .A0N(\fifo_mem[4][4] ), .A1N(n186), 
        .Y(n121) );
  OAI2BB2X1M U129 ( .B0(n202), .B1(n80), .A0N(\fifo_mem[4][5] ), .A1N(n186), 
        .Y(n122) );
  OAI2BB2X1M U130 ( .B0(n203), .B1(n80), .A0N(\fifo_mem[4][6] ), .A1N(n186), 
        .Y(n123) );
  OAI2BB2X1M U131 ( .B0(n204), .B1(n80), .A0N(\fifo_mem[4][7] ), .A1N(n186), 
        .Y(n124) );
  OAI2BB2X1M U132 ( .B0(n197), .B1(n185), .A0N(\fifo_mem[5][0] ), .A1N(n185), 
        .Y(n125) );
  OAI2BB2X1M U133 ( .B0(n198), .B1(n185), .A0N(\fifo_mem[5][1] ), .A1N(n185), 
        .Y(n126) );
  OAI2BB2X1M U134 ( .B0(n199), .B1(n185), .A0N(\fifo_mem[5][2] ), .A1N(n185), 
        .Y(n127) );
  OAI2BB2X1M U135 ( .B0(n200), .B1(n185), .A0N(\fifo_mem[5][3] ), .A1N(n185), 
        .Y(n128) );
  OAI2BB2X1M U136 ( .B0(n201), .B1(n185), .A0N(\fifo_mem[5][4] ), .A1N(n185), 
        .Y(n129) );
  OAI2BB2X1M U137 ( .B0(n202), .B1(n185), .A0N(\fifo_mem[5][5] ), .A1N(n185), 
        .Y(n130) );
  OAI2BB2X1M U138 ( .B0(n203), .B1(n185), .A0N(\fifo_mem[5][6] ), .A1N(n185), 
        .Y(n131) );
  OAI2BB2X1M U139 ( .B0(n204), .B1(n185), .A0N(\fifo_mem[5][7] ), .A1N(n185), 
        .Y(n132) );
  OAI2BB2X1M U140 ( .B0(n197), .B1(n184), .A0N(\fifo_mem[6][0] ), .A1N(n184), 
        .Y(n133) );
  OAI2BB2X1M U141 ( .B0(n198), .B1(n184), .A0N(\fifo_mem[6][1] ), .A1N(n184), 
        .Y(n134) );
  OAI2BB2X1M U142 ( .B0(n199), .B1(n184), .A0N(\fifo_mem[6][2] ), .A1N(n184), 
        .Y(n135) );
  OAI2BB2X1M U143 ( .B0(n200), .B1(n184), .A0N(\fifo_mem[6][3] ), .A1N(n184), 
        .Y(n136) );
  OAI2BB2X1M U144 ( .B0(n201), .B1(n184), .A0N(\fifo_mem[6][4] ), .A1N(n184), 
        .Y(n137) );
  OAI2BB2X1M U145 ( .B0(n202), .B1(n184), .A0N(\fifo_mem[6][5] ), .A1N(n184), 
        .Y(n138) );
  OAI2BB2X1M U146 ( .B0(n203), .B1(n184), .A0N(\fifo_mem[6][6] ), .A1N(n184), 
        .Y(n139) );
  OAI2BB2X1M U147 ( .B0(n204), .B1(n184), .A0N(\fifo_mem[6][7] ), .A1N(n184), 
        .Y(n140) );
  OAI2BB2X1M U148 ( .B0(n197), .B1(n183), .A0N(\fifo_mem[7][0] ), .A1N(n183), 
        .Y(n141) );
  OAI2BB2X1M U149 ( .B0(n198), .B1(n183), .A0N(\fifo_mem[7][1] ), .A1N(n183), 
        .Y(n142) );
  OAI2BB2X1M U150 ( .B0(n199), .B1(n183), .A0N(\fifo_mem[7][2] ), .A1N(n183), 
        .Y(n143) );
  OAI2BB2X1M U151 ( .B0(n200), .B1(n183), .A0N(\fifo_mem[7][3] ), .A1N(n183), 
        .Y(n144) );
  OAI2BB2X1M U152 ( .B0(n201), .B1(n183), .A0N(\fifo_mem[7][4] ), .A1N(n183), 
        .Y(n145) );
  OAI2BB2X1M U153 ( .B0(n202), .B1(n183), .A0N(\fifo_mem[7][5] ), .A1N(n183), 
        .Y(n146) );
  OAI2BB2X1M U154 ( .B0(n203), .B1(n183), .A0N(\fifo_mem[7][6] ), .A1N(n183), 
        .Y(n147) );
  OAI2BB2X1M U155 ( .B0(n204), .B1(n183), .A0N(\fifo_mem[7][7] ), .A1N(n183), 
        .Y(n148) );
  NAND3X2M U156 ( .A(waddr[0]), .B(n76), .C(waddr[1]), .Y(n79) );
  NAND3X2M U157 ( .A(waddr[0]), .B(n196), .C(n81), .Y(n82) );
  OAI2BB2X1M U158 ( .B0(n190), .B1(n197), .A0N(\fifo_mem[0][0] ), .A1N(n190), 
        .Y(n85) );
  OAI2BB2X1M U159 ( .B0(n190), .B1(n198), .A0N(\fifo_mem[0][1] ), .A1N(n190), 
        .Y(n86) );
  OAI2BB2X1M U160 ( .B0(n190), .B1(n199), .A0N(\fifo_mem[0][2] ), .A1N(n190), 
        .Y(n87) );
  OAI2BB2X1M U161 ( .B0(n75), .B1(n200), .A0N(\fifo_mem[0][3] ), .A1N(n190), 
        .Y(n88) );
  OAI2BB2X1M U162 ( .B0(n75), .B1(n201), .A0N(\fifo_mem[0][4] ), .A1N(n190), 
        .Y(n89) );
  OAI2BB2X1M U163 ( .B0(n75), .B1(n202), .A0N(\fifo_mem[0][5] ), .A1N(n190), 
        .Y(n90) );
  OAI2BB2X1M U164 ( .B0(n75), .B1(n203), .A0N(\fifo_mem[0][6] ), .A1N(n190), 
        .Y(n91) );
  OAI2BB2X1M U165 ( .B0(n75), .B1(n204), .A0N(\fifo_mem[0][7] ), .A1N(n190), 
        .Y(n92) );
  NAND3X2M U166 ( .A(waddr[1]), .B(n195), .C(n81), .Y(n83) );
  NAND3X2M U167 ( .A(waddr[1]), .B(waddr[0]), .C(n81), .Y(n84) );
  NAND3X2M U168 ( .A(n76), .B(n196), .C(waddr[0]), .Y(n77) );
  NAND3X2M U169 ( .A(n76), .B(n195), .C(waddr[1]), .Y(n78) );
  AND2X2M U170 ( .A(waddr[2]), .B(wclken), .Y(n81) );
  BUFX2M U171 ( .A(N10), .Y(n178) );
  INVX2M U172 ( .A(waddr[0]), .Y(n195) );
  INVX2M U173 ( .A(waddr[1]), .Y(n196) );
  AO22X1M U174 ( .A0(\fifo_mem[3][0] ), .A1(n181), .B0(\fifo_mem[1][0] ), .B1(
        n182), .Y(n65) );
  AOI221XLM U175 ( .A0(\fifo_mem[5][0] ), .A1(n179), .B0(\fifo_mem[7][0] ), 
        .B1(n180), .C0(n65), .Y(n68) );
  AO22X1M U176 ( .A0(\fifo_mem[2][0] ), .A1(n181), .B0(\fifo_mem[0][0] ), .B1(
        n182), .Y(n66) );
  AOI221XLM U177 ( .A0(\fifo_mem[4][0] ), .A1(n179), .B0(\fifo_mem[6][0] ), 
        .B1(n180), .C0(n66), .Y(n67) );
  OAI22X1M U178 ( .A0(n177), .A1(n68), .B0(n178), .B1(n67), .Y(rdata[0]) );
  AO22X1M U179 ( .A0(\fifo_mem[3][1] ), .A1(n181), .B0(\fifo_mem[1][1] ), .B1(
        n182), .Y(n69) );
  AOI221XLM U180 ( .A0(\fifo_mem[5][1] ), .A1(n179), .B0(\fifo_mem[7][1] ), 
        .B1(n180), .C0(n69), .Y(n72) );
  AO22X1M U181 ( .A0(\fifo_mem[2][1] ), .A1(n181), .B0(\fifo_mem[0][1] ), .B1(
        n182), .Y(n70) );
  AOI221XLM U182 ( .A0(\fifo_mem[4][1] ), .A1(n179), .B0(\fifo_mem[6][1] ), 
        .B1(n180), .C0(n70), .Y(n71) );
  OAI22X1M U183 ( .A0(n177), .A1(n72), .B0(n178), .B1(n71), .Y(rdata[1]) );
  AO22X1M U184 ( .A0(\fifo_mem[3][2] ), .A1(n181), .B0(\fifo_mem[1][2] ), .B1(
        n182), .Y(n73) );
  AOI221XLM U185 ( .A0(\fifo_mem[5][2] ), .A1(n179), .B0(\fifo_mem[7][2] ), 
        .B1(n180), .C0(n73), .Y(n150) );
  AO22X1M U186 ( .A0(\fifo_mem[2][2] ), .A1(n181), .B0(\fifo_mem[0][2] ), .B1(
        n182), .Y(n74) );
  AOI221XLM U187 ( .A0(\fifo_mem[4][2] ), .A1(n179), .B0(\fifo_mem[6][2] ), 
        .B1(n180), .C0(n74), .Y(n149) );
  OAI22X1M U188 ( .A0(n177), .A1(n150), .B0(n178), .B1(n149), .Y(rdata[2]) );
  AO22X1M U189 ( .A0(\fifo_mem[3][3] ), .A1(n181), .B0(\fifo_mem[1][3] ), .B1(
        n182), .Y(n151) );
  AOI221XLM U190 ( .A0(\fifo_mem[5][3] ), .A1(n179), .B0(\fifo_mem[7][3] ), 
        .B1(n180), .C0(n151), .Y(n154) );
  AO22X1M U191 ( .A0(\fifo_mem[2][3] ), .A1(n181), .B0(\fifo_mem[0][3] ), .B1(
        n182), .Y(n152) );
  AOI221XLM U192 ( .A0(\fifo_mem[4][3] ), .A1(n179), .B0(\fifo_mem[6][3] ), 
        .B1(n180), .C0(n152), .Y(n153) );
  OAI22X1M U193 ( .A0(n177), .A1(n154), .B0(n178), .B1(n153), .Y(rdata[3]) );
  AO22X1M U194 ( .A0(\fifo_mem[3][4] ), .A1(n181), .B0(\fifo_mem[1][4] ), .B1(
        n182), .Y(n155) );
  AOI221XLM U195 ( .A0(\fifo_mem[5][4] ), .A1(n179), .B0(\fifo_mem[7][4] ), 
        .B1(n180), .C0(n155), .Y(n158) );
  AO22X1M U196 ( .A0(\fifo_mem[2][4] ), .A1(n181), .B0(\fifo_mem[0][4] ), .B1(
        n182), .Y(n156) );
  AOI221XLM U197 ( .A0(\fifo_mem[4][4] ), .A1(n179), .B0(\fifo_mem[6][4] ), 
        .B1(n180), .C0(n156), .Y(n157) );
  OAI22X1M U198 ( .A0(n177), .A1(n158), .B0(n178), .B1(n157), .Y(rdata[4]) );
  AO22X1M U199 ( .A0(\fifo_mem[3][5] ), .A1(n181), .B0(\fifo_mem[1][5] ), .B1(
        n182), .Y(n159) );
  AOI221XLM U200 ( .A0(\fifo_mem[5][5] ), .A1(n179), .B0(\fifo_mem[7][5] ), 
        .B1(n180), .C0(n159), .Y(n162) );
  AO22X1M U201 ( .A0(\fifo_mem[2][5] ), .A1(n181), .B0(\fifo_mem[0][5] ), .B1(
        n182), .Y(n160) );
  AOI221XLM U202 ( .A0(\fifo_mem[4][5] ), .A1(n179), .B0(\fifo_mem[6][5] ), 
        .B1(n180), .C0(n160), .Y(n161) );
  OAI22X1M U203 ( .A0(n177), .A1(n162), .B0(n178), .B1(n161), .Y(rdata[5]) );
  AO22X1M U204 ( .A0(\fifo_mem[3][6] ), .A1(n181), .B0(\fifo_mem[1][6] ), .B1(
        n182), .Y(n163) );
  AOI221XLM U205 ( .A0(\fifo_mem[5][6] ), .A1(n179), .B0(\fifo_mem[7][6] ), 
        .B1(n180), .C0(n163), .Y(n166) );
  AO22X1M U206 ( .A0(\fifo_mem[2][6] ), .A1(n181), .B0(\fifo_mem[0][6] ), .B1(
        n182), .Y(n164) );
  AOI221XLM U207 ( .A0(\fifo_mem[4][6] ), .A1(n179), .B0(\fifo_mem[6][6] ), 
        .B1(n180), .C0(n164), .Y(n165) );
  OAI22X1M U208 ( .A0(n177), .A1(n166), .B0(n178), .B1(n165), .Y(rdata[6]) );
  AO22X1M U209 ( .A0(\fifo_mem[3][7] ), .A1(n181), .B0(\fifo_mem[1][7] ), .B1(
        n182), .Y(n167) );
  AOI221XLM U210 ( .A0(\fifo_mem[5][7] ), .A1(n179), .B0(\fifo_mem[7][7] ), 
        .B1(n180), .C0(n167), .Y(n174) );
  AO22X1M U211 ( .A0(\fifo_mem[2][7] ), .A1(n181), .B0(\fifo_mem[0][7] ), .B1(
        n182), .Y(n170) );
  AOI221XLM U212 ( .A0(\fifo_mem[4][7] ), .A1(n179), .B0(\fifo_mem[6][7] ), 
        .B1(n180), .C0(n170), .Y(n173) );
  OAI22X1M U213 ( .A0(n174), .A1(n177), .B0(n178), .B1(n173), .Y(rdata[7]) );
  INVXLM U214 ( .A(test_se), .Y(n218) );
  INVXLM U215 ( .A(n218), .Y(n208) );
  INVXLM U216 ( .A(n218), .Y(n209) );
  INVXLM U217 ( .A(n218), .Y(n210) );
  INVXLM U218 ( .A(n208), .Y(n222) );
  INVXLM U219 ( .A(n222), .Y(n211) );
  INVXLM U220 ( .A(n222), .Y(n212) );
  INVXLM U221 ( .A(n222), .Y(n213) );
  DLY1X1M U222 ( .A(test_se), .Y(n214) );
  DLY1X1M U223 ( .A(test_se), .Y(n215) );
  DLY1X1M U224 ( .A(test_se), .Y(n216) );
  DLY1X1M U225 ( .A(test_se), .Y(n217) );
  DLY1X1M U226 ( .A(n210), .Y(n219) );
  DLY1X1M U227 ( .A(test_se), .Y(n220) );
  DLY1X1M U228 ( .A(test_se), .Y(n221) );
endmodule


module DF_SYNC_test_0 ( ptr, clk, rst, sync_out, test_si, test_so, test_se );
  input [3:0] ptr;
  output [3:0] sync_out;
  input clk, rst, test_si, test_se;
  output test_so;
  wire   n3, n4, n5, n6;
  wire   [3:0] sync_reg;
  assign test_so = sync_reg[3];

  INVXLM U11 ( .A(test_se), .Y(n3) );
  INVXLM U12 ( .A(n3), .Y(n4) );
  INVXLM U13 ( .A(n3), .Y(n5) );
  INVXLM U14 ( .A(n3), .Y(n6) );
  SDFFRQX2M \sync_reg_reg[2]  ( .D(ptr[2]), .SI(sync_reg[1]), .SE(n6), .CK(clk), .RN(rst), .Q(sync_reg[2]) );
  SDFFRQX2M \sync_out_reg[0]  ( .D(sync_reg[0]), .SI(test_si), .SE(n6), .CK(
        clk), .RN(rst), .Q(sync_out[0]) );
  SDFFRQX2M \sync_reg_reg[3]  ( .D(ptr[3]), .SI(sync_reg[2]), .SE(n4), .CK(clk), .RN(rst), .Q(sync_reg[3]) );
  SDFFRQX2M \sync_reg_reg[1]  ( .D(ptr[1]), .SI(sync_reg[0]), .SE(n5), .CK(clk), .RN(rst), .Q(sync_reg[1]) );
  SDFFRQX2M \sync_reg_reg[0]  ( .D(ptr[0]), .SI(sync_out[3]), .SE(n4), .CK(clk), .RN(rst), .Q(sync_reg[0]) );
  SDFFRQX2M \sync_out_reg[3]  ( .D(sync_reg[3]), .SI(sync_out[2]), .SE(n5), 
        .CK(clk), .RN(rst), .Q(sync_out[3]) );
  SDFFRQX2M \sync_out_reg[2]  ( .D(sync_reg[2]), .SI(sync_out[1]), .SE(n5), 
        .CK(clk), .RN(rst), .Q(sync_out[2]) );
  SDFFRQX2M \sync_out_reg[1]  ( .D(sync_reg[1]), .SI(sync_out[0]), .SE(n4), 
        .CK(clk), .RN(rst), .Q(sync_out[1]) );
endmodule


module DF_SYNC_test_1 ( ptr, clk, rst, sync_out, test_si, test_so, test_se );
  input [3:0] ptr;
  output [3:0] sync_out;
  input clk, rst, test_si, test_se;
  output test_so;
  wire   n9, n10, n21, n22, n23, n24;
  wire   [3:0] sync_reg;
  assign test_so = sync_reg[3];

  SDFFRQX2M \sync_out_reg[1]  ( .D(sync_reg[1]), .SI(sync_out[0]), .SE(n23), 
        .CK(clk), .RN(n9), .Q(sync_out[1]) );
  SDFFRQX2M \sync_out_reg[0]  ( .D(sync_reg[0]), .SI(test_si), .SE(n22), .CK(
        clk), .RN(n9), .Q(sync_out[0]) );
  SDFFRQX2M \sync_out_reg[3]  ( .D(sync_reg[3]), .SI(sync_out[2]), .SE(n24), 
        .CK(clk), .RN(n9), .Q(sync_out[3]) );
  SDFFRQX2M \sync_out_reg[2]  ( .D(sync_reg[2]), .SI(sync_out[1]), .SE(n23), 
        .CK(clk), .RN(n9), .Q(sync_out[2]) );
  SDFFRQX2M \sync_reg_reg[3]  ( .D(ptr[3]), .SI(sync_reg[2]), .SE(n22), .CK(
        clk), .RN(n9), .Q(sync_reg[3]) );
  SDFFRQX2M \sync_reg_reg[2]  ( .D(ptr[2]), .SI(sync_reg[1]), .SE(n24), .CK(
        clk), .RN(n9), .Q(sync_reg[2]) );
  SDFFRQX2M \sync_reg_reg[1]  ( .D(ptr[1]), .SI(sync_reg[0]), .SE(n23), .CK(
        clk), .RN(n9), .Q(sync_reg[1]) );
  SDFFRQX2M \sync_reg_reg[0]  ( .D(ptr[0]), .SI(sync_out[3]), .SE(n22), .CK(
        clk), .RN(n9), .Q(sync_reg[0]) );
  INVX2M U11 ( .A(n10), .Y(n9) );
  INVX2M U12 ( .A(rst), .Y(n10) );
  INVXLM U13 ( .A(test_se), .Y(n21) );
  INVXLM U14 ( .A(n21), .Y(n22) );
  INVXLM U15 ( .A(n21), .Y(n23) );
  INVXLM U16 ( .A(n21), .Y(n24) );
endmodule


module ASYNC_FIFO_test_1 ( wdata, winc, rinc, wclk, rclk, wrst_n, rrst_n, 
        rdata, rempty, wfull, test_si2, test_si1, test_so2, test_so1, test_se
 );
  input [7:0] wdata;
  output [7:0] rdata;
  input winc, rinc, wclk, rclk, wrst_n, rrst_n, test_si2, test_si1, test_se;
  output rempty, wfull, test_so2, test_so1;
  wire   wclken, n1, n2, n3, n4, n7, n8, n12, n13, n14, n15;
  wire   [2:0] raddr;
  wire   [3:0] rptr_gray;
  wire   [3:0] rq2_wptr;
  wire   [2:0] waddr;
  wire   [3:0] wptr_gray;
  wire   [3:0] wq2_rptr;

  INVX2M U5 ( .A(n4), .Y(n3) );
  INVX2M U6 ( .A(wrst_n), .Y(n4) );
  INVX2M U7 ( .A(n2), .Y(n1) );
  INVX2M U8 ( .A(rrst_n), .Y(n2) );
  NOR2BX2M U9 ( .AN(winc), .B(wfull), .Y(wclken) );
  DLY1X1M U10 ( .A(test_se), .Y(n12) );
  DLY1X1M U11 ( .A(test_se), .Y(n13) );
  DLY1X1M U12 ( .A(test_se), .Y(n14) );
  DLY1X1M U13 ( .A(test_se), .Y(n15) );
  FIFO_RD_test_1 U0 ( .rinc(rinc), .rclk(rclk), .rrst_n(n1), .rq2_wptr(
        rq2_wptr), .rempty(rempty), .raddr(raddr), .rptr_gray(rptr_gray), 
        .test_si(test_si1), .test_se(n13) );
  FIFO_WR_test_1 U1 ( .winc(winc), .wrst_n(n3), .wclk(wclk), .wq2_rptr(
        wq2_rptr), .waddr(waddr), .wptr_gray(wptr_gray), .wfull(wfull), 
        .test_si(rptr_gray[3]), .test_se(n15) );
  FIFO_MEM_CNTRL_test_1 U2 ( .wclken(wclken), .wclk(wclk), .wrst_n(n3), 
        .wdata(wdata), .waddr(waddr), .raddr(raddr), .rdata(rdata), .test_si2(
        test_si2), .test_si1(wptr_gray[3]), .test_so2(n8), .test_so1(test_so1), 
        .test_se(n12) );
  DF_SYNC_test_0 U3 ( .ptr(wptr_gray), .clk(rclk), .rst(n1), .sync_out(
        rq2_wptr), .test_si(n8), .test_so(n7), .test_se(n14) );
  DF_SYNC_test_1 U4 ( .ptr(rptr_gray), .clk(wclk), .rst(n3), .sync_out(
        wq2_rptr), .test_si(n7), .test_so(test_so2), .test_se(n14) );
endmodule


module Pulse_Gen_test_1 ( clk, rst, async, sync, test_si, test_so, test_se );
  input clk, rst, async, test_si, test_se;
  output sync, test_so;
  wire   sync_d, N1;
  wire   [1:0] sync_reg;
  assign test_so = sync_reg[1];

  SDFFRQX1M \sync_reg_reg[1]  ( .D(sync_reg[0]), .SI(sync_reg[0]), .SE(test_se), .CK(clk), .RN(rst), .Q(sync_reg[1]) );
  NOR2BX2M U7 ( .AN(sync_reg[1]), .B(sync_d), .Y(N1) );
  SDFFRQX2M \sync_reg_reg[0]  ( .D(async), .SI(sync), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(sync_reg[0]) );
  SDFFRQX2M sync_reg_inst ( .D(N1), .SI(sync_d), .SE(test_se), .CK(clk), .RN(
        rst), .Q(sync) );
  SDFFRQX2M sync_d_reg ( .D(sync_reg[1]), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(sync_d) );
endmodule


module SYSTEM_TOP ( REF_CLK, UART_CLK, RST, RX_IN, scan_clk, scan_rst, 
        test_mode, SE, SI, SO, TX_OUT, parity_error, framing_error );
  input [3:0] SI;
  output [3:0] SO;
  input REF_CLK, UART_CLK, RST, RX_IN, scan_clk, scan_rst, test_mode, SE;
  output TX_OUT, parity_error, framing_error;
  wire   N0, TX_CLK_M, TX_CLK, RX_CLK_M, RX_CLK, REF_CLK_M, UART_CLK_M,
         GATED_CLK_M, RST_M, REF_RST_M, REF_RST, UART_RST_M, UART_RST,
         RX_OUT_V, UART_TX_BUSY, enable_pulse, Rd_D_Vld, ALU_OUT_V, FIFO_FULL,
         en, WrEn, RdEn, Gate_EN, WR_INC, FIFO_RINC, FIFO_EMPTY, n1, n2, n3,
         n4, n5, n7, n8, n9, n10, n13, n16, n17, n21, n22, n23, n24, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38;
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
wand  _1_net_;
  assign N0 = test_mode;

  CLK_GATE U0_CLK_GATE ( .clk(REF_CLK_M), .clk_en(Gate_EN), .gated_clk(_1_net_) );
  OR2X12M C89 ( .A(1'b0), .B(N0), .Y(_1_net_) );
  INVX2M U11 ( .A(n3), .Y(n2) );
  INVX2M U12 ( .A(n5), .Y(n4) );
  INVX2M U13 ( .A(FIFO_EMPTY), .Y(n1) );
  MX2X2M U14 ( .A(RST), .B(scan_rst), .S0(N0), .Y(RST_M) );
  INVX2M U15 ( .A(UART_RST_M), .Y(n3) );
  MX2X2M U16 ( .A(UART_RST), .B(scan_rst), .S0(N0), .Y(UART_RST_M) );
  INVX2M U17 ( .A(REF_RST_M), .Y(n5) );
  MX2X2M U18 ( .A(REF_RST), .B(scan_rst), .S0(N0), .Y(REF_RST_M) );
  CLKMX2X4M U19 ( .A(REF_CLK), .B(scan_clk), .S0(N0), .Y(REF_CLK_M) );
  CLKMX2X4M U20 ( .A(UART_CLK), .B(scan_clk), .S0(N0), .Y(UART_CLK_M) );
  CLKMX2X4M U21 ( .A(TX_CLK), .B(scan_clk), .S0(N0), .Y(TX_CLK_M) );
  CLKMX2X4M U22 ( .A(RX_CLK), .B(scan_clk), .S0(N0), .Y(RX_CLK_M) );
  CLKMX2X4M U23 ( .A(1'b0), .B(scan_clk), .S0(N0), .Y(GATED_CLK_M) );
  DLY1X1M U25 ( .A(n26), .Y(n28) );
  INVXLM U26 ( .A(n28), .Y(n21) );
  INVXLM U27 ( .A(n28), .Y(n22) );
  INVXLM U28 ( .A(n28), .Y(n23) );
  INVXLM U29 ( .A(n28), .Y(n24) );
  DLY1X1M U31 ( .A(SE), .Y(n27) );
  INVXLM U32 ( .A(n27), .Y(n26) );
  DLY1X1M U33 ( .A(n32), .Y(n29) );
  DLY1X1M U34 ( .A(n36), .Y(n30) );
  INVXLM U35 ( .A(n38), .Y(n31) );
  INVXLM U36 ( .A(n31), .Y(n32) );
  INVXLM U37 ( .A(n38), .Y(n33) );
  INVXLM U38 ( .A(n33), .Y(n34) );
  INVXLM U39 ( .A(n38), .Y(n35) );
  INVXLM U40 ( .A(n35), .Y(n36) );
  INVXLM U41 ( .A(n26), .Y(n37) );
  INVXLM U42 ( .A(n26), .Y(n38) );
  prescale_mux U0_prescale_mux ( .prescale(REG2[7:2]), .div_ratio(rx_div_ratio) );
  CLK_DIV_test_0 U0_TX_CLK_DIV ( .i_ref_clk(UART_CLK_M), .i_rst_n(n2), 
        .i_clk_en(1'b1), .i_div_ratio(REG3), .o_div_clk(TX_CLK), .test_si(n10), 
        .test_so(n9), .test_se(n23) );
  CLK_DIV_test_1 U1_RX_CLK_DIV ( .i_ref_clk(UART_CLK_M), .i_rst_n(n2), 
        .i_clk_en(1'b1), .i_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        rx_div_ratio}), .o_div_clk(RX_CLK), .test_si(UART_RST), .test_so(n7), 
        .test_se(n24) );
  RST_SYNC_test_0 U0_RST_SYNC ( .rst(RST_M), .clk(REF_CLK_M), .sync_rst(
        REF_RST), .test_si(n13), .test_se(n34) );
  RST_SYNC_test_1 U1_RST_SYNC ( .rst(RST_M), .clk(UART_CLK_M), .sync_rst(
        UART_RST), .test_si(n8), .test_se(n29) );
  UART_test_1 U0_UART ( .RST(n2), .TX_CLK(TX_CLK_M), .RX_CLK(RX_CLK_M), 
        .RX_IN_S(RX_IN), .parity_enable(REG2[0]), .parity_type(REG2[1]), 
        .TX_IN_V(n1), .Prescale(REG2[7:2]), .TX_IN_P(FIFO_RDATA), .RX_OUT_P(
        RX_OUT_P), .RX_OUT_V(RX_OUT_V), .TX_OUT_S(TX_OUT), .TX_OUT_V(
        UART_TX_BUSY), .parity_error(parity_error), .framing_error(SO[0]), 
        .test_si2(n7), .test_si1(n9), .test_so1(n8), .test_se(n21) );
  DATA_SYNC_test_1 U0_DATA_SYNC ( .clk(REF_CLK_M), .rst(n4), .bus_enable(
        RX_OUT_V), .unsync_bus(RX_OUT_P), .sync_bus(sync_bus), .enable_pulse(
        enable_pulse), .test_si(n17), .test_se(n30) );
  SYS_CTRL_test_1 U0_SYS_CTRL ( .Rd_D(Rd_D), .sync_bus(sync_bus), .Rd_D_Vld(
        Rd_D_Vld), .clk(REF_CLK_M), .rst(n4), .out_valid(ALU_OUT_V), 
        .enable_pulse(enable_pulse), .FIFO_FULL(FIFO_FULL), .ALU_OUT(ALU_OUT), 
        .Addr(Addr), .FUN(FUN), .en(en), .WrEn(WrEn), .RdEn(RdEn), .Gate_EN(
        Gate_EN), .WR_INC(WR_INC), .Wr_D(Wr_D), .WR_DATA(WR_DATA), .test_si2(
        SI[0]), .test_si1(REF_RST), .test_so2(n10), .test_so1(SO[1]), 
        .test_se(n22) );
  regfile_test_1 U0_REGFILE ( .WrEn(WrEn), .RdEn(RdEn), .clk(REF_CLK_M), .rst(
        n4), .WrData(Wr_D), .Address(Addr), .RdData(Rd_D), .Rd_Data_Valid(
        Rd_D_Vld), .REG0(REG0), .REG1(REG1), .REG2(REG2), .REG3(REG3), 
        .test_si2(SI[1]), .test_si1(n16), .test_so2(n13), .test_so1(SO[2]), 
        .test_se(SE) );
  ALU_test_1 U0_ALU ( .A(REG0), .B(REG1), .ALU_FUN(FUN), .clk(GATED_CLK_M), 
        .en(en), .rst(n4), .ALU_OUT(ALU_OUT), .out_valid(ALU_OUT_V), .test_si(
        SI[3]), .test_se(n21) );
  ASYNC_FIFO_test_1 U0_ASYNC_FIFO ( .wdata(WR_DATA), .winc(WR_INC), .rinc(
        FIFO_RINC), .wclk(REF_CLK_M), .rclk(TX_CLK_M), .wrst_n(n4), .rrst_n(n2), .rdata(FIFO_RDATA), .rempty(FIFO_EMPTY), .wfull(FIFO_FULL), .test_si2(SI[2]), 
        .test_si1(ALU_OUT_V), .test_so2(n17), .test_so1(SO[3]), .test_se(n37)
         );
  Pulse_Gen_test_1 U0_Pulse_Gen ( .clk(TX_CLK_M), .rst(n2), .async(
        UART_TX_BUSY), .sync(FIFO_RINC), .test_si(sync_bus[7]), .test_so(n16), 
        .test_se(n29) );
  BUFX2M U30 ( .A(SO[0]), .Y(framing_error) );
endmodule

