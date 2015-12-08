class KinectTracker extends KinectDepth
{
  int threshold;
  // Raw and interpreted location, will be used to find best average of subject location within frame
  PVector loc;
  PVector lerpedLoc;
  // Values of depths to subject
  int[] depth;
  // Image to display to user
  PImage display;

  KinectTracker()
  {
    kinect.initDepth();
    kinect.enableMirror(true);
    // Blank image ready for depth data
    display = createImage(kinect.width, kinect.height, RGB);
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
    threshold = 635;
  }

  void track()
  {  
    // Raw depth data
    depth = kinect.getRawDepth();
    float sumX = 0;
    float sumY = 0;
    float count = 0;
    // Initiliase kinect image
    for (int x = 0; x < kinect.width; x++)
    {
      for (int y = 0; y < kinect.height; y++)
      { 
        int offset =  x + y * kinect.width;
        int rawDepth = depth[offset];
        if (rawDepth < threshold)
        {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // Making sure there is something within frame
    if (count != 0)
      loc = new PVector(sumX/count, sumY/count);

    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  PVector getLerpedPos()
  {
    return lerpedLoc;
  } 

  PVector getPos()
  {
    return loc;
  }

  void display()
  {
    PImage img = kinect.getDepthImage();

    display.loadPixels();
    // Loop through each pixel of kinect image, determine if within depth threshold or not
    // Write onto depth image
    for (int x = 0; x < kinect.width; x++)
    {
      for (int y = 0; y < kinect.height; y++)
      {
        int offset = x + y * kinect.width;
        int rawDepth = depth[offset];
        int pix = x + y * display.width;
        // If subject is within depth threshold, show in blue
        if (rawDepth < threshold)
        {
          display.pixels[pix] = color(50, 50, 150);
        }
        // If subject is not within depth threshold, show either in RGB or just as black, depending on user selection
        else
        {
          if (kinectColour)
            display.pixels[pix] = img.pixels[offset];
          else
            display.pixels[pix] = color(0);
        }
      }
    }
    display.updatePixels();
    image(display, 0, 0);
  }
}