

// This modifies the length of the generated song.
int SONGDURATION = 30;

// These determine the number of tiles on the board.
int ROWS = 20;
int COLS = 20;

// This is ~very approximately~ how much of the board gets filled by the end.
// 1 -> The whole board (with maybe some overlap at the end)
// 0.5 -> Less than the whole board
// 2 -> Later primitives will begin drawing over earlier ones.
float fillAmount = 0.75;


// Not meant to be modified ------
int timePerUpdate;
boolean initialized = false;
int RANDOMSEED = -1;
boolean READY = false;
boolean slowed = false;

float startTime = 0;
int lastUpdate = -1;
PImage img;
String imgName;
Grid grid;
SongStitcher songStitcher;

int WINDOW_H = 720;
int WINDOW_W = 720;
// ---------------------------------

void setup() {
  size(1000, 1000);
  background(0);
  timePerUpdate = Math.round(1000/((ROWS*COLS)/(SONGDURATION*(1/fillAmount))));
}

void draw() {
  if(startTime == 0){startTime = millis();}
  int updatesElapsed = Math.round((millis() - startTime) / timePerUpdate);
  
  if(!READY){
    textSize(32);
    if(RANDOMSEED == -1){
      background(0);
      text("Enter ID number: ", 32, width/2);
      text("Hit ESC at any point to quit.", 32, 64+width/2);
    }else{
      background(0);
      text("Enter ID number: "+ String.valueOf(RANDOMSEED), 32, width/2);
      text("Press Enter to Continue...", 32, 64+width/2);
    }
    return;
  }
  
  
  if(!initialized){
    background(0);
    songStitcher = new SongStitcher(SONGDURATION, WINDOW_H/ROWS, WINDOW_W/COLS, RANDOMSEED);
    grid = new Grid(ROWS, COLS, 0, RANDOMSEED);
    grid.start();
    initialized = true;
  }
  
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
  
  if(!slowed && songStitcher.curTrack == songStitcher.numTracks-1){
    timePerUpdate = timePerUpdate * 2;
    slowed = true;
  }
}

void keyPressed(){
  if(keyCode >= 48 && keyCode <= 57){
    if(RANDOMSEED<0){RANDOMSEED = 0;}
    RANDOMSEED = RANDOMSEED*10 + (keyCode - 48);
  }
  
  if(keyCode == ENTER && RANDOMSEED != -1){
    if(!READY){text("(Give it a moment to load.)",32, 128+width/2);}
    READY = true;
  }
  
  if(keyCode == 27){
    exit();
  }
  
}
