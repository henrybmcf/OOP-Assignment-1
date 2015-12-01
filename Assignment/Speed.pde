class Speed extends Spd_Stg_Len_Correl 
{
  float average;

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
    for(int i = 1; i < speedList.size(); i++)
          drawGraph(i, 0, speedList, lowestSpeed, highestSpeed);

    // X Axis (Year Axis)
    strokeWeight(2);
    stroke(255);
    fill(255);
    line(x_border, vertGraphWindowRange, graphWindowRange, vertGraphWindowRange);
    horizInterval = graphWidth / (yearList.size() - 1);
    tickSize = x_border * 0.1f;
    for(int i = 0; i < yearList.size(); i++)
    {
      float x = x_border + (i * horizInterval);
      line(x, vertGraphWindowRange + tickSize, x, vertGraphWindowRange);
      float textY = height - (y_border * 0.5f);
      textAlign(CENTER, CENTER);
      text(yearList.get(i), x, textY);
    }
    
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