`timescale 1ns / 1ps


module test;
  
  //Inputs
  reg clk;
  reg reset;
  reg mode;
  reg button1;
  reg button2;
  reg button3;
  reg button4;
  
  //Outputs
  wire [7:0] led;
  wire [7:0] cand1_vote_rec;
  wire [7:0] cand2_vote_rec;
  wire [7:0] cand3_vote_rec;
  wire [7:0] cand4_vote_rec;
  
  
  //Instntiate the unit under Test (UUT)
  votingMachine uut (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .button1(button1),
    .button2(button2),
    .button3(button3),
    .button4(button4),
    .led(led)
  );
  
  initial 
    begin
    clk = 0;
    forever #5 clk = ~clk;
    end
  
  initial begin
     $monitor($time, "mode = %b, button1 = %b, button2 = %b, button3 = %b, button4 = %b, led = %d",mode,button1,button2,button3,button4,led);
    //Initialize Inputs
    reset = 1; mode = 0; button1 = 0; button3 = 0; button4 = 0;
    //Wait 100ns for global reset to finish
    #100;
    
    //Add stimulus here
    
    #100 reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 1; button2 = 0; button3 = 0; button4 = 0;
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 1; button2 = 0; button3 = 0; button4 = 0;
    #200 reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    
    #5reset = 0; mode = 0; button1 = 0; button2 = 1; button3 = 0; button4 = 0;
    #200 reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0; 
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    
    #5reset = 0; mode = 0; button1 = 0; button2 = 1; button3 = 1; button4 = 0;
    #200 reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0; 
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    
    #5reset = 0; mode = 1; button1 = 0; button2 = 1; button3 = 0; button4 = 0;
    #200 reset = 0; mode = 1; button1 = 0; button2 = 0; button3 = 1; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0; 
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 1; button4 = 0;
    #200 reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0; 
    #10reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    #5reset = 0; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 =0;
    
    $finish;
end         
    

endmodule
