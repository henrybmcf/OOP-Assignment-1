import java.util.*;
import ddf.minim.*;

void setup()
{
  minim = new Minim(this);
  //size(900, 700);
  fullScreen();
  background(0);
  smooth(9);
  
  ssl_correl = new Spd_Stg_Len_Correl();
  
  speed = new Speed();
  pie = new Pie();
  bubble = new Bubble();
  wheel = new Wheel();
  menu = 0;
  option = 0.0f;
  sum = 0.0f;
  average = 0.0f;
  
  graph = 1;
  
  countryWins = loadTable("CountryWins.csv", "header");

  for(TableRow row : countryWins.rows())
  {
    countryWins countryWin = new countryWins();
    countryWin.country = row.getString("Country");
    countryWin.number = row.getInt("Wins");
    countryRecords.add(countryWin);
  }
 
  for(int i = 0; i < countryRecords.size(); i++)
  {
    cWins.add(countryRecords.get(i).number);
    country.add(countryRecords.get(i).country);
    float x1 = random(width - (i + 1) * 50, width - (i + 1) * 130);
    country_x.add(x1);
  }
  
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
    stage_x.add(x1);
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

    //println(year.tour_year + " " + year.tour_length + " " + year.stages + " " + year.winner + " " + year.speed); 
    years.add(year);
  }
 
  for(int i = 0; i < years.size(); i++)
  {
    speedList.add(years.get(i).speed);
    stages.add(years.get(i).stages);
    lengths.add(years.get(i).tour_length);
    
    sum += speedList.get(i);
  }
  
  average = sum / speedList.size();
  
  for(int i = 0; i < 14; i++)
  {
    yearList.add(years.get((i * 5) + 3).tour_year);
  }
  
  for(int i = 0; i < correlation.length; i++)
  {
    correlation[i] = false;
  }
  
  // Stage counter
  for(int i:stages)
  {
    switch(i)
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
Spd_Stg_Len_Correl ssl_correl;
Table countryWins;

ArrayList<Year> years = new ArrayList<Year>();
ArrayList<Integer> yearList = new ArrayList<Integer>();
ArrayList<Float> speedList = new ArrayList<Float>();
ArrayList<Integer> stages = new ArrayList<Integer>();
ArrayList<Stages> stage_records = new ArrayList<Stages>();
ArrayList<String> rider = new ArrayList<String>();
ArrayList<Integer> wins = new ArrayList<Integer>();
ArrayList<Float> stage_x = new ArrayList<Float>();
ArrayList<Integer> lengths = new ArrayList<Integer>();
ArrayList<Float> country_x = new ArrayList<Float>();
ArrayList<countryWins> countryRecords = new ArrayList<countryWins>();
ArrayList<Integer> cWins = new ArrayList<Integer>();
ArrayList<String> country = new ArrayList<String>();

int[] counter = new int[6];
int menu;
float option;
float theta;
float thetaBase;
float average;
float sum;

boolean[] correlation = new boolean[3];
int[] correlationID = new int[3];

int graph;

Minim minim;

void draw()
{
  background(0);

  switch(menu)
  {
    case 0:
      wheel.render();
      wheel.update();
      break;
    case 1:
      speed.render();
      break;
    case 2:
      pie.update(counter);
      break;
    case 3:
      bubble.render();
      break;
    case 4:
    {
      break;
    }
    
    case 5:
      ssl_correl.render();
      break;
    
    case 6:
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
      text("Error, please select valid option", 100, 50);
      wheel.render();
      wheel.update();
      break;
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
  
  if(menu == 1)
    correlationID[0] = 1;
    
  if(menu == 3)
  {
    if(key == 'c')
        graph = 1;
    if(key == 'r')
        graph = 2;
  }   
  
  if(menu == 5)
  {
    switch(key)
    {
      case 's':
      {
        correlation[0] =! correlation[0];
        correlationID[0] = 1;
        break;
      }
      case 'w':
      {
        correlationID[0] = 1;
        break;
      }
      case 'a':
      {
        correlationID[0] = 2;
        break;
      }
      case 'd':
      {
        correlationID[0] = 3;
        break;
      }
      
      case 't':
      {
        correlation[1] =! correlation[1];
        correlationID[1] = 2;
        break;
      }
      case 'g':
      {
        correlationID[1] = 2;
        break;
      }
      case 'r':
      {
        correlationID[1] = 1;
        break;
      }
      case 'y':
      {
        correlationID[1] = 3;
        break;
      }
      
      case 'l':
      {
        correlation[2] =! correlation[2];
        correlationID[2] = 3;
        break;
      }
      case 'i':
      {
        correlationID[2] = 3;
        break;
      }
      case 'j':
      {
        correlationID[2] = 1;
        break;
      }
      case 'k':
      {
        correlationID[2] = 2;
        break;
      }
    } 
  }
}