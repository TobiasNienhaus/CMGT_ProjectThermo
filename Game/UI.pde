//the Games UI
public class GameUI
{
  //the font used in the game
  PFont font;

  //should the health be displayed as circles
  boolean healthDisplayIsCircles = false;
  //the right coordinate of the health display, if it is a line
  PVector healthRight = new PVector();
  //the height of the health display
  float healthHeight = 30f;
  //the maxWidth of the health display
  float healthWidth = 200f;

  //default constructor
  public GameUI()
  {
    //load the font
    font = loadFont("Bahnschrift-128.vlw");
    //set the loaded font as the used font
    textFont(font);
    //set the text size
    textSize(32);

    healthRight.set(width-10f, height-10f-healthHeight/2f);
  }

  //show the UI
  public void show()
  {
    //draw the fps in the top left corner
    text("fps: " + round(frameRate), 0, 32);
    //draw the health
    drawHealth();
  }

  float spacing = 60f;
  float r = 20f;

  void drawHealth()
  {
    if (healthDisplayIsCircles) {
      //draw circles in the bottom right corner
      //amount of circles is representation of maxHealth of the player
      //amount of these circles filled in, is the amount of health, the player has left

      int drawCircles = round(p.health / 10f);
      int maxCircles = round(p.maxHealth / 10f);
      if (drawCircles < 0) drawCircles = 0;

      pushStyle();
      fill(255, 0, 0);
      stroke(255, 0, 0);
      strokeWeight(5);
      for (int i = 0; i < drawCircles; i++)
      {
        float x = width - spacing / 2f - spacing * i;
        circle(x, height - spacing / 2f, r * 2);
      }
      noFill();
      for (int i = 0; i < maxCircles - drawCircles; i ++)
      {
        float x = width - spacing / 2f - spacing * drawCircles - spacing * i;
        circle(x, height - spacing / 2f, r * 2);
      }
      popStyle();
    } else {
      float perc = (float)p.health/(float)p.maxHealth;
      float actWidth = perc * healthWidth;
      
      //TODO: no rounded edges for the line
      pushStyle();
      //strokeWeight(healthHeight);
      fill(255, 0, 0);
      noStroke();
      rect(healthRight.x-healthWidth, healthRight.y-healthHeight/2f, healthWidth, healthHeight);
      if (perc > 0f)
      {
        fill(0, 255, 0);
        rect(healthRight.x - actWidth, healthRight.y-healthHeight/2f, actWidth, healthHeight);
      }
      popStyle();
    }
  }
}

public class MainMenu implements ButtonEnabled
{
  static final String startButtonID = "start";
  Button startButton;
  
  boolean startGame = false;
  
  public MainMenu()
  {
    startButton = new Button(this, startButtonID,
      new PVector(width/2f-100f, height/2f-50f),
      new PVector(200f, 100f));
  }
  
  public boolean run()
  {
    background(0);
    startButton.show();
    return !startGame;
  }
  
  public void onButtonClick(String buttonID)
  {
    if(buttonID == startButtonID) {
      println("start game");
      startGame = true;
    }
  }
}
