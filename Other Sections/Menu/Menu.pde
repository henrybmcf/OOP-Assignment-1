void setup()
{
   size(700, 300);
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
   thetaPrev = QUARTER_PI/2;
   
   direction = 1;
   
   for(int i = 0; i < segments; i++)
   {
     colour[i] = color(random(255), random(255), random(255));
   }
}

float sum = 0.0f;
float x;
float y;
float diameter;
float radius;
int segments;
float theta;
float thetaPrev;
int position;
color[] colour = new color[8];

float direction;

void draw()
{
   background(0);
   stroke(255);
  
   thetaPrev = (position * QUARTER_PI) + QUARTER_PI/2;
   
   for(int i = 0; i < segments; i++)
   {
     float thetaNext = thetaPrev + theta;
     stroke(colour[i]);
     arc(x, y, diameter, diameter, thetaPrev, thetaNext, PIE);
     
     thetaPrev = thetaNext;
   }
   
   // Grid lines - To be removed
   stroke(0, 0, 255);
   line(0, height - radius, width, height - radius);
   for(int i = 1; i < 7; i++)
   {
     line(radius * i, 0, radius * i, height);
   }
   // End of grid lines
}


void keyPressed()
{
   if (key == CODED)
   {
     if (keyCode == RIGHT)
     {
       if(direction < 6)
       {
         direction++;
         position++;
       }
       
       println("right");
       x = radius * direction;
     }
     
     if(keyCode == LEFT)
     {
        if(direction > 1)
        {
          direction--;
          position--;
        }
        println("left");
        x = radius * direction;
     }
   }
  
}