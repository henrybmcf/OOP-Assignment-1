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
    
    stroke(200, 200, 200);
    fill(200, 200, 200);  
     
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
  }  
}