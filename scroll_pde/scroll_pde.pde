// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/IKB1hWWedMk

int cols, rows;
int scl = 20;
//CHANGED WIDTH TO ACCOMODATE FULLSCREEN
int w = 3500;
int h = 1600;

float flying = 0;

float[][] terrain;

ArrayList<Cube> cubes;

int cubeX = 0;
double cubeExp = 0;
int expCheck = 0;
boolean shrunk = false;

class Cube {
  
  int translateX;
  int translateY;
  int size;
  int frames;
  int currFrame;
  int frameCheck;
  int maxSize;
  
  public Cube() {
    translateX = (int)random(-1000,1000);
    translateY = (int)random(-1000,1000);
    frames = (int)random(400, 2000);
    currFrame = 0;
    frameCheck = 100;
    size = 1;
    maxSize = 100 + (int)random(-20,20);
  }
  
  public void modifySize() {
    if (size < maxSize && currFrame < 101) {
      size++;
    }
    else if (currFrame > (frames - frameCheck)) {
      System.out.println("Frame check: " + currFrame);
      size-=1;
    }
    System.out.println("Size: " + size);
  }
  
  public void tickFrames() {
    currFrame++;
    System.out.println("Frame: " + currFrame);
  }

  public boolean dying() {
    return (size < 100 && currFrame > frames);
  }

}

void generateCube() {
  cubes.add(new Cube());
}
  
void setup() {
  //size(600, 600, P3D);
  
  ///CHANGED SCREEN DISPLAY TO FULLSCREEN
  
  fullScreen(P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
  cubes = new ArrayList<Cube>();
  generateCube();
}


void draw() {

  flying -= 0.01;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -400, -200);
      xoff += 0.2;
    }
    yoff += 0.2;
  }


  
  background(255,255,255);
  //CHANGED COLOR
  //stroke(255,0,255);
  noStroke();
  //noFill();

  translate(width/2, height/2+50);
  rotateX(PI/4);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      
      //CODE TO CHANGE FILL COLOR
      fill(255-7*y, 255-3*y, 255-3*y);
      
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  
  //shit for drawing windows dialog
  //rotateX(-PI/3);
  //PImage img;
  //img = loadImage("windows.jpg");
  
  //image(img, 1000, 240, 1400, 440);
  
  //create a box
  translate(-width/2, -height/2+50);
  //rotateX(-PI/3);
  translate(w/1.5, h/1.5,-300);

  lights();
  stroke(255);
  fill(0);
  
  if (Math.random() < .01) {
    generateCube();
  }

  //draw all relevant cubes;
  for (int i = 0; i < cubes.size(); i++) {
    Cube c = cubes.get(i);
    shapeMode(CENTER);
    translate(c.translateX, c.translateY, 0);
    box(c.size, c.size, c.size);
    translate(-c.translateX, -c.translateY, 0);
    
    c.modifySize();
    c.tickFrames();
    

    
    if (c.dying()) {
      cubes.remove(i);
    }
    
  }

  
}

void drawCube() { 

}