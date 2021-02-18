// from grid import Grid
// from songStitcher import SongStitcher

int SONGDURATION = 30;
int RANDOMSEED = 3;


float startTime = 0;
int lastUpdate = -1;
PImage img;
String imgName;
Grid grid;
SongStitcher songStitcher;

int WINDOW_H = 720;
int WINDOW_W = 720;

int ROWS = 20;
int COLS = 20;

// Updates per second
int updateFreq;

void setup() {
  size(720, 720);
  background(0);
  
  updateFreq = Math.round(1000/((ROWS*COLS)/(SONGDURATION*1.5)));
  
  songStitcher = new SongStitcher(SONGDURATION, WINDOW_H/ROWS, WINDOW_W/COLS, RANDOMSEED);
  
  grid = new Grid(ROWS, COLS, 0, RANDOMSEED);
  grid.start();
}

void draw() {
  if(startTime == 0){startTime = millis();}
  int updatesElapsed = Math.round((millis() - startTime) / updateFreq);
  
  MySoundFile sound_f = songStitcher.step();
  
  if(updatesElapsed != lastUpdate){
    lastUpdate = updatesElapsed;
    
    if(sound_f == null){
      println("Song over.");
    }else{
      //background(128);
      grid.step(sound_f.img);
      //grid.drawGrid(ROWS, COLS, 0);
      println("Now playing track: " + sound_f.fileName);
    }
    
    
  }
}
