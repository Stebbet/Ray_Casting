class Ray {
  float radsRotate;
  float angleIndex;
  float RAYLENGTH;
  PVector startPoint, endPoint, finalPoint;
  float lenOfLine;
  PVector intersection;
  int num;
  PVector colourDir;
  color rayColour;

  Ray(float angle_, int nums) {
    this.radsRotate = angle_;
    this.rayColour = color(255,255,255);
    num = nums;
    this.startPoint = new PVector(player.pos.x, player.pos.y);
    this.endPoint = new PVector(0, -1000);
    this.endPoint = endPoint.rotate(radsRotate);
    this.finalPoint = new PVector(startPoint.x + endPoint.x, startPoint.y + endPoint.y);
    intersection = new PVector(0, 0);
    this.RAYLENGTH = 0;
  }

  void show() {
    stroke(255);
    line(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y);
  }

  void update() {
    finalPoint = new PVector(this.startPoint.x + this.endPoint.x, this.startPoint.y + this.endPoint.y);
    startPoint = new PVector(player.pos.x, player.pos.y);
  }

  void check_collision(Block b) {
    boolean left =   line_collision(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y, b.pos.x, b.pos.y, b.pos.x, b.pos.y+ b.blockHeight);
    boolean right =  line_collision(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y, b.pos.x+b.blockWidth, b.pos.y, b.pos.x+b.blockWidth, b.pos.y+b.blockHeight);
    boolean top =    line_collision(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y, b.pos.x, b.pos.y, b.pos.x+b.blockWidth, b.pos.y);
    boolean bottom = line_collision(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y, b.pos.x, b.pos.y+b.blockHeight, b.pos.x+b.blockWidth, b.pos.y+b.blockHeight);

    // if ANY of the above are true, the line
    // has hit the rectangle
    if (left || right || top || bottom) {
      this.rayColour = b.strokeColour;
      //this.finalPoint = new PVector(this.intersection.x, this.intersection.y);
      
    }
  }

  boolean line_collision(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      // optionally, draw a circle where the lines meet
      this.intersection = new PVector(x1 + (uA * (x2-x1)), y1 + (uA * (y2-y1)));
      fill(255, 0, 0);
      noStroke();
      //ellipse(this.intersection.x, this.intersection.y, 5, 5);
      this.finalPoint = new PVector(this.intersection.x, this.intersection.y);
      this.RAYLENGTH = dist(this.startPoint.x, this.startPoint.y, this.finalPoint.x, this.finalPoint.y);
 
      return true;
    }
    return false;
  }

  void rotateAngle(float a) {
    this.endPoint = this.endPoint.rotate(a);
  }
}
