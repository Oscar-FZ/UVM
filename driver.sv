class driver extends uvm_driver #(det_item);
    `uvm_component_utils(driver)

    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual det_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual det_if)::get(this, "", "det_if", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            det_item m_item;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW)
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(det_item m_item); //TODO
        vif.in <= m_item.in;
    endtask
endclass