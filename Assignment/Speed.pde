class Speed extends Spd_Stg_Len_Correl 
{
  
  
  Speed()
  {
    speedTime = 4;
    speedIndex = 1;
  }
  
  void render()
  {
    // Find lowest & highest for mapping
    highestSpeed = speedList.max();
    lowestSpeed = speedList.min();
    lineWidth = graphWidth / (speedList.size() - 1);
   
    stroke(0, 255, 255);
    strokeWeight(3);
    line(xBorder, yBorder, xBorder, vertGraphWindowRange);
    for(int i = 0; i <= verticalIntervals; i++)
        line(xBorder - tickSize, vertGraphWindowRange - (i * dataGaps), xBorder, vertGraphWindowRange - (i * dataGaps));
    drawAxis(verticalIntervals, dataGaps, "Speed", speedColour, highestSpeed - lowestSpeed, lowestSpeed);
    
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
    drawYearAxis();
    displayYearInfo(2);
    
    average();
  }
  
  void average()
  {
    float sum = 0.0f;
    for(float s:speedList)
         sum += s;
    average = sum / speedList.size();
    float y = map(average, lowestSpeed, highestSpeed, vertGraphWindowRange, yBorder);
    
    fill(50, 255, 50);
    stroke(50, 255, 50);
    textAlign(RIGHT, CENTER);
    text(nf(average, 2, 2), xBorder - tickSize, y);
    line(xBorder, y, graphWindowRange, y);
    
    
  }
}