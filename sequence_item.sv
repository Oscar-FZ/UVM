class det_item extends uvm_sequence_item;
    rand bit    in;
    bit         out;

    `uvm_object_utils_begin(det_item)
        `uvm_field_int (in, UVM_DEFAULT) 
        `uvm_field_int (out, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name = "det_item");
        super.new(name);
    endfunction 
enclass

