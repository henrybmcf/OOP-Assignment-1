class Pie
{
  float radius;
  float centX, centY;
  float sin, cos;
  float x, y;
  float lineX, lineY;
  float theta;
  color[] colours = new color[counter.length];

  Pie()
  {
    this(width * 0.3f, width * 0.5f, height * 0.5f);
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
    // Display Graph Info
    fill(50, 130, 255);
    textAlign(CENTER);
    text("Pie graph of frequency of stages of the Tour de France from 1950 - 2015.\nNumber represents number of times that number of stages has occured", (width * 0.5f), 40);

    for (int i = 0; i < counter.length; i++)
    {
      text(i + 20 + " = " + counter[i], 50, (i + 1)*40);
    }

    float sum = 0.0f;
    for (int c : counter)
      sum += c;
    float angle = atan2(mouseY - centY, mouseX - centX);
    if (angle < 0)
      angle = TWO_PI + angle;  
    float last = 0.0f;
    float cumulative = 0.0f;

    for (int i = 0; i < counter.length; i ++)
    {
      cumulative += counter[i];
      float current = map(cumulative, 0, sum, 0, TWO_PI);
      float r = radius;

      if (angle > last && angle < current)
      {
        r = radius * 1.5f;
        if (mouseY < centY)
        {
          theta = angle - PI;
        }
        else
        {
          theta = angle;
        }

        sin = sin(theta);
        cos = cos(theta);
        if (sin < 0)
          sin = -sin;
        if (cos < 0)
          cos = -cos;
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
        fill(255);
        text(counter[i], x, y);
      }
      
      strokeWeight(1);
      fill(colours[i]);
      arc(centX, centY, r, r, last, current, PIE);
      
      fill(255);
      if (last + (current * 0.5f) < HALF_PI)
      {
        float x1 = centX + sin(last + (current * 0.5f) + HALF_PI) * radius;
        float y1 = centY - cos(last + (current * 0.5f) + HALF_PI) * radius;
        text(i + 20, x1, y1);
      }
      if (last + (current * 0.5f) > HALF_PI && last + (current * 0.5f) < PI)
      {
        float x1 = centX + sin(last + (current * 0.5f) + (QUARTER_PI * 1.5)) * radius;
        float y1 = centY - cos(last + (current * 0.5f) + (QUARTER_PI * 1.5)) * radius;
        text(i + 20, x1, y1);
      }
      else
      {
        float x1 = centX + sin(last + (current * 0.5f)) * radius;
        float y1 = centY - cos(last + (current * 0.5f)) * radius;
        text(i + 20, x1, y1);
      }
      
      fill(255);
      //text(i + 20, x1, y1);  
      println((i + 20) + " = " + (last + (current*0.5f)));
      
      last = current;
    }
    stroke(255);
    strokeWeight(2);
    line(centX, centY, lineX, lineY);
  }
}