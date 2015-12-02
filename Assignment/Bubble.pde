class Bubble
{ 
  color[] colour = new color[31];
  int highWins;
  int lowWins;
  int highCountry;
  int lowCountry;

  void render()
  {
    highWins = Collections.max(wins);
    lowWins = Collections.min(wins);

    highCountry = Collections.max(cWins);
    lowCountry = Collections.min(cWins);

    color[] colour2 = new color[cWins.size()];

    for (int i = 0; i < colour.length; i++)
    {
      float c2 = map(wins.get(i), lowWins, highWins, 255, 0);
      float c3 = map(wins.get(i), lowWins, highWins, 0, 255);

      colour[i] = color(255, c2, c3);
    }

    for (int i = 0; i < colour2.length; i++)
    {
      float c2 = map(cWins.get(i), lowWins, highWins, 255, 0);
      float c3 = map(cWins.get(i), lowWins, highWins, 0, 255);

      colour2[i] = color(255, c2, c3);
    }

    if (bubbleGraph == 1)
    {
      fill(255);
      for (int i = 0; i < cWins.size(); i++)
      {
        float y = map(cWins.get(i), lowCountry, highCountry, height - 50, 50);
        float radius = map(cWins.get(i), lowCountry, highCountry, 30, 100);
        //fill(colour2[i]);
        strokeWeight(3);
        stroke(255);
        ellipse(country_x.get(i), y, radius, radius);

        pushMatrix();
        translate(country_x.get(i) - (radius * 0.5f), y - (radius * 0.5f));
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

    if (bubbleGraph == 2)
    {
      for (int i = 0; i < wins.size(); i++)
      {
        float y = map(wins.get(i), lowWins, highWins, height - 50, 50);
        float radius = map(wins.get(i), lowWins, highWins, 30, 100);
        fill(colour[i]);
        stroke(colour[i]);
        ellipse(stage_x.get(i), y, radius, radius);
      }
    }
  }
}