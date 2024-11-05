module sinegen # (
        parameter   A_WIDTH = 8,
                    D_WIDTH = 8
)(
    input   logic               clk,
    input   logic               rst,
    input   logic               en,               
    input   logic [D_WIDTH-1:0] phase,
    output  logic [D_WIDTH-1:0] dout1,
    output  logic [D_WIDTH-1:0] dout2
);

    logic   [A_WIDTH-1:0]           address;

counter addrCounter (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .incr   ({8'b1}),
    .count  (address)
);

rom sineRom (
    .clk    (clk),
    .dout1   (dout1),
    .addr1   (address),
    .dout2   (dout2),
    .addr2   (address + phase)
);

endmodule
