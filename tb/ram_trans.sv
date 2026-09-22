class ram_trans;

    rand bit [63:0] wr_data;
    rand bit wr_en;
    rand bit rd_en;
    rand bit [11:0] wr_addr;
    rand bit [11:0] rd_addr;

    bit [63:0] rd_data;

    static int trans_id;

    // tracking no of transaction

    static int no_of_rd_trans;
    static int no_of_wr_trans;
    static int no_of_rd_wr_trans;

    constraint VALID_ADDR { wr_addr != rd_addr;}
    constraint VALID_CTL { {wr_en,rd_en} != 2'b00;}
    constraint VALID_DATA { wr_data inside {[1:4294]}}

    virtual function void display(input string msg);
        $display("================================");
        $display("%s", msg);
        $display("\tTransaction ID: %d", trans_id);
        $display("\t No of Read Transaction: %d", no_of_rd_trans);
        $display("\t No of Write Transaction: %d", no_of_wr_trans);
        $display("\t No of Read/Write Transaction: %d", no_of_rd_wr_trans);
        $display("\t wr_en = %b | rd_en = %b", wr_en, rd_en);
        $display("\t RD_ADDR = %d | WR_ADDR = %d", rd_addr, wr_addr);
        $display("\t WR_DATA = %d | RD_DATA = %d", wr_data, rd_data);
    endfunction : display

    function void post_randomize();
        if(this.wr_en == 1 && this.rd_en ==0)
            no_of_wr_trans++;
        
        if(this.wr_en == 0 && this.rd_en ==1)
            no_of_rd_trans++;
        
        if(this.wr_en == 1 && this.rd_en ==1)
            no_of_rd_wr_trans++;

        this.display("\t Randomized Data");
    endfunction : post_randomize

    virtual function bit compare(input ram_trans rcv, output string msg);
        compare = '0;
        begin
            if(this.rd_addr != rcv.rd_addr) begin
                $display($time);
                msg = "----------ADDR_MISMATCH----------";
                return(0);
            end
            if(this.rd_data != rcv.rd_data) begin
                $display($time);
                msg = "----------RD_DATA_MISMATCH--------";
                return(0);
            end
            begin
                msg = "----------COMPARRED SUCCESSFULLY--";
                return(1);
            end

        end
    endfunction: compare

endclass: ram_trans
        