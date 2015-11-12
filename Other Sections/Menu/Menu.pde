void setup()
{
   size(900, 300);
   background(0);
   stroke(255);
   strokeWeight(2);
   fill(0);
   
   //centX = width * 0.5f;
   //centY = height * 0.5f;
   
   diameter = 200;
   radius = diameter * 0.5f;
   
   x = radius;
   y = height - radius;
   
   segments = 8;
   
   theta = TWO_PI / segments;
   position = 0;
   //thetaPrev = QUARTER_PI/2;
   
   direction = 1;
   
   for(int i = 0; i < segments; i++)
   {
     colour[i] = color(random(255), random(255), random(255));
   }
   
   mode = "none";
  
}

float sum = 0.0f;
float x;
float y;
float diameter;
float radius;
int segments;
float theta;
float thetaPrev;
float thetaNext;
int position;
color[] colour = new color[8];

float direction;

String mode;

void draw()
{
   background(255);
   stroke(255);

   if(x == ((width/(segments+1)) * position) + 100)
   {
     thetaPrev = (position * QUARTER_PI) - (PI * (0.125f * 3.0f));     
   }
  
  //Possibly use switch * case here instead
   if(mode == "none")
   {
     drawWheel();
   }
   
   if(mode == "right")
   {
       thetaPrev = thetaPrev + HALF_PI * 1/42;
       drawWheel();
   }
   
   if(mode == "left")
   {
       thetaPrev = thetaPrev - HALF_PI * 1/42;
       
       drawWheel();
   }
   
    /*
   // Grid lines - To be removed
   stroke(0, 0, 255);
   line(0, height - radius, width, height - radius);
   for(int i = 1; i < 9; i++)
   {
     line(radius * i, 0, radius * i, height);
   }
   // End of grid lines
   */
   
   if(mode == "right")
   {
     if(x < radius * direction)
     {
      x += 5;
     }
     else
     {
       mode = "none";
     }
   }
   if(mode == "left")
   {
     if(x > radius * direction)
     {
      x -= 5;
     }
     else
     {
       mode = "none";
     }
   }
   
   fill(0);
   text("Please use left & right arrows to select item.", 25, 25);
}

void drawWheel()
{ 
   for(int i = 0; i < segments; i++)
   {
     thetaNext = thetaPrev - theta;
     //fill(colour[i]);
     fill(255);
     stroke(0);
     strokeWeight(3);
     
     if(x == ((width/(segments+1)) * position) + 100)
     {
       if(i == position)
       {
         diameter = 245;
         fill(100, 100, 200);
       }
     }
       
     arc(x, y, diameter, diameter, thetaNext, thetaPrev, PIE);
     
     thetaPrev = thetaNext;
     diameter = 200;
   }
}

void keyPressed()
{
   if (key == CODED)
   {
     if (keyCode == RIGHT)
     {
       if(direction < 8)
       {
         direction++;
         position++;
         mode = "right";
       }
       println("right");
     }
     
     if(keyCode == LEFT)
     {
        if(direction > 1)
        {
          direction--;
          position--;
          mode = "left";
        }
        println("left");
     }
   }
}