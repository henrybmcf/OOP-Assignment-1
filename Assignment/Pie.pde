class Pie
{
  float radius = width * 0.5f;
  
  color[] colours = new color[6];
  
  Pie()
  {
    for(int i = 0; i < 6; i ++)
    {
      colours[i] = color(random(100, 255), random(100, 255), 0);
    }
  }
  
  void update(int[] counter)
  {
    float sum = 0.0f;
    
    for(int c:counter)
    {
      sum += c;
    }

    float toMouseX = mouseX - radius;
    float toMouseY = mouseY - radius;  
    float angle = atan2(toMouseY, toMouseX);  
  
    if (angle < 0)
    {
      angle = TWO_PI + angle;
    }
  
    float last = 0.0f;
    float cumulative = 0.0f;
    
    for(int i = 0 ; i < counter.length ; i ++)
    {
      cumulative += counter[i];
  
      float current = map(cumulative, 0, sum, 0, TWO_PI);
  
      stroke(colours[i]);
      fill(colours[i]);
      
      float r = radius;
  
      if (angle > last && angle < current)
      {
        r = radius * 1.5f;
      }
      
      arc(radius, radius, r, r, last, current);
      last = current;       
    }
    
    stroke(255);
    line(radius, radius, mouseX, mouseY);
  }
}