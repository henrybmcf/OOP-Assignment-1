void setup()
{
  size(600, 600);
  background(0);
  
  correl = new Correlation();
  
  
  speed = new Speed();
  pie = new Pie();
  bubble = new Bubble();
  wheel = new Wheel();
  menu = 0;
  option = 0.0f;
  sum = 0.0f;
  average = 0.0f;
  
  stages_table = loadTable("stage_wins.csv", "header");
  
  for(TableRow row : stages_table.rows())
  {
    Stages stage = new Stages();
    
    stage.rider = row.getString("Rider");
    stage.number = row.getInt("Wins");
    
    stage_records.add(stage);
  }
  
  for(int i = 0; i < stage_records.size(); i++)
  {
    rider.add(stage_records.get(i).rider);
    wins.add(stage_records.get(i).number);
    float x1 = random(50, width - 50);

    x.add(x1);
  }

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
    speedList.add(years.get(i).speed);
    stages.add(years.get(i).stages);
    
    sum = sum + speedList.get(i);
  }
  
  average = sum / speedList.size();
  
  for(int i = 0; i < 14; i++)
  {
    yearList.add(years.get((i * 5) + 3).tour_year);
  }
  
  // Stage counter
  for(int i = 0; i < stages.size(); i++)
  {
    switch(stages.get(i))
    {
      case 20:
      {
        counter[0]++;
        break;
      }
      case 21:
      {
        counter[1]++;
        break;
      }
      case 22:
      {
        counter[2]++;
        break;
      }
      case 23:
      {
        counter[3]++;
        break;
      }
      case 24:
      {
        counter[4]++;
        break;
      }
      case 25:
      {
        counter[5]++;
        break;
      }
    }
  }
}

Table table;
Wheel wheel;
Speed speed;
Pie pie;
Bubble bubble;
Table stages_table;
Correlation correl;

ArrayList<Year> years = new ArrayList<Year>();
ArrayList<Float> speedList = new ArrayList<Float>();
ArrayList<Integer> yearList = new ArrayList<Integer>();
ArrayList<Integer> stages = new ArrayList<Integer>();
ArrayList<Stages> stage_records = new ArrayList<Stages>();
ArrayList<String> rider = new ArrayList<String>();
ArrayList<Integer> wins = new ArrayList<Integer>();

ArrayList <Float> x = new ArrayList<Float>();

int[] counter = new int[6];
int menu;
float option;
float theta;
float thetaBase;
float average;
float sum;

void draw()
{
  background(0);

  switch(menu)
  {
    case 0:
    {
      wheel.render();
      wheel.update();
      
      stroke(100);
      fill(255);
      strokeWeight(3);
      line(300, 100, 300, 300);
      textAlign(CENTER, CENTER);
      int y = (int) option + 1;
      text("Option Select: " + y, 300, 85);
      
      break;
    }
    
    case 1:
    {
      speed.render();
      break;
    }
    
    case 2:
    {
      pie.update(counter);
      break;
    }

    case 3:
    {
      bubble.render();
      break;
    }

    case 4:
    {
      correl.render();
      break;
    }
    
    case 5:
    {
      /*  
      while(PI + HALF_PI - thetaBase > theta * 3 || PI + HALF_PI - thetaBase < theta * 2)
      {
         thetaBase += 0.1f; 
      }
      */
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
}

void keyPressed()
{
  if (key >= '0' && key <= '9')
  {
    menu = key - '0';
  }
  
  if(key == BACKSPACE)
  {
    menu = 0;
  }
}