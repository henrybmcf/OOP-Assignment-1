class Axis
{
  int verticalIntervals;
  float vertDataRange;
  
  Axis()
  {
     this(10, 50); 
  }
  
  Axis(int verticalIntervals, float vertDataRange)
  {
    this.verticalIntervals = verticalIntervals;
    this.vertDataRange = vertDataRange;
  }
  
  void render(float border)
  {
    stroke(200, 200, 200);
    fill(200, 200, 200);  
     
    line(border, height - border, width - border, height - border);
    
    float windowRange = (width - (border * 2.0f));  
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