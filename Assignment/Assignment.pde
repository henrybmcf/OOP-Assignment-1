import java.util.*;
import ddf.minim.*;
//import org.openkinect.freenect.*;
//import org.openkinect.processing.*;

void setup()
{  
  //size(640, 520);
  fullScreen();
  smooth(8);
  textSize(20);

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
  for (int i = 0; i < years.size(); i++)
  {
    yearList.add(years.get(i).tour_year);
    speedList.append(years.get(i).speed);
    stages.add(years.get(i).stages);
    lengths.add(years.get(i).tour_length);
  }

  stages_table = loadTable("StageWins.csv", "header");
  for (TableRow row : stages_table.rows())
  {
    Stages stage = new Stages();
    stage.rider = row.getString("Rider");
    stage.number = row.getInt("Wins");
    stage_records.add(stage);
  } 
  for (int i = 0; i < stage_records.size(); i++)
  {
    rider.add(stage_records.get(i).rider);
    wins.add(stage_records.get(i).number);
    stageY.add(random(150, height * 0.8f));
  }

  countryWins = loadTable("CountryWins.csv", "header");
  for (TableRow row : countryWins.rows())
  {
    countryWins countryWin = new countryWins();
    countryWin.country = row.getString("Country");
    countryWin.number = row.getInt("Wins");
    countryRecords.add(countryWin);
  }
  for (int i = 0; i < countryRecords.size(); i++)
  {
    cWins.add(countryRecords.get(i).number);
    country.add(countryRecords.get(i).country);
    float cX = random(width * 0.8f);
    countryX.add(cX);
  }

  for (int i = 0; i < correlation.length; i++)
    correlation[i] = false;

  // Add all elements into IntList for sorting
  for (int i : stages)
    stageCountSort.append(i);
  stageCountSort.sort();

  // For each repition of number of stages, add 1 to that counter element
  // For each different number of stages, append new element to counter
  // This allows for dynamic number of stages
  counter.append(1);
  int j = 0;
  for (int i = 1; i < stageCountSort.size(); i++)
  {
    if (stageCountSort.get(i) == stageCountSort.get(i - 1))
    {
      counter.add(j, 1);
    }
    else
    {
      counter.append(1);
      j++;
    }
  }
  // Remove all elements from sorted list to save memory
  stageCountSort.clear();

  //kinect = new Kinect(this);
  //depth = new KinectDepth();
  //tracker = new KinectTracker();
  //kinect.initDepth();
  //kinect.enableColorDepth(true);  
  minim = new Minim(this);
  wheel = new Wheel();
  ssl_correl = new Spd_Stg_Len_Correl();
  speed = new Speed();
  pie = new Pie();
  bubble = new Bubble();

  menu = 0;
  option = 0.0f;
  sum = 0.0f;
  average = 0.0f;
  bubbleGraph = "Rider";
  mirror = false;
  kinectColour = true;
  kinectTime = 0;
  legend = false;
  font = createFont("Aspex.ttf", 15); 
  textFont(font);
  bike = loadImage("Bike.png");
}

ArrayList<Year> years = new ArrayList<Year>();
ArrayList<Integer> yearList = new ArrayList<Integer>();
FloatList speedList = new FloatList();
ArrayList<Integer> stages = new ArrayList<Integer>();
ArrayList<Stages> stage_records = new ArrayList<Stages>();
ArrayList<String> rider = new ArrayList<String>();
ArrayList<Integer> wins = new ArrayList<Integer>();
ArrayList<Float> stageY = new ArrayList<Float>();
ArrayList<Integer> lengths = new ArrayList<Integer>();
ArrayList<Float> countryX = new ArrayList<Float>();
ArrayList<countryWins> countryRecords = new ArrayList<countryWins>();
ArrayList<Integer> cWins = new ArrayList<Integer>();
ArrayList<String> country = new ArrayList<String>();
IntList stageCountSort = new IntList();
IntList counter = new IntList();
boolean[] correlation = new boolean[3];
String[] correlationID = new String[3];

Table table;
Table stages_table;
Table countryWins;
//Kinect kinect;
//KinectDepth depth;
//KinectTracker tracker;
Minim minim;
Wheel wheel;
Spd_Stg_Len_Correl ssl_correl;
Speed speed;
Pie pie;
Bubble bubble;

