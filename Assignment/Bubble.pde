class Bubble
{ 
  color[] colour = new color[31];
  int highWins;
  int lowWins;
  int highCountry;
  int lowCountry;
  int bubbleTime, bubbleIndex;
  float bubbleGraphWidth;
  float horizTick;
  float bubbleGraphHeight;
  float vertTick;

  Bubble()
  {
    // Find highest & lowest for mapping
    highWins = wins.max();
    lowWins = wins.min();
    highCountry = cWins.max();
    lowCountry = cWins.min();

    // Variables for timing drawing of graph
    bubbleTime = 4;
    bubbleIndex = 1;
    
    bubbleGraphWidth = width * 0.9f;
    horizTick = width * 0.02f;
    bubbleGraphHeight = height * 0.9f;
    vertTick = height * 0.03f;

    // Set colours for each segment of pie chart
    for (int i = 0; i < colour.length; i++)
    {
      float c2 = map(wins.get(i), lowWins, highWins, 255, 0);
      float c3 = map(wins.get(i), lowWins, highWins, 0, 255);
      colour[i] = color(255, c2, c3);
    }
  }

  void render()
  {
    // Display Graph Information
    fill(50, 130, 255);
    textAlign(CENTER);
    text("Bubble graph of total stage win records.\nR - Rider wins      C - Country wins      K - Statistics", width * 0.5f, 40);

    // Draw bubble graph for rider stage record wins
    if (bubbleGraph == "Rider")
    {
      drawRiderAxis();
      float riderX = 0.0f;
      // Timing drawing graph animation, by using 60fps, time to draw new bubble every tenth of a second 
      if (bubbleTime > 6)
      {
        if (bubbleIndex < wins.size())
          bubbleIndex++;
        bubbleTime = 0;
      }
      for (int i = 0; i < bubbleIndex; i++)
      {
        riderX = map(wins.get(i), lowWins, highWins, 100, width - 50);
        float radius = map(wins.get(i), lowWins, highWins, 50, 150);
        fill(colour[i]);
        strokeWeight(1);
        stroke(100);
        ellipse(riderX, stageY.get(i), radius, radius);
      }
      bubbleTime++;
    }

    // Draw bubble graph for country stage record wins
    if (bubbleGraph == "Country")
    {
      fill(130, 255, 50);
      stroke(130, 255, 50);
      strokeWeight(3);  
      // Axis
      line(bubbleGraphWidth, 150, bubbleGraphWidth, height * 0.95f);

      for (int i = 0; i < cWins.size(); i++)
      {
        float y = map(cWins.get(i), lowCountry, highCountry, height * 0.95f, 150);
        float radius = map(cWins.get(i), lowCountry, highCountry, 50, 100);     
        stroke(255);
        strokeWeight(4);
        ellipse(countryX.get(i), y, radius, radius);
        // Draw axis down to certain value, between these two parameters, axis ticks are too close together
        if (i < cWins.size()/3 || i == cWins.size() - 1)
        {
          stroke(130, 255, 50);
          // Ticks
          line(bubbleGraphWidth, y, bubbleGraphWidth + horizTick, y);
          textAlign(LEFT, CENTER);
          text(cWins.get(i), bubbleGraphWidth + horizTick * 2.0f, y);
        }
        // Load country flag image into each bubble
        pushMatrix();
        translate(countryX.get(i) - (radius * 0.5f), y - (radius * 0.5f));
        PImage flag = loadImage(country.get(i) + ".png");
        image(flag, 0, 0, radius, radius);
        popMatrix();
      }
    }
  }

  // Draw axis showing rider stage wins
  void drawRiderAxis()
  {    
    strokeWeight(3);
    for (int i = 1; i < wins.size(); i++)
    {
      stroke(colour[i]);
      fill(colour[i]);
      int j = i - 1;
      // Draw axis line in segments to follow colour of bubbles
      float riderXPrev = map(wins.get(j), lowWins, highWins, 100, width - 50);
      float riderXNext = map(wins.get(i), lowWins, highWins, 100, width - 50);
      // Ticks
      line(riderXPrev, bubbleGraphHeight, riderXPrev, bubbleGraphHeight + vertTick);
      // Axis
      line(riderXPrev, bubbleGraphHeight, riderXNext, bubbleGraphHeight);
      text(wins.get(j), riderXPrev, bubbleGraphHeight + vertTick * 2.0f);
    }
  }
}