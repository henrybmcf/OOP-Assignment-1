class Spd_Stg_Len_Correl
{
  int verticalIntervals;
  float dataRange;
  float border;
  float graph_height;
  float graph_width;
  float windowRange;
  float lineWidth;
  float avg_y;
  float horizInterval;
  float tickSize;
  float verticalDataGap;
  float verticalWindowRange;
  float verticalWindowGap;

  int verticalStageIntervals;
  float verticalStageWindowGap;
 
  float lengthDataGap;
  float lengthIntervals;
  float lengthWindowGap;
  
  Spd_Stg_Len_Correl()
  {
    verticalIntervals = 10;
    border = width * 0.1f;
    graph_height = height - border;
    graph_width = width - border;
    windowRange = width - (border * 2.0f);
    verticalWindowRange = height - (border * 2.0f);
    verticalWindowGap = verticalWindowRange / verticalIntervals;
    verticalStageIntervals = 6;
    verticalStageWindowGap = verticalWindowRange / verticalStageIntervals;
    
    lengthIntervals = 10;
    lengthWindowGap = verticalWindowRange / lengthIntervals;
  }
  
  void render()
  {
    // Find lowest and highest speed to use map function in order to use full height of graph
    float highestSpeed = speedList.get(0);    
    float lowestSpeed = speedList.get(0);
    
    for(int i = 0; i < speedList.size(); i++)
    {
       if(speedList.get(i) > highestSpeed)
       {
         highestSpeed = speedList.get(i);
       }
       if(speedList.get(i) < lowestSpeed)
       {
         lowestSpeed = speedList.get(i);
       }  
    }
   // println(highestSpeed, lowestSpeed, highestSpeed - lowestSpeed);
    
    // Find longest and shortest lengths for mapping
    int shortLength = lengths.get(0);
    int longLength = lengths.get(0);
    
    for(int i:lengths)
    {
      if(i > longLength)
      {
        longLength = i;
      }
      if(i < shortLength)
      {
        shortLength = i;
      }
    }
    println(longLength, shortLength, longLength - shortLength);
    
    /*
    stroke(0, 255, 255);
    strokeWeight(4);
      
    lineWidth = windowRange / (float)(speedList.size() - 1);

    for(int i = 1; i < speedList.size(); i++)
    {
      float x1 = border + ((i - 1) * lineWidth);
      float x2 = border + (i * lineWidth);      
      float y1 = map(speedList.get(i - 1), lowestSpeed, highestSpeed, graph_height, (graph_height) - (height - (border * 2.0f)));
      float y2 = map(speedList.get(i), lowestSpeed, highestSpeed, graph_height, (graph_height) - (height - (border * 2.0f)));

      line(x1, y1, x2, y2);
    }
    
    // Stages scatter graph
    fill(255, 0, 255);
    stroke(255, 0, 255);
    strokeWeight(0);
    for(int i = 0; i < stages.size(); i++)
    {
       float x1 = border + (i * lineWidth);
       float y1 = map(stages.get(i), 19, 25, graph_height, (graph_height) - (height - (border * 2.0f)));
       rect(x1, y1, 4, 4);
    }*/
    
    strokeWeight(2);
    stroke(255);
    fill(255);
    
    // x axis (Year axis)
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
    
    stroke(0, 255, 255);
    strokeWeight(3);
    
    // Speed axis 
    line(border, border, border, graph_height);
    for(int i = 0; i <= verticalIntervals; i++)
    {
      float y = (graph_height) - (i * verticalWindowGap);
      line(border - tickSize, y, border, y);

      int range = (int) (highestSpeed - lowestSpeed);
      verticalDataGap = range / verticalIntervals;
      
      float hAxisLabel = (verticalDataGap * i) + (int) lowestSpeed;
  
      textAlign(RIGHT, CENTER);  
      text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
    }
    
    // Length axis
    line(width * 0.5f, border, width * 0.5f, graph_height);
    for(int i = 0; i <= lengthIntervals; i++)
    {
      float y = (graph_height) - (i * verticalWindowGap);
      line(width * 0.5f - tickSize, y, width * 0.5f, y);

      int range = (int) (longLength - shortLength);
      lengthDataGap = range / lengthIntervals;
      
      float hAxisLabel = (lengthDataGap * i) + (int) shortLength;
  
      textAlign(RIGHT, CENTER);  
      text(nf(hAxisLabel, 2, 2), width* 0.5f - (tickSize * 2.0f), y);
    }
    
    
    /*
    
    Find lowest stages
    Replace 19 with lowest!!
    
    */
    
    // Stages axis
    stroke(255, 0, 255);
    line(width - border, border, width - border, graph_height);
    for(int i = 0; i <= verticalStageIntervals; i++)
    {
      float y = (graph_height) - (i * verticalStageWindowGap);
      line(graph_width + tickSize, y, graph_width, y);
      
      int hAxisLabel = i + 19;
          
      textAlign(LEFT, CENTER);  
      text(hAxisLabel, graph_width + (tickSize * 3.0f), y);
    }
    
    /*
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
      int stage = years.get(x).stages;
      
      // Determine y coordinate of ellipse in relation to line graph
      float y = map(speedList.get(x), lowestSpeed, highestSpeed, graph_height, (graph_height) - (height - (border * 2.0f)));
      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      ellipse(mouseX, y, 10, 10);
      
      fill(255);
      // Display speed and year on relevant side of line, depending on location across graph
      if(mouseX < 200)
      {
        textAlign(LEFT, CENTER);
        text("Year: " + year, mouseX + 10, height - 200);
        text("Speed: " + speed + " Km/h", mouseX + 10, height - 180);
        text("Stages: " + stage, mouseX + 10, height - 160);
      }
      else
      {
        textAlign(RIGHT, CENTER);
        text("Year: " + year, mouseX - 10, height - 200);
        text("Speed: " + speed + " Km/h", mouseX - 10, height - 180);
        text("Stages: " + stage, mouseX - 10, height - 160);
      }
    }*/
  }
}