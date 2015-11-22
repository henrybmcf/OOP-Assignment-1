class Wheel
{
  PVector pos;
  int segments = 8;
  
  float diameter;
  
  color[] colours = new color[segments];

  Wheel()
  {
    this(width * 0.5f, height  * 0.5f, 300);
  }

  Wheel(float x, float y, float diameter)
  {
    pos = new PVector(x, y);
    this.diameter = diameter;    
    theta = TWO_PI / segments;
    thetaBase = PI + HALF_PI;

    colours[0] = color(170, 0, 0);
    colours[1] = color(0, 170, 0);
    colours[2] = color(0, 0, 170);
    colours[3] = color(200, 200, 0);
    colours[4] = color(200, 0, 200);
    colours[5] = color(0, 200, 200);
    colours[6] = color(100, 100, 255);
    colours[7] = color(200, 255, 200);
  }

  void render()
  {
    stroke(255);
    fill(0);

    for (int i = 0; i < segments; i++)
    {
      fill(colours[i]);
      stroke(colours[i]);
      strokeWeight(1);

      arc(pos.x, pos.y, diameter, diameter, thetaBase + (theta * i), (thetaBase + (theta * i)) + theta, PIE);
    }
  }

  void update()
  {
    if (keyPressed)
    {
      if (keyCode == LEFT || keyCode == RIGHT)
      {
        println("tBase = " + thetaBase);
        println(PI+HALF_PI);
        println("theta = " + theta);

        option = ((PI + HALF_PI - thetaBase) / theta);

        if (option < 1)
        {
          option += 8;
        }

        if (option > 8)
        {
          option = option - 8;
        }
      }

      if (keyCode == LEFT)
      {
        thetaBase -= 0.05f;

        if (thetaBase <= 0.0f)
        {
          thetaBase = TWO_PI;
        }
      }

      if (keyCode == RIGHT)
      {
        thetaBase += 0.05f;

        if (thetaBase >= TWO_PI)
        {
          thetaBase = 0.0f;
        }
      }

      if (key == RETURN || key == ENTER)
      {
        menu = (int) option + 1;
      }
    }
  }
}