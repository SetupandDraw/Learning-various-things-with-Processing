// main object class
class Walker {
  //obj data  
  PVector pos;
  PVector vel;
  boolean stuck;
  int radius;

  //obj constructor
  Walker() {
    pos = randomPoint();
    stuck = false;
    radius = defRadius;
  }
  //overriding obj constructor
  Walker(int x, int y) {
    pos = new PVector(x, y);
    stuck = true;
    radius = defRadius;
  }

  //obj functionalities
  void walk() {
    vel = PVector.random2D(); // maybe I would be more correct not to leave this "undefined" in the obj constructor, think about this.
    pos.add(vel);
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }

  void show() {
    noStroke();
    int hu = floor(map(radius, 2, 8, 0, 100));
    if (stuck) {
      fill(100, 100, 100);
    } else {
      fill(300, 100, 100);
    }
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
  
  //More advanced functionalities
  boolean checkStuck(Walker w) {
      float d = distSq(pos, w.pos); // using my custom dist() function instead of //float d = PVector.dist(pos, others.get(i).pos);
      if (d < (radius * w.radius * 2 * 2)) { 
        //  if (float random(1) < 0.1) { playing with stickness factor
        println("I am stuck");
        return true;
        //  }
    }
    return false;
  }
}

/* to improve performence by avoiding square root unecessary calculations we are writing a custom dist() function
 for calculating the distance btw two vectors we ask for at line 15 */
float distSq(PVector a, PVector b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  // in the gust of the buil-in dist function I would now find: return sqrt(dx*dx + dy*dy); // euclidian distance
  // instead I take out the sqrt()
  return dx * dx + dy * dy;
}