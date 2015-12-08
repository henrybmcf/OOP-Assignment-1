//class KinectTracker extends KinectDepth
//{
// int threshold = 625;
// PVector loc;
// PVector lerpedLoc;
// int[] depth;
// PImage display;
   
// KinectTracker()
// {
//   kinect.initDepth();
//   kinect.enableMirror(true);
//   display = createImage(kinect.width, kinect.height, RGB);
//   loc = new PVector(0, 0);
//   lerpedLoc = new PVector(0, 0);
// }

// void track()
// {  
//   depth = kinect.getRawDepth();
//   float sumX = 0;
//   float sumY = 0;
//   float count = 0;

//   for (int x = 0; x < kinect.width; x++)
//   {
//     for (int y = 0; y < kinect.height; y++)
//     { 
//       int offset =  x + y * kinect.width;
//       int rawDepth = depth[offset];
//       if (rawDepth < threshold)
//       {
//         sumX += x;
//         sumY += y;
//         count++;
//       }
//     }
//   }
    
//   if (count != 0)
//       loc = new PVector(sumX/count, sumY/count);

//   lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
//   lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
// }

// PVector getLerpedPos()
// {
//   return lerpedLoc;
// } 

// PVector getPos()
// {
//   return loc;
// }

// void display()
// {
//   PImage img = kinect.getDepthImage();

//   display.loadPixels();
//   for (int x = 0; x < kinect.width; x++)
//   {
//     for (int y = 0; y < kinect.height; y++)
//     {
//       int offset = x + y * kinect.width;
//       int rawDepth = depth[offset];
//       int pix = x + y * display.width;
//       if (rawDepth < threshold)
//       {
//         display.pixels[pix] = color(50, 50, 150);
//       }
//       else
//       {
//         if (kinectColour)
//           display.pixels[pix] = img.pixels[offset];
//         else
//           display.pixels[pix] = color(0);
//       }
//     }
//   }
//   display.updatePixels();
//   image(display, 0, 0);
// }
//}