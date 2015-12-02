class Speed extends Spd_Stg_Len_Correl 
{
  float average;
  
  Speed()
  {
    speedTime = 4;
    speedIndex = 1;
  }
  
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
    drawAxis(verticalIntervals, dataGaps, "Speed", speedColour, int(highestSpeed - lowestSpeed), int(lowestSpeed));
    
    // Timing drawing graph animation
    if(speedTime > 4)
    {
      if(speedIndex < speedList.size())
          speedIndex++;
      speedTime = 0;
    }
    for(int j = 1; j < speedIndex; j++)
          drawGraph(j, 0, speedList, lowestSpeed, highestSpeed);
    speedTime++;

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