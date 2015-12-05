import java.util.*;
import ddf.minim.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
KinectTracker tracker;
Kinect kinect;

boolean colorDepth = true;
boolean mirror = false;
boolean mode = true;

void setup()
{  
  //size(640, 520);
  fullScreen();
  //background(0);
  smooth(8);
  textSize(20);
  
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  kinect.initDepth();
  kinect.enableColorDepth(colorDepth);
  
  ssl_correl = new Spd_Stg_Len_Correl();
  speed = new Speed();
  pie = new Pie();
  bubble = new Bubble();
  wheel = new Wheel();
  minim = new Minim(this);
  menu = 6;
  option = 0.0f;
  sum = 0.0f;
  average = 0.0f;
  bubbleGraph = "Rider";
  
  kinectTime = 0;
  kinectDepth = new KinectDepth();
  
  table = loadTable("TDF.csv", "header");
  for (TableRow row : table.rows())
  {
    Year year = new Year();
    year.tour_year = row.getInt("Year"); 
    year.tour_length = row.getInt("Length");
    year.stages = row.getInt("Stages");
    year.winner = row.getString("Winner");
    year.speed = row.getFloat("Speed");
    years.add(year);
  }
  for(int i = 0; i < years.size(); i++)
  {
    yearList.add(years.get(i).tour_year);
    speedList.append(years.get(i).speed);
    stages.add(years.get(i).stages);
    lengths.add(years.get(i).tour_length);
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
  
  for(int i = 0; i < correlation.length; i++)
      correlation[i] = false;
  
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
Table stages_table;
Table countryWins;
Wheel wheel;
Speed speed;
Pie pie;
Bubble bubble;
Spd_Stg_Len_Correl ssl_correl;
Minim minim;

KinectDepth kinectDepth;

ArrayList<Year> years = new ArrayList<Year>();
ArrayList<Integer> yearList = new ArrayList<Integer>();
FloatList speedList = new FloatList();
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
String[] correlationID = new String[3];
String bubbleGraph;

int kinectTime;

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
      correlationID[0] = "Trend";
      speed.render();
      break;
    case 2:
      pie.update();
      break;
    case 3:
      bubble.render();
      break;
    case 4:
      break;
    
    case 5:
      ssl_correl.render();
      break;
    
    case 6:
    {
      pushMatrix();
      //translate((width - kinect.width) * 0.5f, (height - kinect.height) * 0.5f);
      translate(width - kinect.width, height - kinect.height - 50);
      kinectDepth.update();
      popMatrix();
      
      wheel.render();
      wheel.update();
      break;
    }
    
    /*  
      while(PI + HALF_PI - thetaBase > theta * 3 || PI + HALF_PI - thetaBase < theta * 2)
      {
         thetaBase += 0.1f; 
      }
      */ 
     
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
     menu = key - '0';
  
  if(key == BACKSPACE)
     menu = 0;
  
  switch(menu)
  {
    case 3:
      if(key == 'c')
          bubbleGraph = "Country";
      if(key == 'r')
          bubbleGraph = "Rider";
      break;
    case 5:
      switch(key)
      {
        case 's':
          correlation[0] =! correlation[0];
          correlationID[0] = "Trend";
          break;
        case 'w':
          correlationID[0] = "Trend";
          break;
        case 'a':
          correlationID[0] = "Scatter";
          break;
        case 'd':
          correlationID[0] = "scatterTrend";
          break;
        
        case 't':
          correlation[1] =! correlation[1];
          correlationID[1] = "Scatter";
          break;
        case 'g':
          correlationID[1] = "Scatter";
          break;
        case 'r':
          correlationID[1] = "Trend";
          break;
        case 'y':
          correlationID[1] = "scatterTrend";
          break;
        
        case 'l':
          correlation[2] =! correlation[2];
          correlationID[2] = "scatterTrend";
          break;
        case 'i':
          correlationID[2] = "scatterTrend";
          break;
        case 'j':
          correlationID[2] = "Trend";
          break;
        case 'k':
          correlationID[2] = "Scatter";
          break;
      } 
      break;
    case 6:
      if (key == 'c')
          mode =! mode;
      break;
  }
}