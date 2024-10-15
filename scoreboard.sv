class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    uvm_analysis_imp #(det_item, scoreboard) m_analysis_imp;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp = new("m_analysis_imp", this);
    endfunction

    virtual function write(det_item item);
        if (item.out) begin
            `uvm_info("SCBD", $sformatf("Patron detectado! in = %b, out = %b", item.in, item.out))
        end

        else begin 
            `uvm_info("SCBD", $sformatf("Ningun patron detectado! in = %b, out = %b", item.in, item.out))
        end
    endfunction
endclass