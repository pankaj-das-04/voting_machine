`timescale 1ns / 1ps

module control_button(
  input clk,
  input reset,
  input button,
  output reg valid_vote
);
  
reg [30:0] counter;
  
always @(posedge clk)
begin
  if(reset)
    counter <= 0;
  else
  begin
    if(button & counter < 11)
      counter <= counter+1;
    else if(!button)
      counter <= 0;
  end
end
  
  
always @(posedge clk)
begin
  if(reset)
    valid_vote <= 1'b0;
  else
  begin
    if(counter == 10)
      valid_vote<= 1'b1;
    else
      valid_vote <= 1'b0;
  end
end
  
endmodule

module modeControl (
input candidate1_button_press,
input clk,
input reset,
input mode,
input valid_vote_casted,
input [7:0] candidatel_vote,
input [7:0] candidate2_vote,
input [7:0] candidate3_vote,
input [7:0] candidate4_vote,
input candidate2_button_press,
input candidate3_button_press, 
input candidate4_button_press,
output reg [7:0] leds
);


reg [30:0] counter;
  
always @(posedge clk)
begin
  if(reset)
    counter <= 0; //whenever reset is pressed, counter starts from 0
  else if(valid_vote_casted) //if a valid vote is casted, counter becomes 1
    counter <= counter + 1;
  else if(counter !=0 & counter < 10)//if counter is not 0, increament it till 10
    counter <= 0;
  else //Once counter becomes 10, reset it to zero
    counter <= 0;
end
  
always @(posedge clk)
begin
  if(reset)
    leds <= 0;
  else
  begin
    if(mode == 0 & counter > 0) //mode0->voting mode, mode 1->result mode
      leds <= 8'hFF;
    else if(mode == 0)
      leds <= 8'h00;
    else if(mode == 1) //result mode
    begin
      if(candidate1_button_press)
        leds <= candidatel_vote;
      else if(candidate2_button_press)
        leds <= candidate2_vote;
      else if(candidate3_button_press)
        leds <= candidate3_vote;
      else if(candidate4_button_press)
        leds <= candidate4_vote;
    end
  end
end
  
endmodule
    
module vote_logger(
input clk,
input reset,
input mode,
input cand1_valid_vote,
input cand2_valid_vote,
input cand3_valid_vote, 
input cand4_valid_vote,
output reg [7:0] cand1_vote_rec,
output reg [7:0] cand2_vote_rec,
output reg [7:0] cand3_vote_rec, 
output reg [7:0] cand4_vote_rec
);
  
  
always @(posedge clk)
begin
  if(reset)
  begin
    cand1_vote_rec <= 0;
    cand2_vote_rec <= 0;
    cand3_vote_rec <= 0;
    cand4_vote_rec <= 0;
  end
  else
  begin
    if(cand1_valid_vote & mode==0)
      cand1_vote_rec <= cand1_vote_rec +1;
    else if(cand2_valid_vote & mode==0)
      cand2_vote_rec <= cand2_vote_rec +1;
    else if(cand3_valid_vote & mode==0)
      cand3_vote_rec <= cand3_vote_rec +1;
    else if(cand4_valid_vote & mode==0)
      cand4_vote_rec <= cand4_vote_rec +1;
  end
end
  
  
endmodule
  
module votingMachine(
input clk,
input reset, 
input mode,
input button1,
input button2, 
input button3,
input button4,
output [7:0] led
);
  
wire valid_vote_1;
wire valid_vote_2;
wire valid_vote_3;
wire valid_vote_4;
wire [7:0] cand1_vote_rec;
wire [7:0] cand2_vote_rec;
wire [7:0] cand3_vote_rec;
wire [7:0] cand4_vote_rec;
wire anyValidVote;
  
assign anyValidVote = valid_vote_1|valid_vote_2|valid_vote_3|valid_vote_4;

control_button bc1(
.clk(clk),
.reset(reset),
.button(button1),
.valid_vote(valid_vote_1)
);
 
control_button bc2(
.clk(clk),
.reset(reset),
.button(button2),
.valid_vote(valid_vote_2)
);
  
control_button bc3(
.clk(clk),
.reset(reset),
.button(button3),
.valid_vote(valid_vote_3)
);
  
control_button bc4(
.clk(clk),
.reset(reset),
.button(button4),
.valid_vote(valid_vote_4)
);
  

  
vote_logger VL(
.clk(clk),
.reset (reset),
.mode (mode), 
.cand1_valid_vote(valid_vote_1), 
.cand2_valid_vote(valid_vote_2), 
.cand3_valid_vote(valid_vote_3), 
.cand4_valid_vote(valid_vote_4), 
.cand1_vote_rec(cand1_vote_rec), 
.cand2_vote_rec(cand2_vote_rec), 
.cand3_vote_rec(cand3_vote_rec), 
.cand4_vote_rec(cand4_vote_rec) 
);
  
  
modeControl MCC( 
.clk(clk), 
.reset(reset), 
.mode (mode), 
.valid_vote_casted(anyValidVote), 
.candidatel_vote(cand1_vote_rec), 
.candidate2_vote(cand2_vote_rec), 
.candidate3_vote(cand3_vote_rec), 
.candidate4_vote(cand4_vote_rec), 
.candidate1_button_press(valid_vote_1), 
.candidate2_button_press(valid_vote_2), 
.candidate3_button_press(valid_vote_3), 
.candidate4_button_press(valid_vote_4), 
.leds(led) 
);
  
endmodule
