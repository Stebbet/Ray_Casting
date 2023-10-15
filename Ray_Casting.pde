float NUMRAYS;
float angle;
int up = 0;
int down = 1;
int right = 2;
int left = 3;
float FOV = 75;
ArrayList<Ray> rays = new ArrayList<Ray>();
float NUMBLOCKS = 5;
boolean moveUp, moveLeft, moveDown, moveRight = false;
Player player;
Block blocks[];
float lowAngle = 0;
float maxAngle;


void setup() {
  size(1200, 600);
  NUMRAYS = width / 2;
  angle = FOV / NUMRAYS;
  maxAngle = NUMRAYS * angle;
  player = new Player();
  blocks = new Block[int(NUMBLOCKS)];
  for (int i = 0; i < NUMRAYS; i++) {
    rays.add(new Ray(radians(i * angle), i));
  }
  for (int j = 0; j < NUMBLOCKS; j++) {

    if (j == 0) {
      blocks[j] = new Block(0, 0, width / 2, height, j, true);
    } else {
      int blockWidth = int(random(20, 100));
      int blockHeight = int(random(20, 100));
      blocks[j] = new Block(int(random(0, width / 2 - blockWidth)), int(random(0, height - blockHeight)), blockWidth, blockHeight, j, false);
    }
  }
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  moveBools();

  for (Block bl : blocks) {
    bl.show();
  }
  pushMatrix();
  for (Ray r : rays) {
    r.update();
    for (Block b : blocks) {
       r.check_collision(b);
    }
    //r.show();
    cast(r);
  }
  rays.get(0).show();
  rays.get(rays.size() - 1).show();
  popMatrix();
  player.show();
}
void keyPressed() {
  if (key == 'w') {
    moveUp = true;
  } else if (key == 's') {
    moveDown = true;

    //It could have something to do with this here
    //I am not really rotating the rays just adding and subrtacting rays from the array
  } else if (key == 'a') {
    moveLeft = true;
  } else if (key == 'd') {
    moveRight = true;
  } else if (keyCode == RIGHT) {
    for (Ray o : rays) {
      o.rotateAngle(angle / 2);
    }
  } else if (keyCode == LEFT) {
    for (Ray o : rays) {
      o.rotateAngle(-angle / 2);
    }
  } else if (keyCode == ALT) {
    for (Block b : blocks) {
      if(b.num == 0){
        print("reset blocks");
      } else {
        b.resetPos();
      }
    }
  }
}


void keyReleased() {
  if (key == 'w') {
    moveUp = false;
  } else if (key == 's') {
    moveDown = false;
  } else if (key == 'd') {
    moveRight = false;
  } else if (key == 'a') {
    moveLeft = false;
  }
}



void moveBools() {
  if (moveUp) {
    player.move(up);
  } else if (moveDown) {
    player.move(down);
  } else if (moveRight) {
    player.move(right);
  } else if (moveLeft) {
    player.move(left);
  }
}

void cast(Ray r) {
  //find the vertical length of line which is proportional to the length of 2d line

  float sq = sq(r.RAYLENGTH);
  float wSq = sq((width/2));
  //float b = map(sq, 0, wSq, 255, 0);
  float angleR = 90 - radians(r.radsRotate);
  float len = map(r.RAYLENGTH, 0, width /2, height, 0) * cos(angleR);
  float startingY = height / 2; 
  float startingX = width / 2;
  //len *= cos(90 - radians(r.radsRotate));
  //colour of line is proportional to length
  //dispaly that line on the screen
  fill(r.rayColour);
  stroke(r.rayColour);
  rectMode(CENTER);
  rect(startingX + r.num, startingY, 1, abs(len));
}
