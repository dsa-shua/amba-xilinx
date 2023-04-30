`timescale 1ns / 1ps


module AHB_Mul(  
    input HCLK,
    input [31:0]M_AHB_0_haddr,
    input [2:0]M_AHB_0_hburst,
    input M_AHB_0_hmastlock,
    input [3:0]M_AHB_0_hprot,
    output reg [31:0]M_AHB_0_hrdata,
    output M_AHB_0_hready,
    output M_AHB_0_hresp,
    input [2:0]M_AHB_0_hsize,
    input [1:0]M_AHB_0_htrans,
    input [31:0]M_AHB_0_hwdata,
    input M_AHB_0_hwrite,
    output[3:0] led 
    );
    
    // these are outputs
    assign M_AHB_0_hready = 1'b1;
    assign M_AHB_0_hresp = 1'b0;
    
    
    /// Memory register ///
    reg [31:0] mem_A;   /// addr 0
    reg [31:0] mem_B;   /// addr 1
    reg [31:0] mem_C;   /// addr 2
    reg [31:0] mem_D;   /// addr 3
    reg [31:0] mem_E;   /// addr 4
    reg [31:0] mem_F;   /// addr 5
    reg [31:0] mem_G;   /// addr 6
    reg [31:0] mem_H;   /// addr 7
    ///////////////////////
    
    //// Multiplier data /// Fill the code of multiplier data. Addresses of registers are assigned from 8.
    
    reg[31:0] mem_I = 1;  // addr 8

    ////////////////////////
    
    /// control signals /// If you want more control signals, you can use additional signals
    reg [1:0]   w_ctrl; // write control
    reg [1:0]   r_ctrl; // read control
    reg [3:0]   w_addr; // write address
    reg [3:0]   r_addr; // read address
    ///////////////////////
    
    assign led[3:0] = mem_A[3:0]; // 4 LEDS are assigned to fisrt 4 bits of mem_A
    
    
    always@(posedge HCLK)
    begin 
        if(M_AHB_0_hwrite == 1'b1)// write address phase
        begin
        case(M_AHB_0_htrans)
            2'b00 : // IDLE
            begin
                w_ctrl <= 2'b00;
            end
            2'b01 : // BUSY
            begin
                w_ctrl <= 2'b01;
            end
            2'b10 : // NONSEQ
            begin
                w_ctrl <= 2'b10;
                w_addr <= M_AHB_0_haddr[5:2];
            end
            2'b11 : // SEQ
            begin
                w_ctrl <= 2'b11;
            end
        endcase
        end
   end
    
    always@(negedge HCLK) // write data phase
    begin
    case(w_ctrl)
        2'b00: // IDLE
        begin        
        end
        2'b01: // BUSY
        begin
        end
        2'b10: // NONSEQ
        begin
        case(w_addr)
            4'h0 : mem_A <= M_AHB_0_hwdata;
            4'h1 : mem_B <= M_AHB_0_hwdata;
            4'h2 : mem_C <= M_AHB_0_hwdata;
            4'h3 : mem_D <= M_AHB_0_hwdata;
            4'h4 : mem_E <= M_AHB_0_hwdata;
            4'h5 : mem_F <= M_AHB_0_hwdata;
            4'h6 : mem_G <= M_AHB_0_hwdata;
            4'h7 : mem_H <= M_AHB_0_hwdata;
//            4'h8 : mem_I <= M_AHB_0_hwdata;
        endcase
        end
        2'b11: // SEQ
        begin
        case(w_addr)
            4'h0 : mem_A <= M_AHB_0_hwdata;
            4'h1 : mem_B <= M_AHB_0_hwdata;
            4'h2 : mem_C <= M_AHB_0_hwdata;
            4'h3 : mem_D <= M_AHB_0_hwdata;
            4'h4 : mem_E <= M_AHB_0_hwdata;
            4'h5 : mem_F <= M_AHB_0_hwdata;
            4'h6 : mem_G <= M_AHB_0_hwdata;
            4'h7 : mem_H <= M_AHB_0_hwdata;
//            4'h8 : mem_I <= M_AHB_0_hwdata;
        endcase
        end
    endcase
    end
    
    //////////////////////////////////////
    /// Fill the code of Read transfer ///
    //////////////////////////////////////    
    
    always@(posedge HCLK) begin
        if (M_AHB_0_hwrite == 1'b0) begin // read address phase
            case(M_AHB_0_htrans)
                2'b00 : r_ctrl <= 2'b00;// idle
                2'b01 : r_ctrl <= 2'b01;// BUSY
                2'b10 : 
                    begin
                        r_ctrl <= 2'b10;// NONSEQ
                        r_addr <= M_AHB_0_haddr[5:2];
                    end
                2'b11 : r_ctrl <= 2'b11;// SEQ
            endcase
        end
    end
    
    always@(negedge HCLK) begin
        case(r_ctrl) 
        2'b00 : begin end // IDLE
        2'b01 : begin end // BUSY
        2'b10 : begin // NON SEQ
            case(r_addr)
                4'h0 : M_AHB_0_hrdata <= mem_A;
                4'h1 : M_AHB_0_hrdata <= mem_B;
                4'h2 : M_AHB_0_hrdata <= mem_C;
                4'h3 : M_AHB_0_hrdata <= mem_D;
                4'h4 : M_AHB_0_hrdata <= mem_E;
                4'h5 : M_AHB_0_hrdata <= mem_F;
                4'h6 : M_AHB_0_hrdata <= mem_G;
                4'h7 : M_AHB_0_hrdata <= mem_H;
                4'h8 : M_AHB_0_hrdata <= mem_I;
            endcase
        end
        2'b11 : begin 
            case(r_addr)
                4'h0 : M_AHB_0_hrdata <= mem_A;
                4'h1 : M_AHB_0_hrdata <= mem_B;
                4'h2 : M_AHB_0_hrdata <= mem_C;
                4'h3 : M_AHB_0_hrdata <= mem_D;
                4'h4 : M_AHB_0_hrdata <= mem_E;
                4'h5 : M_AHB_0_hrdata <= mem_F;
                4'h6 : M_AHB_0_hrdata <= mem_G;
                4'h7 : M_AHB_0_hrdata <= mem_H;
                4'h8 : M_AHB_0_hrdata <= mem_I;
            endcase
        end    
        endcase
    end

    //////////////////////////////////////
    //// Fill the code of Multiplier /////
    //////////////////////////////////////
    
    always@(negedge HCLK) begin
    //finish this in 1 cycle        
        case(w_ctrl) 
        2'b00 : begin end // IDLE
        2'b01 : begin end // BUSY
        2'b10 : begin // NON SEQ
            case(w_addr)
                4'h0 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h1 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h2 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h3 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h4 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h5 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h6 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h7 : mem_I <= mem_I * M_AHB_0_hwdata;
            endcase
        end
        2'b11: begin
                case(w_addr)
                4'h0 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h1 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h2 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h3 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h4 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h5 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h6 : mem_I <= mem_I * M_AHB_0_hwdata;
                4'h7 : mem_I <= mem_I * M_AHB_0_hwdata;
            endcase
        end
        
        endcase
    end
    //////////////////////////////////////
    
endmodule
