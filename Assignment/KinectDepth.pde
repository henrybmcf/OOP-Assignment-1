class KinectDepth
{
  float kinectXCorner;
  float kinectYCorner;
 
  KinectDepth()
  {
    kinectXCorner = (width - kinect.width) * 0.5f;
    kinectYCorner = (height - kinect.height) * 0.5f;
  }
  
  void update()
  {
    background(255);
    
    tracker.track();
    
    if (mode)
    {
      image(kinect.getDepthImage(), kinectXCorner, kinectYCorner);
    }
    else
    {
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
    rect(100, 100, 200, 200);
    if(v1.x > 100 && v2.x > 100 && v1.y > 100 && v2.y > 100 && v1.x < 300 && v2.x < 300 && v1.y < 300 && v2.y < 300)
    {
       text("MENU", width * 0.5f, height * 0.5f);
       kinectTime++;
       if(kinectTime == 60)
           menu = 1;
    }
    else
    {
       kinectTime = 0;
    }
    
    int t = tracker.getThreshold();
    fill(0);
    text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
      "UP increase threshold, DOWN decrease threshold", 10, 500);            
  }
}