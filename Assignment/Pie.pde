class Pie
{
  float radius;
  float centx, centy;
  float sin, cos;
  float x, y;
  float lineX, lineY;
  float theta;
  color[] colours = new color[counter.length];
  
  Pie()
  {
    this(width * 0.3f, width * 0.5f, height * 0.5f);
  }
  
  Pie(float radius, float centx, float centy)
  {
    this.radius = radius;
    this.centx = centx;
    this.centy = centy;
    
    for(int i = 0; i < colours.length; i ++)
        colours[i] = color(random(100, 255), random(100), random(100, 255));
  }
  
  void update()
  { 
    float sum = 0.0f;
    for(int c:counter)
        sum += c;
    float angle = atan2(mouseY - centy, mouseX - centx);
    if(angle < 0)
        angle = TWO_PI + angle;  
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
        if(mouseY < centy)
        {
          theta = angle - PI;
        }
        else
        {
          theta = angle;
        }
        
        sin = sin(theta);
        cos = cos(theta);
        if(sin < 0)
            sin = -sin;
        if(cos < 0)
            cos = -cos;
        if(mouseX > centx)
        {
          x = centx + (radius * cos);
          lineX = centx + ((radius * 0.95f) * cos);
        }
        else
        {
          x = centx - (radius * cos);
          lineX = centx - ((radius * 0.95f) * cos);
        }        
        if(mouseY < centy)
        {
          y = centy - (radius * sin);
          lineY = centy - ((radius * 0.95f) * sin);
        }
        else
        {
          y = centy + (radius * sin);
          lineY = centy + ((radius * 0.95f) * sin);
        }
        fill(255);
        text(counter[i], x, y);
      } 
      strokeWeight(1);
      fill(colours[i]);
      arc(centx, centy, r, r, last, current, PIE);
      last = current;
    }
    stroke(255);
    strokeWeight(2);
    line(centx, centy, lineX, lineY);
  }
}