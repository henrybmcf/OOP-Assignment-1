class Wheel
{
  PVector pos;
  int segments = 8;
  float diameter;
  color[] colours = new color[segments];

  Wheel()
  {
    this(width * 0.25f, height  * 0.4f, 300);
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
    for (int i = 0; i < segments; i++)
    {
      fill(colours[i]);
      stroke(colours[i]);
      arc(pos.x, pos.y, diameter, diameter, thetaBase + (theta * i), (thetaBase + (theta * i)) + theta, PIE);
      fill(0);
      stroke(0);
      ellipse(pos.x, pos.y, 20, 20);
    }
    stroke(100);
    fill(255);
    strokeWeight(3);
    line(pos.x, pos.y - diameter * 0.7f, pos.x, pos.y);
    textAlign(CENTER, CENTER);
    text("Option Select: " + ((int)option + 1), pos.x, pos.y - (diameter * 0.8f));
  }

  void update()
  {  
    if (keyPressed)
    {
      if (keyCode == LEFT || keyCode == RIGHT)
      {
        option = ((PI + HALF_PI - thetaBase) / theta);
        if (option < 1)
            option += 8;
        if (option > 8)
            option = option - 8;
      }

      // Turn wheel depending on arrow key pressed
      if (keyCode == LEFT)
      {
        thetaBase -= 0.05f;
        if(thetaBase <= 0.0f)
            thetaBase = TWO_PI;
      }
      if (keyCode == RIGHT)
      {
        thetaBase += 0.05f;
        if (thetaBase >= TWO_PI)
            thetaBase = 0.0f;
      }

      // Go to menu option when return key pressed
      if (key == RETURN || key == ENTER)
            menu = (int) option + 1;
    }
  }
}