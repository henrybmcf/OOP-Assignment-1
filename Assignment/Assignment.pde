// Import libraries for inserting images into sketch & for kinect
import ddf.minim.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

void setup()
{
  fullScreen();
  smooth(8);
  textSize(20);

  // Load main data table, list of years, speeds, stages and lengths 
  table = loadTable("TDF.csv", "header");
  // For each row of the table, retrieve the value within the column named "Year", "Speed", etc.
  for (TableRow row : table.rows())
  {
    Year year = new Year();
    year.tour_year = row.getInt("Year"); 
    year.speed = row.getFloat("Speed");
    year.stages = row.getInt("Stages");
    year.tour_length = row.getInt("Length");
    years.add(year);
  }
  for (int i = 0; i < years.size(); i++)
  {
    yearList.append(years.get(i).tour_year);
    speedList.append(years.get(i).speed);
    stages.append(years.get(i).stages);
    lengths.append(years.get(i).tour_length);
  }

  // Load rider stage win records
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
    wins.append(stage_records.get(i).number);
    // Set random value for y coordinates of each bubble for rider stage wins record bubble graph
    stageY.append(random(150, height * 0.8f));
  }

  // Load country stage win records
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
    country.add(countryRecords.get(i).country);
    cWins.append(countryRecords.get(i).number);
    // Set random value for x coordinates of each bubble for country stage wins record bubble graph
    countryX.append(random(width * 0.8f));
  }

  // Set all correlation graphs to be false, so user can select which ones to show
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

  kinect = new Kinect(this);
  depth = new KinectDepth();
  tracker = new KinectTracker();
  kinect.initDepth();
  kinect.enableColorDepth(true);  
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
  kinectColour = true;
  kinectTime = 0;
  legend = false;
  font = createFont("Aspex.ttf", 15); 
  textFont(font);
  bike = loadImage("Bike.png");
  yearInfo = false;
}

// Int and FloatLists for general data: years, speeds, stages & lengths.
ArrayList<Year> years = new ArrayList<Year>();
IntList yearList = new IntList();
FloatList speedList = new FloatList();
IntList stages = new IntList();
IntList lengths = new IntList();
// String ArrayList for names of riders/countries, IntList for number of stage wins and FloatList for random x/y coordinates for bubble graphs
ArrayList<Stages> stage_records = new ArrayList<Stages>();
ArrayList<String> rider = new ArrayList<String>();
IntList wins = new IntList();
FloatList stageY = new FloatList();
ArrayList<countryWins> countryRecords = new ArrayList<countryWins>();
ArrayList<String> country = new ArrayList<String>();
IntList cWins = new IntList();
FloatList countryX = new FloatList();
// IntLists for counting number of stages
IntList stageCountSort = new IntList();
IntList counter = new IntList();
// Boolean array for determining whether to show or hide each of the correlation graphs
boolean[] correlation = new boolean[3];
// String array for determining which type of graph to show for each of the correlation graphs
String[] correlationID = new String[3];

Table table;
Table stages_table;
Table countryWins;
Kinect kinect;
KinectDepth depth;
KinectTracker tracker;
Minim minim;
Wheel wheel;
Spd_Stg_Len_Correl ssl_correl;
Speed speed;
Pie pie;
Bubble bubble;

// Menu and option for graph selection
int menu;
float option;
// theta and thetaBase for drawing menu wheel
float theta;
float thetaBase;
// Average and Sum used for finding average of speeds
float average;
float sum;
// For determining which bubble graph to show: rider or country
String bubbleGraph;
// Kinect variables
// Timing how long user is hovering over turning and selection rectangles
int kinectTime;
// Showing kinect image in RGB values depending on depth, or black with only matter within depth threshold being shown
boolean kinectColour;
// Boolean to determine whether to show legend or not
boolean legend;
// Allow custom font to be read in
PFont font;
// Allow bike image on menu page to be read in
PImage bike;
// Determine whether to show year information on correlation graph
boolean yearInfo;

void draw()
{
  background(0);

  // Switch case for menu option
  switch (menu)
  {
    // Load menu page
    case 0:
      // Show Kinect image,
      pushMatrix();
      translate(width - kinect.width - 2, height - kinect.height - 2);
      depth.update();
      popMatrix();
      // Wheel menu selection
      wheel.render();
      wheel.update();
      // Bike image
      image(bike, 0, 0);
      break;
    
    // Load speed graph
    case 1:
      correlationID[0] = "Trend";
      speed.render();
      break;
    
    // Load stage frequency pie chart
    case 2:
      pie.update();
      break;
   
    // Load stage win records bubble graphs
    case 3:
      bubble.render();
      break;
    
    // Load 3 way correlation graph
    case 4:
      ssl_correl.render();
      break;
  }

  // Show legend when boolean variable legend is true (when K key is being held down)
  if (legend)
    showKey();
}

// Show legend
void showKey()
{
  // Size of legend box
  float boxWidth = width * 0.6f;
  float boxHeight = height * 0.8f;
  float halfWidth = boxWidth * 0.5f;
  background(0);
  fill(255);
  textSize(150);
  textAlign(CENTER);
  // Rotate and show Key to side of box
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
  // Display relevant information for legend of each graph - What happens when keys are pressed, show more in depth information
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
    
    case 3:
      if (bubbleGraph == "Rider")
      {
        text("Rider Record Stats", halfWidth, 60);
        line(halfWidth/2, 70, boxWidth - halfWidth/2, 70);
        for (int i = 0; i < rider.size(); i+=2)
          text(rider.get(i) + " = " + wins.get(i), halfWidth / 2, (i * 17) + 110);
        for (int i = 1; i < rider.size(); i+=2)
          text(rider.get(i) + " = " + wins.get(i), halfWidth * 1.5, (i - 1) * 17 + 110);
      } else if (bubbleGraph == "Country")
      {
        text("Country Record Stats", halfWidth, 60);
        line(halfWidth/2, 70, boxWidth - halfWidth/2, 70);
        for (int i = 0; i < country.size(); i++)
          text(country.get(i) + " = " + cWins.get(i), halfWidth, (i * 30) + 110);
      }
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
      text("T - Show/Hide\nR - Trend\nG - Scatter\nY - Lightweight Trend & Scatter combo", halfWidth, 310);
      text("L - Show/Hide\nO - Trend\nP - Scatter\nI - Lightweight Trend & Scatter combo", halfWidth, 510);
      break;
  }
  popMatrix();
}

void keyPressed()
{
  // Switch to relevant graph when number key pressed
  if (key >= '0' && key <= '4')
    menu = key - '0';

  // Return to menu when backspace pressed
  if (key == BACKSPACE)
    menu = 0;
  
  // Display legend if on certain graphs
  if (menu == 0 || menu == 3 || menu == 4)
    if (key == 'k')
      legend = true;

  // For each graph, certain keys will have different effects/outcomes
  switch(menu)
  {
    case 0:
      // Change whether kinect image shows depth via RGB or not
      if (key == 'c')
        kinectColour =! kinectColour;
      break;
    case 3:
      // Switch between Rider and Country bubble graphs
      if (key == 'r')
        bubbleGraph = "Rider";
      if (key == 'c')
        bubbleGraph = "Country";
      break;
    case 4:
      switch(key)
      {
        // Show/Hide year informatio 
        case 'h':
          yearInfo =! yearInfo; 
          break;
    
        // Show/Hide correlation graphs and change relevant graphs to different types
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
  // Hide legend
  if (key == 'k')
    legend = false;
}