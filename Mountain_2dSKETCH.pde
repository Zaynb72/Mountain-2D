\\commented out code is either an explanation of each line or first iterations of ideas 

Table table;
int[] totalRPEarned = new int[100];
float[] mappedRP = new float[100];
float[] cumRP = new float[100];
float TotalRP = 0;

void setup() {
  size(400,400);
  table = loadTable("Apex_Game_Data_Full - Sheet1.csv", "header");
  
//  int index = 0;
//loops through first 50 of rp earned
//for(int i = 0; i < 50; i++) {
//    TableRow row = table.getRow(i);
//    int rp_earned = row.getInt("rp_earned");
//    totalRPEarned[index] = rp_earned;
//    index++;
   // println(rp_earned);
  for (int i = 0; i < 100; i++) {
  totalRPEarned[i] = table.getRow(i).getInt("rp_earned");
}
  
//}
//loops through last 50 from 100-50
//for(int i = 100; i > 50; i--) {
//    TableRow row = table.getRow(i);
//    int rp_earned = row.getInt("rp_earned");
//    totalRPEarned[index] = rp_earned;
//    index++;
    //println(rp_earned);
  
//builds running total of RP after each match and puts it into cumulativeRP
for (int i = 0; i < totalRPEarned.length; i++) {
  TotalRP += totalRPEarned[i];
  cumRP[i] = TotalRP; 
}
  println(cumRP);

//println(totalRPEarned);
//find minimium and maximium cumulative RP
float minRP = min(cumRP);
float maxRP = max(cumRP);
//loops through array and maps out the values from 0-1 for later 
//so i can fit the data on 400*400 pixels
   for(int i = 0; i < cumRP.length; i++) {
     //converts cumulative rp to a range from 0-1 
    mappedRP[i] = map(cumRP[i], minRP, maxRP, 0.0, 1.0);
  }
println(mappedRP);
}
//starts draw function 
void draw() {
  //sets background colour
  background(100);
  //where the mountain will start from
  float bottomY = 350;
  //tallest height of the mountain 
  float maxHeight = 300;
  //i is the match number for now 
  for (int i = 1; i < mappedRP.length; i++) {
    //Maps out x position 
    float x = map(i, 0, mappedRP.length - 1, 0,width / 2);
    //maps out Y position rp*height = pixels, Have to minus the pixels by the bottom Y so mountain goees upward
    float y = bottomY - mappedRP[i] * maxHeight;
    //-1 to i so you can go back one match to find out prev values
    float prevX = map(i -1, 0, mappedRP.length - 1, 0, width / 2);
    float prevY = bottomY - mappedRP[i - 1] * maxHeight;
    fill(200,50,50);
    noStroke();
   ellipse(x, y, 4, 4);
       stroke(60, 140, 70);
    line(prevX, prevY, x, y); 
  line(x, bottomY, x, y);
  line(width - x, bottomY, width - x, y);
  //takes points from left side of mountain and subtracts them from width to mirror the positions 
    line(width - prevX, prevY, width - x, y);
  }
}
