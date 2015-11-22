void setup()
{
  size(600, 600);
  background(0);
  
  wheel = new Wheel();
  
  mode = 1;
  option = 0.0f;
}

Wheel wheel;

int mode;
float option;
float theta;
float thetaBase;

void keyPressed()
{ 
  if(keyCode > 48  && keyCode < 57)
  {
    println(keyCode);
    mode = keyCode - 48;
    println(mode);
  }    
}

void draw()
{
  background(0);

  switch(mode)
  {
    case 1:
    {
      wheel.render();
      wheel.update();
      break;
    }
    case 2:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    
    case 3:
    {
      wheel.render();
      wheel.update();
      println(mode);
      
      while(PI + HALF_PI - thetaBase > theta * 3 || PI + HALF_PI - thetaBase < theta * 2)
      {
         thetaBase += 0.1f; 
      }
      break;
    }
    
    case 4:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    case 5:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    case 6:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    case 7:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    case 8:
    {
      wheel.render();
      wheel.update();
      println(mode);
    break;
    }
    default:
    {
      text("Error, please select valid option", 100, 50);
      wheel.render();
      wheel.update();
      
      break;
    }
  }

 // stroke(100, 255, 100);s
 stroke(100);
  fill(255);
  strokeWeight(3);
  line(300, 100, 300, 300);
  textAlign(CENTER, CENTER);
  int y = (int) option + 1;
  text("Option Select: " + y, 300, 85);
}