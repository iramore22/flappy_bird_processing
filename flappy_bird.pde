float xpos = 200; //<>//
float ypos = 50;
float vy = 0;
float gravity = 0.5;
float bounce = -1;
PImage bird;
PImage background;
PImage wall;
PImage reset;
int count = 300;
WallPair[] walls = new WallPair[4];
boolean lose = false;
int score = 0;
PFont flappyFont;
float[] wallsOffset = new float[4];
void setup() 
{
  size(800,600);
  smooth();
  noStroke();
  bird = loadImage("bird1.png");
  background = loadImage("back.png");
  wall = loadImage("truba.png");
  reset = loadImage("RestartBtn.png");
  flappyFont = createFont("04B_19__.TTF", 38.0, true);
  fill(255);
  textFont(flappyFont);
  textAlign(LEFT, TOP);
   for(int i = 0; i < wallsOffset.length; i++){
     wallsOffset[i] = random(-100, 100);
   }
}

void draw() 
{
  
  if(!lose ){
  count++;
  }
  drawBackgroundAndWalls(count%width);
  image(bird, xpos, ypos);
  vy += gravity;
  ypos += vy;
  if(ypos > height - 50)
  {
   lose = true;
  }
  checkTouch(); //<>// //<>//
  text("SCORE: "+score, width - 200, 30);
  if(lose){
    imageMode(CENTER);
    image(reset, width/2, height/2);
    imageMode(CORNER);
  }
}

void drawBackgroundAndWalls(int offset){
  background(0);
  image(background, -offset, 0);
  image(background, width-offset, 0);

  drawWalls(width-offset);
  if(count > 800){
    drawWalls(-offset);
  }
 
  
  
}

void drawWalls(int offset){
  for(int i = 0; i<4; i++){
    drawPairOfWalls(offset + 200*i ,i, wallsOffset[i]);
  }
}

void drawPairOfWalls(int xPos, int i, float offset){
  
  pushMatrix();
  rotate(PI);
  image(wall, -xPos-50, - 200 - offset);
  popMatrix();
  image(wall, xPos, height/2+150 + offset);
  if(xPos == xpos - wall.width && !lose){
  score++;
  }
  if(xPos > 0 && xPos < width){
   walls[i] = new WallPair(xPos, 200+offset, height/2+150 + offset);
  }
}

void checkTouch(){
  for(WallPair pair : walls){
    if(pair!=null){
    if((ypos < pair.y1 && xpos > pair.x && xpos < pair.x+wall.width) || (ypos > pair.y2 && xpos > pair.x && xpos < pair.x+wall.width)){
      println(ypos);
      lose = true;
    }
    }
  }
}
void reset(){
  lose = false;
  count = 300;
  ypos = 50;
  score = 0;
  vy = 0;
  for(int i = 0; i < wallsOffset.length; i++){
     wallsOffset[i] = random(-100, 100);
  }
}

void keyPressed() {
  if(!lose){
  vy = -6.0;
  }
  else{
  reset();
  }
}

void keyReleased(){
  if(!lose){
   vy = gravity;
  }
}

class WallPair {
  float x, y1, y2;
  WallPair(float x, float y1, float y2){
    this.x = x;
    this.y1 = y1;
    this.y2 = y2;
  }
  WallPair(){
   super();
  }
}