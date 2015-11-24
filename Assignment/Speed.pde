class Speed
{
  int verticalIntervals;
  float dataRange;
  float border;
  float graph_height;
  float graph_width;
  float windowRange;
  float lineWidth;
  float scale;
  float avg_y;
  float horizInterval;
  float tickSize;
  float verticalDataGap;;
  float verticalWindowRange;
  float verticalWindowGap;
  
  Speed()
  {
    verticalIntervals = 10;
    dataRange = 50.0f;
    border = width * 0.1f;
    graph_height = height - border;
    graph_width = width - border;
    windowRange = width - (border * 2.0f);
    verticalWindowRange = height - (border * 2.0f);
    verticalDataGap = dataRange / verticalIntervals;
    verticalWindowGap = verticalWindowRange / verticalIntervals;
  }
  
  void render()
  {
    // Graph Title
    textAlign(LEFT);
    text("Average speed of winner of TDF.\nPlease move mouse over graph to show individual year's speeds.", 25, 25);
    
    // Show overall average line across graph 
    stroke(0, 255, 0);
    avg_y = map(average, 0, 50, graph_height, (graph_height) - (height - (border * 2.0f)));
    line(border, avg_y, graph_width, avg_y);
    fill(0, 255, 0);
    textAlign(RIGHT, CENTER);
    text(nf(average, 2, 2), border - 10, avg_y);
    
    stroke(0, 255, 255);
    strokeWeight(4);
      
    lineWidth = windowRange / (float)(speedList.size() - 1);
    scale = windowRange / dataRange;
    
    for(int i = 1; i < speedList.size(); i++)
    {
      float x1 = border + ((i - 1) * lineWidth);
      float x2 = border + (i * lineWidth);
      float y1 = (graph_height) - (speedList.get(i - 1)) * scale;
      float y2 = (graph_height) - (speedList.get(i)) * scale;
      line(x1, y1, x2, y2);
    }
    
    strokeWeight(2);
    stroke(255);
    fill(255);
    
    // x axis (year axis)
    line(border, graph_height, graph_width, graph_height);
    
    horizInterval = windowRange / (yearList.size() - 1);
    tickSize = border * 0.1f;
    
    for(int i = 0; i < yearList.size(); i++)
    {
     float x = border + (i * horizInterval);
     line(x, height - (border - tickSize), x, (graph_height));
     float textY = height - (border * 0.5f);
     textAlign(CENTER, CENTER);
     text(yearList.get(i), x, textY);
    }
    
    // y axis (speed axis) 
    line(border, border, border, graph_height);
 
    for (int i = 0; i <= verticalIntervals; i++)
    {
      float y = (graph_height) - (i * verticalWindowGap);
      line(border - tickSize, y, border, y);
      
      float hAxisLabel = verticalDataGap * i;
          
      textAlign(RIGHT, CENTER);  
      text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
    }
    
    // Draw line to show exact year and speed depending on x coordinates of mouse
    if(mouseX > border && mouseX < (graph_width))
    {
      stroke(255, 0, 0);
      line(mouseX, border, mouseX, graph_height);
    }
    
    // Determine which year the mouse is in
    int x = (int) ((mouseX - border) / lineWidth);
    
    if(x >= 0 && x < years.size())
    {
      int year = years.get(x).tour_year;
      float speed = years.get(x).speed;
      
      // Determine y coordinate of ellipse in relation to line graph
      float y = map(years.get(x).speed, 0, dataRange, graph_height, (graph_height) - (height - (border * 2.0f)));
      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      ellipse(mouseX, y, 10, 10);
      
      fill(255);
      // Display speed and year on relevant side of line, depending on location across graph
      if(mouseX < 150)
      {
        textAlign(LEFT, CENTER);
        text("Year: " + year, mouseX + 10, height - 200);
        text("Speed: " + speed + " Km/h", mouseX + 10, height - 180);
      }
      if(mouseX > width - 200)
      {
        textAlign(RIGHT, CENTER);
        text("Year: " + year, mouseX - 10, height - 200);
        text("Speed: " + speed + " Km/h", mouseX - 10, height - 180);
      }
      if(mouseX > 150 && mouseX < width - 200)
      {
        textAlign(RIGHT, CENTER);
        text("Year: " + year, mouseX - 10, height - 200);
        textAlign(LEFT, CENTER);
        text("Speed: " + speed + " Km/h", mouseX + 10, height - 200);
      }
    }
  }  
}