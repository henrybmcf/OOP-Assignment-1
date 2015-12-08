// Classes for reading in data from tables
class Year
{
  int tour_year;
  int tour_length;
  int stages;
  float speed;

  Year()
  {
    tour_year = 0;
    tour_length = 0;
    stages = 0;
    speed = 0.0f;
  }
}

class Stages
{
  String rider;
  int number;

  Stages()
  {
    rider = "";
    number = 0;
  }
}

class countryWins
{
  String country;
  int number;

  countryWins()
  {
    country = "";
    number = 0;
  }
}