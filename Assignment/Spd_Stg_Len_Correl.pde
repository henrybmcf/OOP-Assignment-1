class Spd_Stg_Len_Correl
{
  float x_border, y_border;
  float graphWindowRange, vertGraphWindowRange;
  float graphWidth, graphHeight;
  int verticalIntervals, verticalStageIntervals;
  float dataGaps, stageDataGaps;
  float tickSize;
  float lineWidth;
  float horizInterval;
  float highestSpeed, lowestSpeed;
  int longLength, shortLength;
  int highStage, lowStage;
  color lengthColour, speedColour, stagesColour;
 
  Spd_Stg_Len_Correl()
  {
    x_border = width * 0.1f;
    y_border = height * 0.1f;
    graphWindowRange = width - x_border;
    vertGraphWindowRange = height - y_border;
    graphWidth = width - (x_border * 2.0f);
    graphHeight = height - (y_border * 2.0f);
    tickSize = x_border * 0.1f;
    verticalIntervals = 10;
    dataGaps = graphHeight / verticalIntervals;
    verticalStageIntervals = 6;
    stageDataGaps = graphHeight / verticalStageIntervals; 
    speedColour = color(0, 255, 255);
    lengthColour = color(255, 255, 0);
    stagesColour = color(255, 0, 255);
    rectMode(CENTER);
  }

  void render()
  { 
    // Find lowest & highest for mapping
    highestSpeed = Collections.max(speedList);
    lowestSpeed = Collections.min(speedList);
    highStage = Collections.max(stages);
    lowStage = Collections.min(stages);
    longLength = Collections.max(lengths);
    shortLength = Collections.min(lengths);
    
    lineWidth = graphWidth / (speedList.size() - 1);
    
    // Speed Graph
    if(correlation[0])
    {
      strokeWeight(3);
      drawAxis(verticalIntervals, dataGaps, 1, speedColour, int(highestSpeed - lowestSpeed), int(lowestSpeed));
      for(int i = 1; i < speedList.size(); i++)
          drawGraph(i, 0, speedList, lowestSpeed, highestSpeed);
    }
    
    // Stages Graph
    if(correlation[1])
    {      
      strokeWeight(3);
      stroke(stagesColour);
      line(graphWindowRange, y_border, graphWindowRange, vertGraphWindowRange);
      drawAxis(verticalStageIntervals, stageDataGaps, 2, stagesColour, 0, lowStage);
      // Convert stage arraylist to float in order to pass to drawGraph method
      ArrayList<Float> List = new ArrayList<Float>();
      for(int i:stages)
          List.add(float(i));
      for(int i = 1; i < stages.size(); i++)
          drawGraph(i, 1, List, lowStage, highStage);
    }
    
    // Length Graph
    if(correlation[2])
    {  
      strokeWeight(4);
      drawAxis(verticalIntervals, dataGaps, 3, lengthColour, longLength - shortLength, shortLength);
      // Convert stage arraylist to float in order to pass to drawGraph method
      ArrayList<Float> List = new ArrayList<Float>(); 
      for(int i:lengths)
          List.add(float(i));
      for(int i = 1; i < lengths.size(); i++)
          drawGraph(i, 2, List, shortLength, longLength);
    }

    // Speed & Length Axis
    stroke(speedColour);
    strokeWeight(3);
    line(x_border, y_border, x_border, vertGraphWindowRange);
    for(int i = 0; i <= verticalIntervals; i++)
        line(x_border - tickSize, vertGraphWindowRange - (i * dataGaps), x_border, vertGraphWindowRange - (i * dataGaps));   
  
    // X Axis (Year Axis)
    drawXAxis();
    
    displayYearInfo(1);
  }
  
  void drawXAxis()
  {
    stroke(255);
    fill(255);
    strokeWeight(2);
    line(x_border, vertGraphWindowRange, graphWindowRange, vertGraphWindowRange);    
    horizInterval = graphWidth / (yearList.size() - 1);
    for(int i = 0; i < yearList.size(); i++)
    {
      float x = x_border + (i * horizInterval);
      line(x, vertGraphWindowRange + tickSize, x, vertGraphWindowRange);
      float textY = height - (y_border * 0.5f);
      textAlign(CENTER, CENTER);
      text(yearList.get(i), x, textY);
    }
  }
  
  // Draw vertical Axis'
  void drawAxis(int intervals, float windowGap, int ID, color axisColour, int range, int low)
  {
    stroke(axisColour);
    fill(axisColour);
    float axisLabel = 0.0f;
    int dataGap;
    for(int i = 0; i <= intervals; i++)
    {
      float y = (vertGraphWindowRange) - (i * windowGap);
      if(ID == 2)
      {
        line(graphWindowRange + tickSize, y, graphWindowRange, y);
        axisLabel = i + low;
        textAlign(LEFT, CENTER);  
        text(int(axisLabel), graphWindowRange + (tickSize * 2.0f), y);
      }   
      if(ID == 1 || ID == 3)
      {
        if(ID == 3)
           if(correlation[0])
              y += 15; 
        dataGap = range / verticalIntervals;
        axisLabel = (dataGap * i) + low;
        textAlign(RIGHT, CENTER);  
        text(nf(axisLabel, 2, 2), x_border - (tickSize * 2.0f), y);
      }
    }
  }
  
  void drawGraph(int i, int ID, ArrayList<Float> list, float low, float high)
  {
    float x1 = x_border + ((i - 1) * lineWidth);
    float x2 = x_border + (i * lineWidth);
    float y1 = map(list.get(i - 1), low, high, vertGraphWindowRange, vertGraphWindowRange - graphHeight);
    float y2 = map(list.get(i), low, high, vertGraphWindowRange, vertGraphWindowRange - graphHeight);
    switch(correlationID[ID])
    {
      case 1:
        strokeWeight(4);
        line(x1, y1, x2, y2);
        break;
      case 2:
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        break;
      case 3:
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        line(x1, y1, x2, y2);
        break;
    }
  }
  
  void displayYearInfo(int sketchID)
  {
    // Determine which year the mouse is in
    int x = (int) ((mouseX - x_border) / lineWidth);
    float x_coord = x_border + (x * lineWidth);
    if(x >= 0 && x < years.size())
    {
      stroke(255, 0, 0);
      fill(255, 0, 0);
      // Draw line to show exact year and speed depending on x coordinates of mouse
      line(x_coord, y_border, x_coord, vertGraphWindowRange);
      // Determine y coordinate of ellipse in relation to line graph
      float speed_y = map(speedList.get(x), lowestSpeed, highestSpeed, vertGraphWindowRange, (vertGraphWindowRange) - graphHeight);
      // Draw ellipse showing point on speed graph
      ellipse(x_coord, speed_y, 10, 10);
      
      if(sketchID == 1)
      {
        float length_y = map(lengths.get(x), shortLength, longLength, vertGraphWindowRange, (vertGraphWindowRange) - graphHeight);
        // Draw ellipse showing point on length graph
        stroke(0, 0, 255);
        fill(0, 0, 255);
        ellipse(x_coord, length_y, 10, 10);
      }
      
      // Display speed and year on relevant side of line, depending on location across graph
      fill(255);
      float text_coordinates;
      if(mouseX < 300)
      {
        textAlign(LEFT, CENTER);
        text_coordinates = x_coord + 10;
      }
      else
      {
        textAlign(RIGHT, CENTER);
        text_coordinates = x_coord - 10;
      }
      float textHeight;
      if(sketchID == 2)
      {
        textHeight = vertGraphWindowRange - 50;
      }
      else
      {
        textHeight = height - 200;
        text("Stages: " + stages.get(x), text_coordinates, textHeight + 40);
        text("Length: " + lengths.get(x) + "Km", text_coordinates, textHeight + 60);
      }
      text("Year: " + years.get(x).tour_year, text_coordinates, textHeight);
      text("Speed: " + speedList.get(x) + " Km/h", text_coordinates, textHeight + 20);
    }  
  }
}