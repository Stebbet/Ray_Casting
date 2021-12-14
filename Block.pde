class Block {
  PVector pos;
  int blockWidth, blockHeight;
  int num;
  color boxColour;
  color strokeColour;
  
  Block(int posx, int posy, int blockWidth_, int blockHeight_, int nums, boolean first) {
    if (first){
      boxColour = 0;
      strokeColour = 255;
    }
    else{
      boxColour = color(round(random(0,255)), round(random(0,255)), round(random(0,255)));
      strokeColour = boxColour;
    }
    this.pos = new PVector(posx, posy);
    this.blockWidth = blockWidth_;
    this.blockHeight = blockHeight_;
    num = nums;
  }

  void show() {
    fill(boxColour);
    stroke(strokeColour);
    rectMode(CORNER);
    rect(pos.x, pos.y, this.blockWidth, this.blockHeight);
  }

  void resetPos() {
    int blockWidth = int(random(20, 100));
    int blockHeight = int(random(20, 100));
    this.blockWidth = blockWidth;
    this.blockHeight = blockHeight;
    pos = new PVector(int(random(0, width / 2 - blockWidth)), int(random(0, height - blockHeight)));
  }

}
