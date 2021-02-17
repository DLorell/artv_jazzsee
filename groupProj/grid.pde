// from tile import Tile


public class Grid {
  int rows;
  int cols;
  int startTime = millis();
  Tile[][] tiles;
  int focusRow;
  int focusCol;
  
  public Grid(int h, int w){
    _gridConstructor(h, w, 128);
  }
  
  public Grid(int h, int w, int strokeNum){
    _gridConstructor(h, w, strokeNum);
  }
  
  public void start(){
    startTime = millis();
    focusRow = 0;
    focusCol = 0;
  }
  
  public void step(){

    if(focusCol == cols){
      focusCol = 0;
      focusRow++;
    }
    if(focusRow == rows){focusRow = 0;}
    
    tiles[focusRow][focusCol].draw();

    focusCol++;
  }
  
  public void drawGrid(int h, int w, int strokeNum){
    int h_lines = h-1;
    int w_lines = w-1;
    int row_hgt = (int)Math.floor(height/h);
    int col_wth = (int)Math.floor(height/w);
    
    stroke(strokeNum);
    for (int i = 1; i <= h_lines; i++){
      line(0, i*row_hgt, width, i*row_hgt);
    }
    for (int j = 1; j <= w_lines; j++){
      line(j*col_wth, 0, j*col_wth, height);
    }
  }
  
  private void _gridConstructor(int h, int w, int strokeNum){
    rows = h;
    cols = w;
    drawGrid(h, w, strokeNum);
    _initTiles(h, w);
  }
  
  private void _initTiles(int rows, int cols){
    tiles = new Tile[rows][cols];
    int row_hgt = (int)Math.floor(height/rows);
    int col_wth = (int)Math.floor(height/cols);
    
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        tiles[i][j] = new Tile(j*col_wth, i*row_hgt, (j+1)*col_wth, (i+1)*row_hgt);
      }
    }
  }
  
  
};
