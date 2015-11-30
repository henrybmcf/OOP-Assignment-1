class Spd_Stg_Len_Correl
{
  int verticalIntervals;
  float dataRange;
  float x_border;
  float y_border;
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
  float lengthWindowGap;
  float highestSpeed;
  float lowestSpeed;
  int shortLength;
  int longLength;
  color lengthColour;
  color speedColour;
  color stagesColour;
  
  Spd_Stg_Len_Correl()
  {
    verticalIntervals = 10;
    x_border = width * 0.1f;
    y_border = height * 0.1f;
    graph_height = height - y_border;
    graph_width = width - x_border;
    windowRange = width - (x_border * 2.0f);
    verticalWindowRange = height - (y_border * 2.0f);
    verticalWindowGap = verticalWindowRange / verticalIntervals;
    verticalStageIntervals = 6;
    verticalStageWindowGap = verticalWindowRange / verticalStageIntervals;
    lengthWindowGap = verticalWindowRange / verticalIntervals;
    
    speedColour = color(0, 255, 255);
    lengthColour = color(255, 255, 0);
    stagesColour = color(255, 0, 255);
    
    rectMode(CENTER);
  }

  void render()
  { 
    findMaxMin();
    
    // Speed Graph
    if(correlation[0] == true)
    {
      stroke(speedColour);
      strokeWeight(3);
      drawAxis(verticalIntervals, verticalWindowGap, 1);
      lineWidth = windowRange / (float)(speedList.size() - 1);
      for(int i = 1; i < speedList.size(); i++)
      {     
        float y1 = map(speedList.get(i - 1), lowestSpeed, highestSpeed, graph_height, (graph_height) - verticalWindowRange);
        float y2 = map(speedList.get(i), lowestSpeed, highestSpeed, graph_height, (graph_height) - verticalWindowRange);
        
        drawGraph(i, y1, y2, 0);
      }
    }
  
    // Stages Scatter Graph
    if(correlation[1] == true)
    {
       /*
      
      Find lowest stages
      Replace 19 with lowest!!
      
      */
      
      stroke(stagesColour);
      fill(stagesColour);
      strokeWeight(3);
      line(graph_width, y_border, graph_width, graph_height);
      drawAxis(verticalStageIntervals, verticalStageWindowGap, 2);
      lineWidth = windowRange / (float)(stages.size() - 1);
      for(int i = 1; i < stages.size(); i++)
      {
         float y1 = map(stages.get(i - 1), 19, 25, graph_height, (graph_height) - verticalWindowRange);
         float y2 = map(stages.get(i), 19, 25, graph_height, (graph_height) - verticalWindowRange);
         
         drawGraph(i, y1, y2, 1);
      }
    }
    
    // Length Graph
    if(correlation[2] == true)
    {
      stroke(lengthColour);
      fill(lengthColour);
      strokeWeight(4);
      drawAxis(verticalIntervals, verticalWindowGap, 3);
      lineWidth = windowRange / (float)(lengths.size() - 1);
      for(int i = 1; i < lengths.size(); i++)
      {     
        float y1 = map(lengths.get(i - 1), shortLength, longLength, graph_height, (graph_height) - verticalWindowRange);
        float y2 = map(lengths.get(i), shortLength, longLength, graph_height, (graph_height) - verticalWindowRange);
        
        drawGraph(i, y1, y2, 2);
      }
    }

    stroke(speedColour);
    strokeWeight(3);
    for(int i = 0; i <= verticalIntervals; i++)
    {
      float y = (graph_height) - (i * verticalWindowGap);
      line(x_border - tickSize, y, x_border, y);   
    }
    line(x_border, y_border, x_border, graph_height);
    
    stroke(255);
    fill(255);
    strokeWeight(2);
    
    // x axis (Year axis)
    line(x_border, graph_height, graph_width, graph_height);
    
    horizInterval = windowRange / (yearList.size() - 1);
    tickSize = x_border * 0.1f;
    
    for(int i = 0; i < yearList.size(); i++)
    {
     float x = x_border + (i * horizInterval);
     line(x, height - (y_border - tickSize), x, (graph_height));
     float textY = height - (y_border * 0.5f);
     textAlign(CENTER, CENTER);
     text(yearList.get(i), x, textY);
    }
    
    // Determine which year the mouse is in
    int x = (int) ((mouseX - x_border) / lineWidth);
    float x_coord = x_border + (x * lineWidth);
    
    if(x >= 0 && x < years.size())
    {
       // Draw line to show exact year and speed depending on x coordinates of mouse
      if(mouseX > x_border && mouseX < (graph_width))
      {
        stroke(255, 0, 0);
        line(x_coord, y_border, x_coord, graph_height);
      }
      
      // Determine y coordinate of ellipse in relation to line graph
      float speed_y = map(speedList.get(x), lowestSpeed, highestSpeed, graph_height, (graph_height) - verticalWindowRange);
      float length_y = map(lengths.get(x), shortLength, longLength, graph_height, (graph_height) - verticalWindowRange);
      
      // Draw ellipse showing point on speed graph
      stroke(255, 0, 0);
      fill(255, 0, 0);
      ellipse(x_coord, speed_y, 10, 10);
      
      // Draw ellipse showing point on length graph
      stroke(0, 0, 255);
      fill(0, 0, 255);
      ellipse(x_coord, length_y, 10, 10);    
      fill(255);
      
      // Find information to display
      int year = years.get(x).tour_year;
      float speed = speedList.get(x);
      int stage = stages.get(x);
      int tour_length = lengths.get(x);
      
      // Display speed and year on relevant side of line, depending on location across graph
      if(mouseX < 200)
      {
        textAlign(LEFT, CENTER);
        text("Year: " + year, x_coord + 10, height - 200);
        text("Speed: " + speed + " Km/h", x_coord + 10, height - 180);
        text("Stages: " + stage, x_coord + 10, height - 160);
        text("Length: " + tour_length, x_coord + 10, height - 140);
      }
      else
      {
        textAlign(RIGHT, CENTER);
        text("Year: " + year, x_coord - 10, height - 200);
        text("Speed: " + speed + " Km/h", x_coord - 10, height - 180);
        text("Stages: " + stage, x_coord - 10, height - 160);
        text("Length: " + tour_length, x_coord - 10, height - 140);
      }
    }
  }
  
  void findMaxMin()
  {
    // Find lowest and highest speed to use map function in order to use full height of graph
    highestSpeed = speedList.get(0);    
    lowestSpeed = speedList.get(0);
    
    for(float speed:speedList)
    {
       if(speed > highestSpeed)
       {
         highestSpeed = speed;
       }
       if(speed < lowestSpeed)
       {
         lowestSpeed = speed;
       }  
    }
    
    // Find longest and shortest lengths for mapping
    shortLength = lengths.get(0);
    longLength = lengths.get(0);
    
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
  }
  
  // Draw vertical Axis'
  void drawAxis(int intervals, float windowGap, int ID)
  {
    float axisLabel = 0.0f;
    println(intervals);
    for(int i = 0; i <= intervals; i++)
    {
      float y = (graph_height) - (i * windowGap);
      if(ID == 1)
      {
        int range = (int) (highestSpeed - lowestSpeed);
        verticalDataGap = range / verticalIntervals;
        axisLabel = (verticalDataGap * i) + (int) lowestSpeed;  
      }
      if(ID == 2)
      {
        line(graph_width + tickSize, y, graph_width, y);
        axisLabel = i + 19;       
        textAlign(LEFT, CENTER);  
        text((int) axisLabel, graph_width + (tickSize * 2.0f), y);
      }
      if(ID == 3)
      {
        int range = (int) (longLength - shortLength);
        lengthDataGap = range / verticalIntervals;
        axisLabel = (lengthDataGap * i) + (int) shortLength;
        if(correlation[0] == true)
        {
           y += 15;
        }
      }
      if(ID == 1 || ID == 3)
      {
        textAlign(RIGHT, CENTER);  
        text(nf(axisLabel, 2, 2), x_border - (tickSize * 2.0f), y);
      }
    }
  }
  
  void drawGraph(int i, float y1, float y2, int ID)
  {
    float x1 = x_border + ((i - 1) * lineWidth);
    float x2 = x_border + (i * lineWidth);
    
    switch(correlationID[ID])
    {
      case 1:
      {
        strokeWeight(4);
        line(x1, y1, x2, y2);
        break;
      }
      case 2:
      {
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        break;
      }
      case 3:
      {
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        line(x1, y1, x2, y2);
        break;
      }
    }   
  }
}