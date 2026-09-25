class ram_gen;

    ram_trans gen_trans, data2send;

    mailbox #(ram_trans) gen2rd;
    mailbox #(ram_trans) gen2wd;

    function new(mailbox #(ram_trans) gen2rd,mailbox #(ram_trans) gen2wd);
        this.gen2rd = gen2rd;
        this.gen2wd = gen2wd;
        this.gen_trans = new;

    endfunction : new 

    virtual task start();
        fork
            begin
                for(int i = 0; i < number_of_)
            end