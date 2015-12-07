class Wheel
{
  PVector pos;
  int segments = 8;
  float diameter;
  //color[] colours = new color[segments];

  Wheel()
  {
    this(width * 0.367f, height  * 0.321f, 220);
  }

  Wheel(float x, float y, float diameter)
  {
    pos = new PVector(x, y);
    this.diameter = diameter;
    theta = TWO_PI / segments;
    thetaBase = 0.0f;//PI + HALF_PI;
    //colours[0] = color(170, 0, 0);
    //colours[1] = color(0, 170, 0);
    //colours[2] = color(0, 0, 170);
    //colours[3] = color(200, 200, 0);
    //colours[4] = color(200, 0, 200);
    //colours[5] = color(0, 200, 200);
    //colours[6] = color(100, 100, 255);
    //colours[7] = color(200, 255, 200);
  }

  void render()
  {
    stroke(100); 
    for (int i = 0; i < segments; i++)
    {
      fill(0);
      strokeWeight(5);
      if((int)option == i)
        fill(255);  
      arc(pos.x, pos.y, diameter, diameter, thetaBase + (theta * i), thetaBase + (theta * i) + theta, PIE);
    }
    
    fill(255);
    strokeWeight(3);
    textAlign(LEFT, CENTER);
    if(option != 0)
      text("Option Select: " + ((int)option + 1), pos.x + diameter * 0.7f, pos.y);
    else
      text("Option Select: " + ((int)option), pos.x + diameter * 0.7f, pos.y);
    
    textAlign(LEFT);
    text("Option List\n1 = Speed trend graph\n2 = Stages pie chart\n3 = Record stage wins bubble graph\n4 = Correlation graph, speed, stages and lengths", 100, height - 200);
  }

  void update()
  {   
    if (keyPressed)
    {
      if (keyCode == LEFT || keyCode == RIGHT)
      {
        option = -thetaBase / theta;// (PI + HALF_PI - thetaBase) / theta;
        if (option < 1)
            option += 8;
        if (option > 8)
            option -= 8;
      }

      // Turn wheel depending on arrow key pressed
      if (keyCode == LEFT)
      {
        thetaBase -= 0.04f;
        if(thetaBase <= 0.0f)
           thetaBase = TWO_PI;
      }
      if (keyCode == RIGHT)
      {
        thetaBase += 0.04f;
        if (thetaBase >= TWO_PI)
            thetaBase = 0.0f;
      }

      // Go to menu option when return key pressed
      if (key == RETURN || key == ENTER)
        menu = (int) option + 1;
    }
  }
}