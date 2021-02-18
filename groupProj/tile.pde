
public class Pos {
  int x;
  int y;
  public Pos(int _x, int _y){
    x = _x;
    y = _y;
  }
  public Pos(){
    x = y = 0;
  }
};

public class Tile {
  public Pos upperLeft;
  public Pos lowerRight;
  public Tile(int x1, int y1, int x2, int y2){
    upperLeft = new Pos(x1, y1);
    lowerRight = new Pos(x2, y2);
  }
  public Tile(){
    upperLeft = new Pos();
    lowerRight = new Pos();
  }
  
  public void draw(){
    _draw(200);
    img = loadImage("1.png");
    img.resize(0, 73);
    image(img, 0, 0);
  }
  
  public void draw(int fill){
    _draw(fill);
  }
  
  private void _draw(int fill){
    int x = upperLeft.x;
    int y = upperLeft.y;
    int rect_width = lowerRight.x - x;
    int rect_height = lowerRight.y - y;
    noStroke();
    fill(fill);
    rect(x, y, rect_width, rect_height);
  }
};