int menu;
float option;
float theta;
float thetaBase;
float average;
float sum;
String bubbleGraph;
boolean mirror;
int kinectTime;
boolean kinectColour;
boolean legend;
PFont font;
PImage bike;

void draw()
{
  background(0);
 
  switch(menu)
  {
   case 0:
     //pushMatrix();
     //translate(width - kinect.width - 2, height - kinect.height - 2);
     //depth.update();
     //popMatrix();

     wheel.render();
     wheel.update();
     image(bike, 0, 0);
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
      ssl_correl.render();
      break;
    case 5:
      break;
    case 6:
      break;
  
    default:
     text("Error, please select valid option", 100, 50);
     wheel.render();
     wheel.update();
     break;
  }

  if (legend)
    showKey();
}

void showKey()
{
  float boxWidth = width * 0.6f;
  float boxHeight = height * 0.8f;
  float halfWidth = boxWidth * 0.5f;
  background(0);
  fill(255);
  textSize(150);
  textAlign(CENTER);
  pushMatrix();
  translate(0, height);
  rotate(PI + HALF_PI);
  text("KEY", height * 0.5f, 200);
  popMatrix();
  fill(230, 200, 100);
  stroke(0);
  pushMatrix();
  translate(width * 0.2f, boxHeight * 0.125f);
  rectMode(CORNER);
  rect(0, 0, boxWidth, boxHeight, 30);
  textLeading(30);
  fill(0);
  textSize(18);
  strokeWeight(2);
  switch (menu)
  {
    case 0:
      text("KeyBoard Selection", halfWidth, 60);
      line(halfWidth/2, 70, boxWidth - halfWidth/2, 70);
      text("Kinect Selection", halfWidth, 355);
      line(halfWidth/2, 365, boxWidth - halfWidth/2, 365);
      textSize(15);
      text("Right Arrow - Turn wheel right\nLeft Arrow - Turn wheel left\nEnter - Select highlighted option\nNumber Keys - Jump to corresponding graph\nBackspace - Return to menu from any graph", halfWidth, 110);
      text("Hover Right box - Turn wheel right\nHover Left Box - Turn wheel left\nHover Top Box - Select highliighted option\nC - Swap between rgb depth scale and black kinect window", halfWidth, 405);
      textLeading(27);
      text("Kinect will only register objects within depth threshold,\nthat is any objects that are coloured blue", halfWidth, 580);
      break;
    case 4:
      text("Speed Graph", halfWidth, 60);
      line(halfWidth/2, 70, boxWidth - halfWidth/2, 70);
      text("Stages Graph", halfWidth, 260);
      line(halfWidth/2, 270, boxWidth - halfWidth/2, 270);
      text("Length Graph", halfWidth, 460);
      line(halfWidth/2, 470, boxWidth - halfWidth/2, 470);
      textSize(15);
      textLeading(28);
      text("S - Show/Hide\nW - Trend\nA - Scatter\nD - Lightweight Trend & Scatter combo", halfWidth, 110);
      text("T - Show/Hide\nG - Trend\nR - Scatter\nY - Lightweight Trend & Scatter combo", halfWidth, 310);
      text("L - Show/Hide\nI - Trend\nO - Scatter\nP - Lightweight Trend & Scatter combo", halfWidth, 510);
      break;
  }
  popMatrix();
}

void keyPressed()
{
  //if (key == ' ')
  // exit();

  if (key == 'k')
    legend = true;

  if (key >= '0' && key <= '9')
    menu = key - '0';

  if (key == BACKSPACE)
    menu = 0;

  switch(menu)
  {
    case 0:
      if (key == 'c')
        kinectColour =! kinectColour;
      break;
    case 3:
      if (key == 'c')
        bubbleGraph = "Country";
      if (key == 'r')
        bubbleGraph = "Rider";
      break;
    case 4:
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
        case 'o':
          correlationID[2] = "Trend";
          break;
        case 'p':
          correlationID[2] = "Scatter";
          break;
      } 
      break;
  }
}

void keyReleased()
{
  if (key == 'k')
    legend = false;
}