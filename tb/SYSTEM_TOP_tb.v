`timescale 1ns/1ps

module SYSTEM_TOP_tb;

reg REF_CLK, UART_CLK, RST, RX_IN;
wire TX_OUT, parity_error, framing_error;

integer i, errors;

reg [7:0] received_byte, received_parity;


/*====================================================
  DUT
====================================================*/

SYSTEM_TOP DUT(
    .REF_CLK(REF_CLK),
    .UART_CLK(UART_CLK),
    .RST(RST),
    .RX_IN(RX_IN),
    .TX_OUT(TX_OUT),
    .parity_error(parity_error),
    .framing_error(framing_error)
);


/*====================================================
  CLOCKS
====================================================*/

initial begin
    REF_CLK = 1'b0;
    forever #5 REF_CLK = ~REF_CLK;
end

initial begin
    UART_CLK = 1'b0;
    forever #135.63368 UART_CLK = ~UART_CLK;
end


/*====================================================
  SEND ONE BIT
====================================================*/

task send_bit;
input bit_value;
integer cycles;
begin
    cycles = DUT.REG2[7:2];
    RX_IN = bit_value;
    repeat(cycles) @(posedge DUT.RX_CLK);
end
endtask


/*====================================================
  SEND BYTE
====================================================*/

task send_byte;
input [7:0] data;
reg parity_bit;
begin
    send_bit(1'b0);

    for(i = 0; i < 8; i = i + 1)
        send_bit(data[i]);

    if(DUT.REG2[0]) begin
        if(DUT.REG2[1])
            parity_bit = ~(^data);
        else
            parity_bit = ^data;

        send_bit(parity_bit);
    end

    send_bit(1'b1);
end
endtask


/*====================================================
  WRITE REGISTER
====================================================*/

task write_reg;
input [3:0] addr;
input [7:0] data;
begin
    send_byte(8'hAA);
    send_byte({4'b0000,addr});
    send_byte(data);

    repeat(50) @(posedge REF_CLK);
end
endtask


/*====================================================
  CHECK VALUE
====================================================*/

task check_value;
input [8*32-1:0] label;
input [7:0] got;
input [7:0] expected;
begin
    if(got === expected)
        $display("PASS  %0s : %02h",label,got);
    else begin
        errors = errors + 1;
        $display("FAIL  %0s : got %02h, expected %02h",label,got,expected);
    end
end
endtask


/*====================================================
  CHECK TX FRAME
====================================================*/

task check_tx_frame;
input [7:0] expected_data;

integer j, timeout_count;
reg [7:0] received_data;
reg expected_parity_bit;

begin
    received_data = 8'h00;
    received_parity = 1'b0;
    expected_parity_bit = 1'b0;

    $display("");
    $display("----------------------------------------");
    $display("Waiting for TX frame...");
    $display("----------------------------------------");

    timeout_count = 0;

    while((DUT.U0_UART.U0_UART_TX.busy !== 1'b1) &&
          (timeout_count < 20000)) begin
        @(posedge REF_CLK);
        timeout_count = timeout_count + 1;
    end

    if(timeout_count >= 20000) begin
        errors = errors + 1;
        $display("FAIL  TX START TIMEOUT");
    end
    else begin

        if(TX_OUT !== 1'b0)
            @(negedge TX_OUT);

        @(negedge DUT.TX_CLK);

        if(TX_OUT === 1'b0)
            $display("PASS  START bit = 0");
        else begin
            errors = errors + 1;
            $display("FAIL  START bit = %b",TX_OUT);
        end

        for(j = 0; j < 8; j = j + 1) begin
            @(negedge DUT.TX_CLK);
            received_data[j] = TX_OUT;
            $display("TX DATA bit[%0d] = %b",j,TX_OUT);
        end

        check_value("TX received byte",received_data,expected_data);

        if(DUT.REG2[0]) begin
            @(negedge DUT.TX_CLK);

            if(DUT.REG2[1])
                expected_parity_bit = ~(^expected_data);
            else
                expected_parity_bit = ^expected_data;

            received_parity = TX_OUT;

            if(received_parity === expected_parity_bit)
                $display("PASS  PARITY bit = %b",received_parity);
            else begin
                errors = errors + 1;
                $display("FAIL  PARITY bit = %b, expected = %b",
                         received_parity,expected_parity_bit);
            end
        end

        @(negedge DUT.TX_CLK);

        if(TX_OUT === 1'b1)
            $display("PASS  STOP bit = 1");
        else begin
            errors = errors + 1;
            $display("FAIL  STOP bit = %b, expected = 1",TX_OUT);
        end

        timeout_count = 0;

        while((DUT.U0_UART.U0_UART_TX.busy === 1'b1) &&
              (timeout_count < 20000)) begin
            @(posedge REF_CLK);
            timeout_count = timeout_count + 1;
        end

        if(timeout_count >= 20000) begin
            errors = errors + 1;
            $display("FAIL  TX BUSY DID NOT RETURN LOW");
        end
        else if(TX_OUT === 1'b1)
            $display("PASS  TX_OUT returned to IDLE");
        else begin
            errors = errors + 1;
            $display("FAIL  TX_OUT did not return to IDLE");
        end
    end
end
endtask


/*====================================================
  READ REGISTER
====================================================*/

task read_reg_and_check;
input [3:0] addr;
input [7:0] expected_data;
begin
    send_byte(8'hBB);
    send_byte({4'b0000,addr});
    check_tx_frame(expected_data);
end
endtask


/*====================================================
  MAIN TEST
====================================================*/

initial begin

    errors = 0;
    RST = 1'b0;
    RX_IN = 1'b1;

    #1000;
    RST = 1'b1;

    repeat(100) @(posedge REF_CLK);

    $display("");
    $display("==============================================");
    $display("       SYSTEM TOP END-TO-END UART TEST");
    $display("==============================================");


    /* PARITY OFF */

    $display("");
    $display("==============================================");
    $display("CASE 1 : PARITY OFF");
    $display("==============================================");

    write_reg(4'h2,8'h80);
    write_reg(4'h4,8'h55);

    check_value(
        "REG[4] after write",
        DUT.U0_REGFILE.Registers[4],
        8'h55
    );

    read_reg_and_check(4'h4,8'h55);


    /* SECOND DATA */

    $display("");
    $display("==============================================");
    $display("CASE 2 : SECOND DATA PATTERN");
    $display("==============================================");

    write_reg(4'h5,8'hA5);

    check_value(
        "REG[5] after write",
        DUT.U0_REGFILE.Registers[5],
        8'hA5
    );

    read_reg_and_check(4'h5,8'hA5);


    /* EVEN PARITY */

    $display("");
    $display("==============================================");
    $display("CASE 3 : EVEN PARITY");
    $display("==============================================");

    write_reg(4'h2,8'h81);
    write_reg(4'h6,8'h3C);

    check_value(
        "REG[6] after write",
        DUT.U0_REGFILE.Registers[6],
        8'h3C
    );

    read_reg_and_check(4'h6,8'h3C);


    /* ODD PARITY */

    $display("");
    $display("==============================================");
    $display("CASE 4 : ODD PARITY");
    $display("==============================================");

    write_reg(4'h2,8'h83);
    write_reg(4'h7,8'h96);

    check_value(
        "REG[7] after write",
        DUT.U0_REGFILE.Registers[7],
        8'h96
    );

    read_reg_and_check(4'h7,8'h96);


    /* RESULT */

    $display("");
    $display("==============================================");

    if(errors == 0)
        $display("        ALL TESTS PASSED");
    else
        $display("        %0d TEST(S) FAILED",errors);

    $display("==============================================");

    #5000;
    $stop;

end

endmodule