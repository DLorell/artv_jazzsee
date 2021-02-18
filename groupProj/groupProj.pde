// from grid import Grid
// from songStitcher import SongStitcher

int SONGDURATION = 30;

float startTime = 0;
int lastSecond = -1;
PImage img;
String imgName;
Grid grid;
SongStitcher songStitcher;

int WINDOW_H = 720;
int WINDOW_W = 720;

int ROWS = 10;
int COLS = 10;

void setup() {
  size(720, 720);
  background(128);
  
  songStitcher = new SongStitcher(SONGDURATION, WINDOW_H/ROWS, WINDOW_W/COLS);
  
  grid = new Grid(ROWS, COLS, 0);
  grid.start();
}

void draw() {
  if(startTime == 0){startTime = millis();}
  int secondsElapsed = Math.round((millis() - startTime) / 1000);
  
  String curTrack = songStitcher.step();
  
  if(secondsElapsed != lastSecond){
    lastSecond = secondsElapsed;
    //println(secondsElapsed);
    // Put code which should run once every second here.
    
    background(128);
    grid.step();
    grid.drawGrid(10, 10, 0);
    //img = loadImage(curImg);
    //image(img, 0, 0);
    println("Now playing track: " + curTrack);
  }
}
