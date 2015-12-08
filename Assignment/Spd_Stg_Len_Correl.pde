class Spd_Stg_Len_Correl
{
  float xBorder, yBorder;
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
  int speedTime, stageTime, lengthTime;
  int speedIndex, stageIndex, lengthIndex;
  float average;

  Spd_Stg_Len_Correl()
  {
    xBorder = width * 0.1f;
    yBorder = height * 0.1f;
    graphWindowRange = width - xBorder;
    vertGraphWindowRange = height - yBorder;
    graphWidth = width - (xBorder * 2.0f);
    graphHeight = height - (yBorder * 2.0f);
    tickSize = xBorder * 0.1f;
    lineWidth = graphWidth / (speedList.size() - 1);
    verticalIntervals = 10;
    dataGaps = graphHeight / verticalIntervals;
    verticalStageIntervals = 5;
    stageDataGaps = graphHeight / verticalStageIntervals; 
    speedColour = color(0, 255, 255);
    lengthColour = color(255, 255, 0);
    stagesColour = color(255, 0, 255);
    rectMode(CENTER);
    speedTime = 3;
    stageTime = 3;
    lengthTime = 3;
    speedIndex = 1;
    stageIndex = 1;
    lengthIndex = 1;

    // Find lowest & highest for mapping
    highestSpeed = speedList.max();
    lowestSpeed = speedList.min();
    highStage = stages.max();
    lowStage = stages.min();
    longLength = lengths.max();
    shortLength = lengths.min();
  }

  void render()
  { 
    // Display Graph Info
    fill(200, 10, 235);
    textAlign(CENTER);
    text("Three way correlation graph of speed, number of stages and length.", width * 0.5f, 30);
    fill(speedColour);
    text("S - Speed", width * 0.2f, 70);
    fill(stagesColour);
    text("T - Stages", width * 0.4f, 70);
    fill(lengthColour);
    text("L - Length", width * 0.6f, 70);
    fill(50, 130, 255);
    text("K - Legend", width * 0.8f, 70);
    
    // Speed Graph
    if (correlation[0])
    {
      strokeWeight(3);
      drawAxis(verticalIntervals, dataGaps, "Speed", speedColour, (highestSpeed - lowestSpeed), lowestSpeed);

      // Timing drawing graph animation
      if (speedTime > 3)
      {
        if (speedIndex < speedList.size())
          speedIndex++;
        speedTime = 0;
      }
      for (int j = 1; j < speedIndex; j++)
        drawGraph(j, 0, speedList, lowestSpeed, highestSpeed);
      speedTime++;
    }

    // Stages Graph
    if (correlation[1])
    {      
      strokeWeight(3);
      stroke(stagesColour);
      line(graphWindowRange, yBorder, graphWindowRange, vertGraphWindowRange);
      drawAxis(verticalStageIntervals, stageDataGaps, "Stages", stagesColour, 0, lowStage);
      // Convert stage arraylist to float in order to pass to drawGraph method
      FloatList List = new FloatList();
      for (int i : stages)
        List.append(float(i));

      // Timing drawing graph animation
      if (stageTime > 3)
      {
        if (stageIndex < stages.size())
          stageIndex++;
        stageTime = 0;
      }
      for (int j = 1; j < stageIndex; j++)
        drawGraph(j, 1, List, lowStage, highStage);
      stageTime++;
    }

    // Length Graph
    if (correlation[2])
    {  
      strokeWeight(4);
      drawAxis(verticalIntervals, dataGaps, "Length", lengthColour, longLength - shortLength, shortLength);
      // Convert stage arraylist to float in order to pass to drawGraph method
      FloatList List = new FloatList(); 
      for (int i : lengths)
        List.append(float(i));

      // Timing drawing graph animation
      if (lengthTime > 3)
      {
        if (lengthIndex < lengths.size())
          lengthIndex++;
        lengthTime = 0;
      }
      for (int j = 1; j < lengthIndex; j++)
        drawGraph(j, 2, List, shortLength, longLength);
      lengthTime++;
    }

    // Speed & Length Axis
    stroke(speedColour);
    strokeWeight(3);
    line(xBorder, yBorder, xBorder, vertGraphWindowRange);
    for (int i = 0; i <= verticalIntervals; i++)
      line(xBorder - tickSize, vertGraphWindowRange - (i * dataGaps), xBorder, vertGraphWindowRange - (i * dataGaps));   

    // X Axis (Year Axis)
    drawYearAxis();
    displayYearInfo(1);
  }

  void drawYearAxis()
  {
    stroke(255);
    fill(255);
    strokeWeight(2);
    line(xBorder, vertGraphWindowRange, graphWindowRange, vertGraphWindowRange);    
    horizInterval = graphWidth / (yearList.size() - 1);
    for (int i = 0; i < yearList.size(); i += 5)
    {     
      float x = xBorder + (i * horizInterval);
      line(x, vertGraphWindowRange, x, vertGraphWindowRange + tickSize);
      float textY = height - (yBorder * 0.5f);
      textAlign(CENTER, CENTER);
      text(yearList.get(i), x, textY);
    }
  }

  // Draw vertical Axis'
  void drawAxis(int intervals, float windowGap, String graph, color axisColour, float range, float low)
  {
    stroke(axisColour);
    fill(axisColour);
    float axisLabel = 0.0f;
    float dataGap;
    for (int i = 0; i <= intervals; i++)
    {
      float y = vertGraphWindowRange - (i * windowGap);
      // Display correct labels depending on which axis 
      if (graph == "Stages")
      {
        line(graphWindowRange + tickSize, y, graphWindowRange, y);
        axisLabel = i + low;
        textAlign(LEFT, CENTER);  
        text(int(axisLabel), graphWindowRange + (tickSize * 2.0f), y);
      }   
      if (graph == "Speed" || graph == "Length")
      {
        if (graph == "Length")
          if (correlation[0])
            y += 20; 
        dataGap = range / verticalIntervals;
        axisLabel = (dataGap * i) + low;
        textAlign(RIGHT, CENTER);  
        text(nf(axisLabel, 2, 2), xBorder - (tickSize * 2.0f), y);
      }
    }
  }

  // Same function to draw all three graphs, pass ID to identify which graph is being drawn
  void drawGraph(int i, int ID, FloatList list, float low, float high)
  {
    rectMode(CENTER);
    // Calculate x and y coordinates for each section of graph
    // Calculate x by stepping across by  increments of lineWidth
    float x1 = xBorder + ((i - 1) * lineWidth);
    float x2 = xBorder + (i * lineWidth);
    // Calculate y by mapping current value onto the height of the graph
    float y1 = map(list.get(i - 1), low, high, vertGraphWindowRange, vertGraphWindowRange - graphHeight);
    float y2 = map(list.get(i), low, high, vertGraphWindowRange, vertGraphWindowRange - graphHeight);

    // Case for each type of availbale graph
    switch(correlationID[ID])
    {
      case "Trend":
        strokeWeight(4);
        line(x1, y1, x2, y2);
        break;
      case "Scatter":
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        break;
      case "scatterTrend":
        strokeWeight(1);
        rect(x1, y1, 4, 4);
        line(x1, y1, x2, y2);
        break;
    }
  }
  
  // Display information for a particular year depending on mouseX
  void displayYearInfo(int sketchID)
  {
    // Calculate which year the mouse is in
    int x = (int) ((mouseX - xBorder) / lineWidth);
    float xCoord = xBorder + (x * lineWidth);
    
    if (x >= 0 && x < years.size())
    {
      // Determine y coordinate of ellipse in relation to speed graph
      float speedY = map(speedList.get(x), lowestSpeed, highestSpeed, vertGraphWindowRange, (vertGraphWindowRange) - graphHeight);
      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      // Draw line to show exact year and speed depending on x coordinates of mouse
      if (sketchID != 2)
        line(xCoord, yBorder, xCoord, vertGraphWindowRange);
      // Draw ellipse showing point on speed graph
      ellipse(xCoord, speedY, 10, 10);

      if (sketchID == 1)
      {
        // Determine y coordinate of ellipse in relation to length graph
        float lengthY = map(lengths.get(x), shortLength, longLength, vertGraphWindowRange, (vertGraphWindowRange) - graphHeight);
        stroke(0, 0, 255);
        fill(0, 0, 255);
        // Draw ellipse showing point on length graph
        ellipse(xCoord, lengthY, 10, 10);
      }
      // For speed graph, calculate distance from mouseX year's speed to the average and display
      if (sketchID == 2)
      {
        float avgY = map(average, lowestSpeed, highestSpeed, vertGraphWindowRange, yBorder);
        stroke(255, 0, 0);
        fill(255, 0, 0);
        if (speedY > avgY)
        {   
          line(xCoord, speedY, xCoord, vertGraphWindowRange);
          line(xCoord, avgY, xCoord, yBorder);
          stroke(255);
          strokeWeight(4);
          for (int i = 1; i < (speedY - avgY)/10; i++)
            line(xCoord, avgY + (i * 10), xCoord, avgY + (i * 10) - 5);
        }
        else
        {   
          line(xCoord, speedY, xCoord, yBorder);    
          line(xCoord, avgY, xCoord, vertGraphWindowRange);
          stroke(255);
          strokeWeight(4);
          for (int i = 1; i < (avgY - speedY)/10; i++)
            line(xCoord, avgY - (i * 10), xCoord, avgY - (i * 10) + 5);
        }
        yearInfo = true;
      }   
      
      // Determine if user has specified to show information for each year
      if (yearInfo)
      {
        // Display speed and year on relevant side of line, depending on location across graph
        fill(255);
        float text_coordinates;
        // Show info on left or right hand side of line depending on location across graph, so as to not interfere with axis
        if (xCoord < 360)
        {
          textAlign(LEFT, CENTER);
          text_coordinates = xCoord + 10;
        }
        else
        {
          textAlign(RIGHT, CENTER);
          text_coordinates = xCoord - 10;
        }
        float textHeight;
        if (sketchID == 2)
        {
          textHeight = vertGraphWindowRange - 80;
          text(nf(abs(speedList.get(x) - average), 1, 2) + " Km/h to Avg", text_coordinates, textHeight + 50);
        }
        else
        {
          textHeight = vertGraphWindowRange - 105;
          // Get and display information
          text("Stages: " + stages.get(x), text_coordinates, textHeight + 50);
          text("Length: " + lengths.get(x) + "Km", text_coordinates, textHeight + 75);
        }
        text("Year: " + years.get(x).tour_year, text_coordinates, textHeight);
        text("Speed: " + speedList.get(x) + " Km/h", text_coordinates, textHeight + 25);
      }
    }
  }
}