module sigdelay # (
        parameter   A_WIDTH = 9,
                    D_WIDTH = 8
)(
    input   logic               clk,
    input   logic               rst,
    input   logic               rd,
    input   logic               wr,               
    input   logic [A_WIDTH-1:0] offset,
    input   logic [D_WIDTH-1:0] mic_signal,
    output  logic [D_WIDTH-1:0] delayed_signal
);

    logic   [A_WIDTH-1:0]           address;

counter addrCounter (
    .clk    (clk),
    .rst    (rst),
    .en     (1'b1),
    .incr   ({8'b1}),
    .count  (address)
);

ram sigRam (
    .clk        (clk),
    .wr_en      (wr),
    .rd_en      (rd),
    .wr_addr    (address),
    .rd_addr    (address - offset),
    .din        (mic_signal),
    .dout       (delayed_signal)
);

endmodule