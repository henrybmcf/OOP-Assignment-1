void setup()
{
  size(600, 600);
  background(0);
  
  wheel = new Wheel();
  menu = 1;
  option = 0.0f;

  table = loadTable("TDF.csv", "header");

  for (TableRow row : table.rows())
  {
    Year year = new Year();
    
    year.tour_year = row.getInt("Year"); 
    year.tour_length = row.getInt("Length");
    year.stages = row.getInt("Stages");
    year.winner = row.getString("Winner");
    year.speed = row.getFloat("Speed");

    println(year.tour_year + " " + year.tour_length + " " + year.stages + " " + year.winner + " " + year.speed);
    
    years.add(year);
  }
 
  for(int i = 0; i < years.size(); i++)
  {
     speedList.add(years.get(years.size() - (i + 1)).speed); 
  }
  
  for(int i = 0; i < 14; i++)
  {
    yearList.add(years.get(i * 5).tour_year);
  }
  
}

Table table;
ArrayList<Year> years = new ArrayList<Year>();

int mode = 1;

ArrayList<Float> speedList = new ArrayList<Float>();
ArrayList<Integer> yearList = new ArrayList<Integer>();

Wheel wheel;
int menu;
float option;
float theta;
float thetaBase;


void draw()
{
   background(0);

   switch (mode)
   {
      case 1:
      {
        switch(menu)
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
            println(menu);
            mode = 2;
            break;
          }
    
          case 3:
          {
            wheel.render();
            wheel.update();
            println(menu);
            
            /*  
            while(PI + HALF_PI - thetaBase > theta * 3 || PI + HALF_PI - thetaBase < theta * 2)
            {
               thetaBase += 0.1f; 
            }*/
            break;
          }
    
          case 4:
          {
            wheel.render();
            wheel.update();
            println(menu);
          break;
          }
          case 5:
          {
            wheel.render();
            wheel.update();
            println(menu);
          break;
          }
          case 6:
          {
            wheel.render();
            wheel.update();
            println(menu);
          break;
          }
          case 7:
          {
            wheel.render();
            wheel.update();
            println(menu);
          break;
          }
          case 8:
          {
            wheel.render();
            wheel.update();
            println(menu);
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

        stroke(100);
        fill(255);
        strokeWeight(3);
        line(300, 100, 300, 300);
        textAlign(CENTER, CENTER);
        int y = (int) option + 1;
        text("Option Select: " + y, 300, 85);
        break;
      }
        
      case 2:
      {
        float border = width * 0.1f;
        drawAxis(yearList, 10, 50, border);
        stroke(0, 255, 255);
        float windowRange = (width - (border * 2.0f));
        float dataRange = 50;      
        float lineWidth = windowRange / (float)(speedList.size() - 1);
        float scale = windowRange / dataRange;
        
        for(int i = 1; i < speedList.size(); i++)
        {
          float x1 = border + ((i - 1) * lineWidth);
          float x2 = border + (i * lineWidth);
          float y1 = (height - border) - (speedList.get(i - 1)) * scale;
          float y2 = (height - border) - (speedList.get(i)) * scale;
          line(x1, y1, x2, y2);
        }
        break; 
      }
      
      default:
      {
         println("Error, please select vaild option.");
         break;
      }
   }   
}

void drawAxis(ArrayList<Integer> horizLabels, int verticalIntervals, float vertDataRange, float border)
{
  stroke(200, 200, 200);
  fill(200, 200, 200);  
   
  line(border, height - border, width - border, height - border);
  
  float windowRange = (width - (border * 2.0f));  
  float horizInterval =  windowRange / (horizLabels.size() - 1);
  float tickSize = border * 0.1f;
  
  for(int i = 0; i < horizLabels.size(); i++)
  {   
   float x = border + (i * horizInterval);
   line(x, height - (border - tickSize), x, (height - border));
   float textY = height - (border * 0.5f);
   textAlign(CENTER, CENTER);
   text(horizLabels.get(i), x, textY);  
  }

  line(border, border, border, height - border);
  
  float verticalDataGap = vertDataRange / verticalIntervals;
  float verticalWindowRange = height - (border * 2.0f);
  float verticalWindowGap = verticalWindowRange / verticalIntervals; 
  
  for (int i = 0; i <= verticalIntervals; i++)
  {
    float y = (height - border) - (i * verticalWindowGap);
    line(border - tickSize, y, border, y);
    
    float hAxisLabel = verticalDataGap * i;
        
    textAlign(RIGHT, CENTER);  
    text(nf(hAxisLabel, 2, 2), border - (tickSize * 2.0f), y);
  }
}

void keyPressed()
{
  if (key >= '0' && key <= '9')
  {
    mode = key - '0';
  }
  println(mode);
  
  if(keyCode > 48  && keyCode < 57)
  {
    println(keyCode);
    menu = keyCode - 48;
    println(menu);
  }  
}