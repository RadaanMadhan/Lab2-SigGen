#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    //init top verilog instance
    Vsinegen* top = new Vsinegen;
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top -> trace (tfp, 99);
    tfp -> open ("counter.vcd");

    // init Vbuddy
    if ( vbdOpen()!=1) return (-1);
    vbdHeader("Lab 2: Sinegen");

    //initialize simulation inputs
    top -> clk = 1;
    top -> rst = 0;
    top -> en = 0;
    top -> incr = 1;
    

    //run simulation for many clock cycles
    for(i=0; i<10000; i++){

        //dump variables into vcd file and toggle clock
        for(clk=0; clk<2; clk++){
            tfp -> dump (2*i+clk);
            top -> clk = !top -> clk;
            top -> eval ();
        }

        //Send Count values to Vbuddy

        /*
        vbdHex(4, (int(top->count) >> 16) & 0xF);
        vbdHex(3, (int(top->count) >> 8) & 0xF);
        vbdHex(2, (int(top->count) >> 4) & 0xF);
        vbdHex(1, int(top->count) & 0xF);
        */
        vbdPlot(int(top->dout), 0, 255);
        vbdCycle(i+1);
        // End of Vbuddy Output section

        top -> en = vbdFlag();
        top -> incr = vbdValue();
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q'))
            exit(0);
    }

    vbdClose();
    tfp -> close();
    exit(0);
}

