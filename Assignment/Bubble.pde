class Bubble
{
  int[] stage_wins = {20, 10, 8, 36, 12};
  float x = width * 0.5f;  
  
  void render()
  {
    int low = stage_wins[0];
    int high = stage_wins[0];
     
    for(int i:stage_wins)
    {
      if(i < low)
      {
        low = i;
      }
      if(i > high)
      {
        high = i;
      }
    }
    
    for(int i = 0; i < stage_wins.length; i++)
    {
      float y = map(stage_wins[i], low, high, height - 50, 50);
      
      float radius = map(stage_wins[i], low, high, 50, 200);
      fill(255);
      ellipse(x, y, radius, radius);
    }
    
  }
  
}