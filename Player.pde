class Player {
  int radius;
  PVector pos, vel, acc;
  Player() {
    radius = 20;
    pos = new PVector(width / 4, height / 2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void show() {
    pos.add(vel);
    fill(255);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, radius, radius);
  }

  void move(int direction) {
    if (direction == left) {
      acc = new PVector(-0.01, 0);
    } else if (direction == right) {
      acc = new PVector(0.01, 0);
    } else if (direction == up) {
      acc = new PVector(0, -0.01);
    } else if (direction == down) {
      acc = new PVector(0, 0.01);
    } else {
      acc = new PVector(0, 0);
    }
    vel.add(acc);
  }
}
