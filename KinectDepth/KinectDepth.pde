import org.openkinect.freenect.*;
import org.openkinect.processing.*;

KinectTracker tracker;
Kinect kinect;

boolean colorDepth = true;
boolean mirror = false;
boolean mode = true;

void setup() {
  size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  kinect.initDepth();
  kinect.enableColorDepth(colorDepth);
}

void draw()
{
  background(255);

  tracker.track();
  if (mode)
  {
    image(kinect.getDepthImage(), 0, 0);
  } else
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

  rect(100, 100, 200, 200);
  if (v1.x > 100 && v2.x > 100 && v1.y > 100 && v2.y > 100 && v1.x < 300 && v2.x < 300 && v1.y < 300 && v2.y < 300)
  {
    text("MENU", width * 0.5f, height * 0.5f);
  }

  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
  if (key == 'c')
  {
    mode =! mode;
  }
}