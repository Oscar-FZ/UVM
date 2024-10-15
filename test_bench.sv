`include "det_1011.sv"
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "enviorement.sv"
`include "test.sv"

module test_bench;
    reg clk;

    always #10 clk =~ clk;
    det_if _if(clk);

    det_1011 DUT 
    (
        .clk(clk),
        .rstn(_if.rstn),
        .in(_if.in),
        .out(_if.out)
    );

    initial begin
        clk <= 0;
        uvm_config_db#(virtual det_if)::set(null, "uvm_test_top", "det_vif", _if);
        run_test("test_1011");
    end

endmodule