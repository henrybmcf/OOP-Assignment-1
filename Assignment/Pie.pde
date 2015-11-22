class Pie
{
  float radius = width * 0.5f;
  
  
}



void drawPie(float[] dataset)
{
  // Calculate the sum
  float sum = 0.0f;
  for(float f:dataset)
  {
    sum += f;
  }
  
  
  // Calculate the angle to the mouse
  float toMouseX = mouseX - radius;
  float toMouseY = mouseY - radius;  
  float angle = atan2(toMouseY, toMouseX);  
  // We have to do this because 
  // atan2 returns negative angles if y > 0 
  // See https://processing.org/reference/atan2_.html
  if (angle < 0)
  {
    angle = PI - angle;
  }
  
  
  // The last angle
  float last = 0;
  // The cumulative sum of the dataset 
  float cumulative = 0;
  for(int i = 0 ; i < dataset.length ; i ++)
  {
    cumulative += dataset[i];
    // Calculate the surrent angle
    float current = map(cumulative, 0, sum, 0, TWO_PI);
    // Draw the pie segment
    stroke(colors[i]);
    fill(colors[i]);
    
    float r = radius;
    // If the mouse angle is inside the pie segment
    // Mmmm pie. Im hungry
    if (angle > last && angle < current)
    {
      r = radius * 1.5f;
    }
    
    // Draw the arc
    arc(
       radius
       ,radius
       ,r
       ,r
       , last
       , current
       );
    last = current;       
  }
  
  stroke(255);
  line(radius, radius, mouseX, mouseY);
}

void draw()
{
  background(0);
  drawPie(dataset); 
}