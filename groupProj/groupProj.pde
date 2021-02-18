// from grid import Grid
// from songStitcher import SongStitcher

int SONGDURATION = 60;

float startTime = 0;
int lastSecond = -1;
PImage img;
String imgName;
Grid grid;
SongStitcher songStitcher;

void setup() {
  size(720, 720);
  background(128);
  
  songStitcher = new SongStitcher(SONGDURATION);
  //String imgName = songStitcher.sounds.imageMaybe;
  
  grid = new Grid(10, 10, 0);
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
