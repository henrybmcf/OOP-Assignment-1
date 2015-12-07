class KinectDepth
{
  void update()
  {
    tracker.track();
    tracker.display();
    
    PVector v1 = tracker.getPos();
    PVector v2 = tracker.getLerpedPos();
    fill(100, 250, 50, 200);
    noStroke();
    ellipse((v1.x + v2.x) * 0.5f, (v1.y + v2.y) * 0.5f, 20, 20);

    fill(50, 100, 250, 35);
    rectMode(CORNER);
    float quart = kinect.height * 0.25f;
    float arrowWidth = kinect.width * 0.375f;
    rectMode(CORNERS);
    rect(0, 0, kinect.width, quart);
    rect(1, quart * 1.25f, arrowWidth, kinect.height, 0, 10, 0, 0);
    rect(kinect.width, quart * 1.25f, kinect.width - arrowWidth, kinect.height, 10, 0, 0, 0);

    if (v1.y < quart)
    {
     kinectTime++;
     if (kinectTime >= 60)
     {
       println((int)option + 1);
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
         option += 6;
       if (option > 6)
         option -= 6;
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
       if (option < 6)
         option += 6;
       if (option > 6)
         option -= 6;
     }
    }
    else
    {
       kinectTime = 0;
    }
  }
}