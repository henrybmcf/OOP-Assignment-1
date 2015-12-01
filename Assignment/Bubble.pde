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
    
    for(int i = 0; i < colour.length; i++)
    {
      float c2 = map(wins.get(i), lowWins, highWins, 255, 0);
      float c3 = map(wins.get(i), lowWins, highWins, 0, 255);
       
      colour[i] = color(255, c2, c3);
    }
    
    if(graph == 1)
    {
      fill(255);
      for(int i = 0; i < cWins.size(); i++)
      {
        float y = map(cWins.get(i), lowCountry, highCountry, height - 50, 50);
        float radius = map(cWins.get(i), lowCountry, highCountry, 30, 100);
        ellipse(stage_x.get(1), y, radius, radius);
      }
      
    }
    
    if(graph == 2)
    {
      for(int i = 0; i < wins.size(); i++)
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