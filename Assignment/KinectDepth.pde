class KinectDepth
{
  void update()
  {
    // Call kinect tracking function
    tracker.track();
    tracker.display();
    
    // PVectors for tracking average depth, display cirlce on screen
    PVector v1 = tracker.getPos();
    PVector v2 = tracker.getLerpedPos();
    fill(100, 250, 50, 200);
    noStroke();
    ellipse((v1.x + v2.x) * 0.5f, (v1.y + v2.y) * 0.5f, 20, 20);

    // Draw rectangles in kinect width to show user where to hover to turn wheel anad to select menu option
    fill(50, 100, 250, 35);
    rectMode(CORNER);
    float quart = kinect.height * 0.25f;
    float arrowWidth = kinect.width * 0.375f;
    rectMode(CORNERS);
    // Select rectangle
    rect(0, 0, kinect.width, quart);
    // Turn left rectangle
    rect(1, quart * 1.25f, arrowWidth, kinect.height, 0, 10, 0, 0);
    // Turn right rectangle
    rect(kinect.width, quart * 1.25f, kinect.width - arrowWidth, kinect.height, 10, 0, 0, 0);
    
    // Detect where average depth tracking ellipse is in relation to selection and turn rectangles
    // If within, reach time limit (1 second for selection, half a second for turning) and execute relevant command
    if (v1.y < quart)
    {
      kinectTime++;
      if (kinectTime >= 60)
      {
        menu = (int) option + 1;
        kinectTime = 0;
      }
    }
    else if (v1.x < arrowWidth && v1.y > quart * 1.25f)
    {
      kinectTime++;
      if (kinectTime >= 30)
      {
        thetaBase -= 0.04f;
        if (thetaBase <= 0.0f)
          thetaBase = TWO_PI;
        option = (HALF_PI - thetaBase) / theta;
        if (option < 1)
          option += 4;
        if (option > 4)
          option -= 4;
      }
    }
    else if (v1.x > kinect.width - arrowWidth && v1.y > quart * 1.25f)
    {
      kinectTime++;
      if (kinectTime >= 30)
      {
        thetaBase += 0.04f;
        if (thetaBase >= TWO_PI)
          thetaBase = 0.0f;
        option = (HALF_PI - thetaBase) / theta;
        if (option < 1)
          option += 4;
        if (option > 4)
          option -= 4;
      }
    }
    else
    {
      kinectTime = 0;
    }
  }
}