class Speed
{
  int verticalIntervals;
  float vertDataRange;
  float border;
  
  Speed()
  {
     this(10, 50, width * 0.1f); 
  }
  
  Speed(int verticalIntervals, float vertDataRange, float border)
  {
    this.verticalIntervals = verticalIntervals;
    this.vertDataRange = vertDataRange;
    this.border = border;
  }
  
  void render()
  {
    stroke(0, 255, 255);
    strokeWeight(4);
    float windowRange = (width - (border * 2.0f));
    float dataRange = 50;      
    float lineWidth = windowRange / (float)(speedList.size() - 1);
    float scale = windowRange / dataRange;
    
    for(int i = 1; i < speedList.size(); i++)
    {
      float x1 = border + ((i - 1) * lineWidth);
      float x2 = border + (i * lineWidth);
      float y1 = (height - border) - (speedList.get(i - 1)) * scale;
      float y2 = (height - border) - (speedList.get(i)) * scale;
      line(x1, y1, x2, y2);
    }
    
    strokeWeight(2);
    stroke(255);
    fill(255);
    
    // x axis (year axis)
    line(border, height - border, width - border, height - border);
    
    float horizInterval =  windowRange / (yearList.size() - 1);
    float tickSize = border * 0.1f;
    
    for(int i = 0; i < yearList.size(); i++)
    {
     float x = border + (i * horizInterval);
     line(x, height - (border - tickSize), x, (height - border));
     float textY = height - (border * 0.5f);
     textAlign(CENTER, CENTER);
     text(yearList.get(i), x, textY);
    }
    
    // y axis (speed axis) 
    line(border, border, border, height - border);
    
    float verticalDataGap = vertDataRange / verticalIntervals;
    float verticalWindowRange = height - (border * 2.0f);
    float verticalWindowGap = verticalWindowRange / verticalIntervals; 
    
    for (int i = 0; i <= verticalIntervals; i++)
    {
      float y = (height - border) - (i * verticalWindowGap);
      line(border - tickSize, y, border, y);
      
      float hAxisLabel = verticalDataGap * i;
          
      textAlign(RIGHT, CENTER);  
      text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
    }
    
    if(mouseX > border && mouseX < (width - border))
    {
      stroke(255, 0, 0);
      line(mouseX, border, mouseX, height - border);
    }
    
    // Determine which year the mouse is in
    int x = (int) ((mouseX - border) / lineWidth);
    
    if(x >= 0 && x < years.size())
    {
      int year = years.get(x).tour_year;
      float speed = years.get(x).speed;
      
      // Determine y coordinate of ellipse in relation to line graph
      float y = map(years.get(x).speed, 0, dataRange, height - border, (height - border) - (height - (border * 2.0f)));
      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      ellipse(mouseX, y, 10, 10);
      
      fill(255);
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