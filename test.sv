class test extends uvm_test;
    `uvm_component_utils(test)
    
    function new(string name = "test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    env e0;
    virtual det_if vif; //TODO

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0 = env::type_id::create("e0", this);
        if (!uvm_config_db#(virtual det_if)::get(this, "", "det_if", vif))
            `uvm_fatal("TEST", "Could not get vif")

            uvm_config_db#(virtual det_if)::set(this, "e0.a0*", "det_vif", vif);
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_item_seq seq = gen_item_seq::type_id::create("seq");
        phase.raise_objection(this);
        apply_reset();

        seq.randomize();
        seq.start(e0.a0.s0);
        phase.drop_objection(this);
    endtask

    virtual task apply_reset();
        vif.rstn <- 0;
        repeat(5) @(posedge vif.clk);
        vif.rstn <= 1;
        repeat(10) @(posedge vif.clk);
    endtask
endclass