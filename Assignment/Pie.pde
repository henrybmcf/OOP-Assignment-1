class Pie
{
  float radius;
  float centX, centY;
  float sin, cos;
  float x, y;
  float lineX, lineY;
  float theta;
  color[] colours = new color[counter.size()];

  Pie()
  {
    this(width * 0.3f, width * 0.5f, height * 0.55f);
  }

  Pie(float radius, float centX, float centY)
  {
    this.radius = radius;
    this.centX = centX;
    this.centY = centY;
    for (int i = 0; i < colours.length; i ++)
      colours[i] = color(random(100, 255), random(100), random(100, 255));
  }

  void update()
  {
    // Display Graph Information
    fill(50, 130, 255);
    textAlign(CENTER);
    text("Pie graph of frequency of stages of the Tour de France from 1950 - 2015.\nStationery number represents number of stages.\nMotion number being number of times it has occured", centX, 40);
   
    for (int i = 0; i < counter.size(); i++)
    {
      fill(130, 255, 50);
      text(i + 20 + " = ", 50, (i + 1) * 40);
      fill(255, 50, 130);
      text(counter.get(i), 90, (i + 1) * 40);
    }

    float sum = 0.0f;
    for (int c : counter)
      sum += c;
    float angle = atan2(mouseY - centY, mouseX - centX);
    if (angle < 0)
      angle = TWO_PI + angle;  
    float last = 0.0f;
    float cumulative = 0.0f;

    for (int i = 0; i < counter.size(); i ++)
    {
      cumulative += counter.get(i);
      float current = map(cumulative, 0, sum, 0, TWO_PI);
      float r = radius;

      if (angle > last && angle < current)
      {
        r = radius * 1.5f;
        if (mouseY < centY)
          theta = angle - PI;
        else
          theta = angle;
        sin = abs(sin(theta));
        cos = abs(cos(theta));
        
        if (mouseX > centX)
        {
          x = centX + (radius * cos);
          lineX = centX + ((radius * 0.95f) * cos);
        }
        else
        {
          x = centX - (radius * cos);
          lineX = centX - ((radius * 0.95f) * cos);
        }        
        if (mouseY < centY)
        {
          y = centY - (radius * sin);
          lineY = centY - ((radius * 0.95f) * sin);
        }
        else
        {
          y = centY + (radius * sin);
          lineY = centY + ((radius * 0.95f) * sin);
        }
        fill(130, 255, 50);
        textAlign(CENTER, CENTER);
        text(counter.get(i), x, y);
      }

      strokeWeight(1);
      stroke(255);
      fill(colours[i]);
      arc(centX, centY, r, r, last, current, PIE);
      
      float alpha = (current + last) * 0.5f;
      float labelX = 0.0f;
      float labelY = 0.0f;
      float smallRad = radius * 0.85f;
      if (alpha <= HALF_PI)
      {
        labelX = centX + (smallRad * cos(alpha));
        labelY = centY + (smallRad * sin(alpha));
      }
      else if (alpha <= PI * 1.5f && alpha > PI)
      {
        alpha -= PI;
        labelX = centX - (smallRad * cos(alpha));
        labelY = centY - (smallRad * sin(alpha));
      }
      else
      {
        labelX = centX - (smallRad * -cos(alpha));
        labelY = centY + (smallRad * sin(alpha));
      }
      textAlign(CENTER);
      fill(255, 50, 130);
      text(i + 20, labelX, labelY);
      last = current;
    }
    stroke(130, 255, 50);
    strokeWeight(2);
    line(centX, centY, lineX, lineY);
  }
}