module counter #(
    parameter WIDTH = 8 
)(
    //Interface Signals
    input logic              clk,   //clock
    input logic              rst,   //reset        
    input logic              en,    //enable
    input logic  [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] count  //count output
);
    
always_ff @(posedge clk ) 
    if (rst) count <= {WIDTH{1'b0}};
    else     count <= count + (en ? incr : {WIDTH{1'b0}}) ;

endmodule
