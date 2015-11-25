class Bubble
{ 
  color[] colour = new color[31];

  Bubble()
  {
     println("in a bubble");  
     
  }
  
  void render()
  { 
   // println(wins.size());
    //println(colour.length);
    for(int i = 0; i < colour.length; i++)
     {
       float j = map(wins.get(i), 10, 34, 0, 255);
       float k = map(wins.get(i), 10, 34, 0, 255);
       float l = map(wins.get(i), 10, 34, 0, 255);
       
       colour[i] = color(j, k, l);
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
      //float x = map(wins.get(i), low, high, 50, width - 50);
      float y = map(wins.get(i), low, high, height - 50, 50);
      float radius = map(wins.get(i), low, high, 10, 100);
      //fill(colour[i]);
      //stroke(colour[i]);
      ellipse(x.get(i), y, radius, radius);
    } 
  } 
}