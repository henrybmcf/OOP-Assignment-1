class Bubble
{ 
  color[] colour = new color[31];
  int highWins;
  int lowWins;
  int highCountry;
  int lowCountry;
  int bubbleTime, bubbleIndex;
  
  Bubble()
  {
    highWins = Collections.max(wins);
    lowWins = Collections.min(wins);
    highCountry = Collections.max(cWins);
    lowCountry = Collections.min(cWins); 
    
    bubbleTime = 4;
    bubbleIndex = 1;
    
    for (int i = 0; i < colour.length; i++)
    {
      float c2 = map(wins.get(i), lowWins, highWins, 255, 0);
      float c3 = map(wins.get(i), lowWins, highWins, 0, 255);
      colour[i] = color(255, c2, c3);
    }
  }
  
  void render()
  {
    // Display Graph Info
    fill(50, 130, 255);
    textAlign(CENTER);
    text("Bubble graph of total stage win records.\nR - Rider wins      C - Country wins", width * 0.5f, 40);

    if (bubbleGraph == "Country")
    {
      fill(255);
      for (int i = 0; i < cWins.size(); i++)
      {
        float y = map(cWins.get(i), lowCountry, highCountry, height - 50, 50);
        float radius = map(cWins.get(i), lowCountry, highCountry, 30, 100);
        strokeWeight(3);
        stroke(255);
        ellipse(countryX.get(i), y, radius, radius);

        pushMatrix();
        translate(countryX.get(i) - (radius * 0.5f), y - (radius * 0.5f));
        PImage flag;
        // PImage flag = loadImage(country.get(i) + ".jpg");
        if (i < 9)
        {
          flag = loadImage(country.get(i) + ".png");
        }
        else
        {
          flag = loadImage(country.get(1) + ".png");
        }
        image(flag, 0, 0, radius, radius);
        popMatrix();
      }
    }

    if (bubbleGraph == "Rider")
    {
      drawAxis();
      
      float riderX = 0.0f;
      // Timing drawing graph animation
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
  }
  
  void drawAxis()
  {    
    strokeWeight(3);
    for(int i = 1; i < wins.size(); i++)
    {
      stroke(colour[i]);
      fill(colour[i]);
      int j = i - 1;
      float riderXPrev = map(wins.get(j), lowWins, highWins, 100, width - 50);
      float riderXNext = map(wins.get(i), lowWins, highWins, 100, width - 50);
      // Ticks
      line(riderXPrev, height * 0.9f, riderXPrev, height * 0.93f);
      // Axis
      line(riderXPrev, height * 0.9f, riderXNext, height * 0.9f);
      text(wins.get(j), riderXPrev, height * 0.97f);
    }
  }
}