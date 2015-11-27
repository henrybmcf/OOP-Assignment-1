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
    lengthWindowGap = verticalWindowRange / verticalIntervals;
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
    
    // Speed Graph
    if(correlation[0] == true)
    {
      // Speed axis 
      stroke(0, 255, 255);
      strokeWeight(3);
      for(int i = 0; i <= verticalIntervals; i++)
      {
        float y = (graph_height) - (i * verticalWindowGap);  
        int range = (int) (highestSpeed - lowestSpeed);
        verticalDataGap = range / verticalIntervals; 
        float hAxisLabel = (verticalDataGap * i) + (int) lowestSpeed;
        textAlign(RIGHT, CENTER);  
        text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
      }
      
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
    }
  
    // Stages Scatter Graph
    if(correlation[1] == true)
    {
       /*
      
      Find lowest stages
      Replace 19 with lowest!!
      
      */
      
      // Stages axis
      stroke(255, 0, 255);
      strokeWeight(3);
      fill(255, 0, 255);
      line(width - border, border, width - border, graph_height);
      for(int i = 0; i <= verticalStageIntervals; i++)
      {
        float y = (graph_height) - (i * verticalStageWindowGap);
        line(graph_width + tickSize, y, graph_width, y);
        int hAxisLabel = i + 19;       
        textAlign(LEFT, CENTER);  
        text(hAxisLabel, graph_width + (tickSize * 3.0f), y);
      }
      
      lineWidth = windowRange / (float)(stages.size() - 1);
      strokeWeight(0);
      for(int i = 0; i < stages.size(); i++)
      {
         float x1 = border + (i * lineWidth);
         float y1 = map(stages.get(i), 19, 25, graph_height, (graph_height) - (height - (border * 2.0f)));
         rect(x1, y1, 4, 4);
      }
    }
    
    // Length Graph
    if(correlation[2] == true)
    {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      strokeWeight(4);
      // Length axis 
      for(int i = 0; i <= verticalIntervals; i++)
      {
        float y = (graph_height) - (i * verticalWindowGap);
        int range = (int) (longLength - shortLength);
        lengthDataGap = range / verticalIntervals;
        float hAxisLabel = (lengthDataGap * i) + (int) shortLength;
        if(correlation[0] == true)
        {
          y += 15;
        }
        textAlign(RIGHT, CENTER);  
        text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
      }
      
      lineWidth = windowRange / (float)(lengths.size() - 1);
      for(int i = 1; i < lengths.size(); i++)
      {
        float x1 = border + ((i - 1) * lineWidth);
        float x2 = border + (i * lineWidth);      
        float y1 = map(lengths.get(i - 1), shortLength, longLength, graph_height, (graph_height) - (height - (border * 2.0f)));
        float y2 = map(lengths.get(i), shortLength, longLength, graph_height, (graph_height) - (height - (border * 2.0f)));
        line(x1, y1, x2, y2);
      }
    }
    
    stroke(0, 255, 255);
    strokeWeight(3);
    for(int i = 0; i <= verticalIntervals; i++)
    {
      float y = (graph_height) - (i * verticalWindowGap);
      line(border - tickSize, y, border, y);   
    }
    line(border, border, border, graph_height);
    
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
    
    // Determine which year the mouse is in
    int x = (int) ((mouseX - border) / lineWidth);
    float x_coord = map(x, 0, years.size(), border, width - border);
    
    // Draw line to show exact year and speed depending on x coordinates of mouse
    if(mouseX > border && mouseX < (graph_width))
    {
      stroke(255, 0, 0);
      line(x_coord, border, x_coord, graph_height);
    }
    
    if(x >= 0 && x < years.size())
    {
      int year = years.get(x).tour_year;
      float speed = years.get(x).speed;
      int stage = years.get(x).stages;
      int tour_length = years.get(x).tour_length;
      
      // Determine y coordinate of ellipse in relation to line graph
      float speed_y = map(speedList.get(x), lowestSpeed, highestSpeed, graph_height, (graph_height) - (height - (border * 2.0f)));
      float length_y = map(lengths.get(x), shortLength, longLength, graph_height, (graph_height) - (height - (border * 2.0f)));
      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      ellipse(x_coord, speed_y, 10, 10);
      stroke(0, 255, 255);
      fill(0, 255, 255);
      ellipse(x_coord, length_y, 10, 10);    
      fill(255);
      
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
}