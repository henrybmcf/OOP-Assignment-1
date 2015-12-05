class KinectDepth
{
  void update()
  {
    tracker.track();
    
    if (mode)
    {
      image(kinect.getDepthImage(), 0, 0);
      tracker.display();
    }
  
    PVector v1 = tracker.getPos();
    fill(50, 100, 250, 200);
    noStroke();
    ellipse(v1.x, v1.y, 20, 20);
    PVector v2 = tracker.getLerpedPos();
    fill(100, 250, 50, 200);
    noStroke();
    ellipse(v2.x, v2.y, 20, 20);
    
    rectMode(CORNER);
    float quart = kinect.height * 0.25f;
    float arrowWidth = kinect.width * 0.375f;
    rectMode(CORNERS);
    rect(0, 0, kinect.width, quart);
    rect(0, quart * 1.25f, arrowWidth, kinect.height);
    rect(kinect.width, quart * 1.25f, kinect.width - arrowWidth, kinect.height);
    
    if (v1.y < quart)
    {
      text("SELECT", -100, -60);
    }
    else if (v1.x < arrowWidth && v1.y > quart * 1.25f)
    {
      text("LEFT", -100, -100);
      kinectTime++;
      if(kinectTime >= 60)
      {
        thetaBase -= 0.05f;
        if (thetaBase <= 0.0f)
             thetaBase = TWO_PI;
        option = ((PI + HALF_PI - thetaBase) / theta);
        if (option < 1)
             option += 8;
        if (option > 8)
             option = option - 8;
      }
    }
   else if(v1.x > kinect.width - arrowWidth && v1.y > quart * 1.25f)
   {
      text("RIGHT", -100, -80);
      kinectTime++;
      if(kinectTime >= 60)
      {
        thetaBase += 0.05f;
        if (thetaBase >= TWO_PI)
             thetaBase = 0.0f;
        option = ((PI + HALF_PI - thetaBase) / theta);
        if (option < 1)
             option += 8;
        if (option > 8)
             option = option - 8;
      }
   }
   else
   {
     kinectTime = 0;
   }   
    
    //if (keyCode == LEFT || keyCode == RIGHT)
    //  {
    //    option = ((PI + HALF_PI - thetaBase) / theta);
    //    if (option < 1)
    //        option += 8;
    //    if (option > 8)
    //        option = option - 8;
    //  }

    //  // Turn wheel depending on arrow key pressed
    //  if (keyCode == LEFT)
    //  {
    //    thetaBase -= 0.05f;
    //    if(thetaBase <= 0.0f)
    //        thetaBase = TWO_PI;
    //  }
    //  if (keyCode == RIGHT)
    //  {
    //    thetaBase += 0.05f;
    //    if (thetaBase >= TWO_PI)
    //        thetaBase = 0.0f;
    //  }
  }
}