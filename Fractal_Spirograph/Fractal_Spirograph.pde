import processing.pdf.*;

float r1 = 100;
float x1, y1;
float angle = 0;
int resolution;// try 50 // to control the level of details I want in my drawing // see in Orbit's constructor --> speed = pow(k, n-1)/ resolution; 
boolean construction = true;
boolean drawing = true; // making no real use of this but keeping it for future implementation maybe
boolean drawingComplete = false;
boolean recording = false;
int versus = 1; // this determins if the drowing happen inside (-1) or outside (1) the orbits


ArrayList<PVector>path;

Orbit sun;
Orbit next;
Orbit end; // to keep track of the last one of the orbits

void setup() {
  size(600, 600);
  drawMe();
}


void draw() {
  background(255);
  if (recording == true && drawingComplete == true) {
    beginRecord(PDF, "orbit-####.pdf");
  }
  // I need a loop to show all the orbits, starting with the first one and draw it, then the child and draw it etc. Untill there are children
  // I use a loop to fast forward the drawing process, makin more step each frame
  for (int i = 0; i < resolution; i++) {
    Orbit next = sun;
    while (next != null) {
      next.update();
      next = next.child;
    }
    path.add(new PVector(end.x, end.y));
  }

  Orbit next = sun;
  while (next != null) {
    if (construction == true) {
      next.show();
    }
    next = next.child;
  }

  if (drawing == true) {
    beginShape();
    stroke(41);
    for (PVector pos : path) {
      vertex(pos.x, pos.y);
    }
    endShape();
  }

  if (degrees(sun.child.angle) >= 269) {
    drawingComplete = true;
    //println("recording = " + recording);
  }

  if (recording == true && drawingComplete == true) {
    endRecord();
  }

  if (degrees(sun.child.angle) >= 270) {
    drawMe();
  }
}

void mousePressed() {
  //println(degrees(sun.child.angle)); 
  construction = !construction;
}

// If you want to keep the drawing 
void keyPressed() {
  construction = false;
  recording = !recording;
  println("recording = " + recording);
}

void drawMe() {
  drawingComplete = false;
  recording = false;
  //println("recording = " + recording);
  path = new ArrayList<PVector>();
  k = int(random(-12, -4));
  int randomizer = int(random(2, 6));
  resolution = int(map(randomizer, 2, 6, 40, 10)); // int(200/randomizer);
  float sunradius = width/(randomizer*2);
  if (sunradius >= width/4) { //width/3
    versus = -1;
    println(versus);
  } else {
    println(sunradius);
    versus = 1;
  }
  sun = new Orbit(width/2, height/2, sunradius, 0); // x, y, r, parent, speed
  next = sun; // starting from the first one
  for (int i = 0; i < int(20/randomizer); i++) {
    next = next.addChild(); // starting from --> next = sun.addChild();
    // getting the child's reference and iterating
  }
  end = next; // the reference for the very last one child gets stored into "end"
}