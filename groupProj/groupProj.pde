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
  
  MySoundFile sound_f = songStitcher.step();
  
  if(secondsElapsed != lastSecond){
    lastSecond = secondsElapsed;
    //println(secondsElapsed);
    // Put code which should run once every second here.
    
    if(sound_f == null){
      println("Song over.");
    }else{
      background(128);
      grid.step(sound_f.img);
      grid.drawGrid(ROWS, COLS, 0);
      println("Now playing track: " + sound_f.fileName);
    }
    
    
  }
}
