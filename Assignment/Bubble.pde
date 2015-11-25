class Bubble
{ 
  color[] colour = new color[31];
  
  void render()
  {
     for(int i = 0; i < colour.length; i++)
     {
       float c2 = map(wins.get(i), 10, 34, 255, 0);
       float c3 = map(wins.get(i), 10, 34, 0, 255);
       
       colour[i] = color(255, c2, c3);
     }
    
    int low = wins.get(0);
    int high = wins.get(0);
    
    for(int i:wins)
    {
      if(i < low)
      {
        low = i;
      }
      if(i > high)
      {
        high = i;
      }
    }
    
    for(int i = 0; i < wins.size(); i++)
    {
      float y = map(wins.get(i), low, high, height - 50, 50);
      float radius = map(wins.get(i), low, high, 30, 100);
      fill(colour[i]);
      stroke(colour[i]);
      ellipse(x.get(i), y, radius, radius);
    } 
  } 
}