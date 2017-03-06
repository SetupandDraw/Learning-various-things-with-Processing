int k = -4; // try also 12 arbitrary value for the crazy formula to calculate the angular speed of each of the orbits

class Orbit {
  float x; 
  float y;
  float r; // radius
  int n; // a variable to keep track of the level of speed of each orbit
  float angle;
  float speed; // to increment my angle ie angular velocity
  Orbit parent;
  Orbit child;

  // overloading constructors
  Orbit(float x_, float y_, float r_, int n_) { // if this object gets created without the fifth argument - ie no parent
    this(x_, y_, r_, n_, null); // call the other constructor and send to it null as the fifth argument
    // this way we can have no parent for the original object
  }

  Orbit(float x_, float y_, float r_, int n_, Orbit p) {
    x = x_;
    y = y_;
    r = r_;
    n = n_;
    speed = (radians(pow(k, n-1)))/resolution; // calculated based on this crazy formula : Speed(n) = k^(n-1), k=±2, ±3, ±4, 
    parent = p;
    child = null;
    angle = -PI/2; // to start with the drawing oriented vertically to the canvas // try this -- >0; // to have it oriented 90°
  }

  Orbit addChild() {
    float newr = r * 0.3; // new radius // try also r * 0.5;
    float newX = x + r + newr;
    float newY = y; // + r + newradius;
    child = new Orbit(newX, newY, newr, n+1, this); // the object itself creates its own child and set this as its parent
    return child; // returning a reference for the newly created object
  }

  void update() {
    if (parent != null) {
      angle += speed;
      float rsum = r + parent.r * versus; //  try also r - parent.r // to nest the drawing circles inside of themselves 
      x = parent.x + rsum * cos(angle); //float x2 = x1 + rsum * cos(angle);
      y = parent.y + rsum * sin(angle); //float y2 = y1 + rsum * sin(angle);
    }
  }

  void show() {
    noFill();
    stroke(100, 50);
    strokeWeight(1);
    if (parent != null) {
      line(parent.x, parent.y, x, y);
    }
    ellipse(x, y, r*2, r*2);
  }
}