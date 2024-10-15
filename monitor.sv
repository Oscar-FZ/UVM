class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    function new(string name = "monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    uvm_analysis_port #(det_item) mon_analysis_port;
    virtual det_if vif;
    semaphore sema4;

    virtual function void build_phase(uv_phase phase);
        super.build_phase(phase);
         if (!uvm_config_db#(virtual det_if)::get(this, "", "det_if", vif))
            `uvm_fatal("MON", "Could not get vif")
        sema4 = new(1);
        mon_analysis_port = new("mon_analysis_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            sample_port("Thread0");
            sample_port("Thread1");
        join
    endtask

    virtual task sample_port(string tag = ""); //TODO
        forever begin
            @(posedge vif.clk);
            if (vif.rstn) begin
                det_item item = new;
                sema4.get();
                item.in = vif.in;
                `uvm_info("MON", $sformatf("T=%0t [Monitor] %s First part over", $time, tag), UVM_LOW)
                
                @(posedge vif.clk);
                sema4.put();
                item.out = vif.out()
                mon_analysis_port.write(item);
                `uvm_info("MON", $sformatf("T=%0t [Monitor] %s Second part over, item:", $time, tag), UVM_LOW)
                item.print();
            end
        end
    endtask
endclass