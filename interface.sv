interface  det_if (input bit clk);
    logic rstn;
    logic in;
    logic out;

    clocking cb @(posedge clk);
        default input #1 step output #3ns;
        input out;
        output in;
    endclocking
endinterface 