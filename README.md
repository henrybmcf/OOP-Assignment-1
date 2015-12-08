#Object Orientated Programming Assignment
###Data Visualisation

Project visualising data from the Tour de France (TdF).
TdF data taken from 1947 - 2015. Various data found across multiple sites used to create a single csv file.

###Data includes:
- Length of tour
- Number of stages
- Average speed (of winner)
- Stage wins records per
	- Rider
	- Country

###Menu:

- Wheel menu visualised as bicycle wheel, with each two sections between spokes as a menu option
	- Use Left and Right arrow keys to rotate wheel and highlight new option
	- Use Enter key to select highlighted option
- Kinect window to allow user to rotate wheel and select option with motion captured by Kinect
	- Kinect depth image can be displayed as RGB or as black for out of depth threshold
	
![Menu - RGB Kinect](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Menu%20-%20RGB%20Kinect.png)
![Menu - Dark Kinect](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Menu%20-%20Dark%20Kinect.png)

   * Legend available by pressing K to show user the necessary keys and motions
 
![Menu Key](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Menu%20Key.png)

##Graphs/Visualisation:

####Speed - Trend graph
 * Speed graph is drawn using timing to present a more aesthetically pleasing animation
	
![Drawing Speed Graph](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Drawing%20Speed%20Graph.png)

   * By moving the mouse over the graph, you can see the individual year's data: Year & Speed, as well as the difference from the average speed
	
![Speed Info & Average](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Speed%20Average.png)

####Stages - Pie chart
 * Display the frequency of number of stages
 * Stationery number is the number of stages, motion number (green number at end of line) is the frequency of that number
  
![Stages Pie Chart](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Stages%20Pie%20Chart.png)

####Record Holders - Bubble graph
 * First bubble graph displayed is the rider records, user can press R to return to this graph after moving to country
	
![Rider Bubble Graph](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Rider%20Bubble.png)

   * By pressing C, user can change to Country records
	
![Country Bubble Graph](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Country%20Bubble.png)

   * To see a breakdown of the records, the user can press K on either graph

![Country Bubble Key](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Country%20Bubble%20Key.png)

#### Three way correlation graph between Speed, Stages and Length
 * User can press S, T or L to show the respective graphs
	
![Drawing Correlation](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Drawing%20Correlation%20Graph.png)

   * Option to display each of the graphs as Trend, Scatter or Light Trend with Scatter, by pressing relevant keys

![Correlation One](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Correlation%20-%20Length%20%26%20Stages.png)

![Correlation Two](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Correlation%20-%20Length%20%26%20Stages%20Type%202.png)

   * User can find all necessary keys to show each graph in the various forms in the key, by pressing K
	 
![Correlation Key](https://github.com/henrybmcf/OOP_Assignment_2015/blob/master/Screenshots/Correlation%20Key.png)

####Websites used:
- http://bikeraceinfo.com/tdf/tdfstats.html
- http://www.letour.fr/HISTO/us/TDF/index.html
