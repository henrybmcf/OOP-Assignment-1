class Speed extends Spd_Stg_Len_Correl 
{
  float average;
  
  int time= 4;
  int s = 1;
  
  void render()
  {
    average();
    
    // Find lowest & highest for mapping
    highestSpeed = Collections.max(speedList);
    lowestSpeed = Collections.min(speedList);
    lineWidth = graphWidth / (speedList.size() - 1);
   
    stroke(0, 255, 255);
    strokeWeight(3);
    line(x_border, y_border, x_border, vertGraphWindowRange);
    for(int i = 0; i <= verticalIntervals; i++)
        line(x_border - tickSize, vertGraphWindowRange - (i * dataGaps), x_border, vertGraphWindowRange - (i * dataGaps));  
    drawAxis(verticalIntervals, dataGaps, 1, speedColour, int(highestSpeed - lowestSpeed), int(lowestSpeed));
    
    // Timing drawing graph animation
    if(time > 4)
    {
      if(s < speedList.size())
          s++;
      time = 0;
    }
    for(int j = 1; j < s; j++)
          drawGraph(j, 0, speedList, lowestSpeed, highestSpeed);
    time++;

    // X Axis (Year Axis)
    drawXAxis();
    displayYearInfo(2);
  }
  
  void average()
  {
    float sum = 0.0f;
    for(float s:speedList)
         sum += s;
    average = sum / speedList.size();
  } 
}