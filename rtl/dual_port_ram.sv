module dual_port_ram #(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 12
)(
    input clk,
    input wr_en,
    input [ADDR_WIDTH-1:0] wr_addr,
    input [DATA_WIDTH-1:0] wr_data,

    input rd_en,
    input [ADDR_WIDTH-1:0] rd_addr,
    input [DATA_WIDTH-1:0] rd_data
);

    localparam DEPTH = (1 << ADDR_WIDTH);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Write port

    always_ff @(posedge clk) begin
        if(wr_en)
            mem[wr_addr] <= wr_data;       
    end

    // Read port

    always_ff @(posedge clk) begin
        if(rd_en)
            rd_data <= mem[rd_addr];    
    end

endmodule