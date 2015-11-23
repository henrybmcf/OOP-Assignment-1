class Pie
{
  float radius;
  
  color[] colours = new color[6];
  
  Pie()
  {
    radius = width * 0.5f;
    
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

      float r = radius;
  
      if(angle > last && angle < current)
      {
        r = radius * 1.5f;
        
        fill(255);
        
        float centx = width * 0.5f;
        float centy = height * 0.5f;
        
        float x;
        float y;
        float theta;
        
        if(mouseY < centy)
        {
          theta = angle - PI;
        }
        else
        {
          theta = angle;
        }
        
        float sin = sin(theta);
        float cos = cos(theta);
        
        if(sin < 0)
        {
          sin = -sin;
        }
        if(cos < 0)
        {
          cos = -cos;
        }
        
        if(mouseX > centx)
        {
          x = centx + (radius * cos);
        }
        else
        {
          x = centx - (radius * cos);
        }
        
        if(mouseY < centy)
        {
          y = centy - (radius * sin);
        }
        else
        {
          y = centy + (radius * sin);
        }
        text(counter[i], x, y);
      }
      
      strokeWeight(1);
      stroke(colours[i]);
      fill(colours[i]);
    
      arc(radius, radius, r, r, last, current);
      last = current;
    }
    
    stroke(255);
    strokeWeight(2);
    line(radius, radius, mouseX, mouseY);
  }
}