/*
Processing version of Dan Shiffman Diffusion Limited Aggregation Algorithm 
https://github.com/CodingTrain/Rainbow-Code/tree/master/challenges/CC_34_DLA
*/

// empty flexible lists for storing my objects //more: https://processing.org/reference/ArrayList.html
ArrayList<Walker> walkers = new ArrayList<Walker>(); 
ArrayList<Walker> tree = new ArrayList<Walker>(); 

int maxWalkers = 500; // how many walkers I want at play
int iterations = 1000; // how quick I want the tree to grow up
int defRadius = 8; // defoult radius for my circular elements 
boolean limit = false; // When I want to stop feeding the system with new walkers set this to true


void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100); 
  tree.add(new Walker(width/2, height/2)); // "seeding" our tree, ie. setting the first walker in the tree arrayList
  for (int i = 0; i < maxWalkers; i++) {
    walkers.add(new Walker()); // adding a bunch of walkers to the walkers ArrayList
  }
}

void draw() {
  background(0);

  // show all we have at play every frame
  for (int t = 0; t < tree.size(); t++) {
    tree.get(t).show();
  }
  for (int w = 0; w < walkers.size(); w++) {
    walkers.get(w).show();
  }

  //every frame I run the following cycle a bunch of times in order to speed up the process (CPU Intensive)
  for (int n = 0; n < iterations; n++) {
    for (int i = walkers.size() - 1; i > 0; i--) { // as we maight delete elements in order to hit all elements, it is safer to loop through it backwards
      Walker w = walkers.get(i);
      w.walk();
      for (Walker e : tree) {
        if (e.checkStuck(w)) { // checking each walker against the tree arrayList
          w.stuck = true;
          tree.add(w); // adding a walker to the tree
          walkers.remove(i); // removing it from the walkers arrayList
          break;
        }
      }
    }
  }
  // setting the limits of the tree
  for (int i = 0; i < tree.size(); i++) {
    if (tree.get(i).pos.y >= height || tree.get(i).pos.y <= 0 || tree.get(i).pos.x >= width || tree.get(i).pos.x <= 0) { // checking if the tree hits the edges of our canvas
      limit = true;
      println("tree reached the limit");
      // this is where I want to output something, maybe, in the future
    }
  }
  
  // feeding the tree
  while (walkers.size() < maxWalkers && limit == false) {
    //defRadius *= 0.99;
    //defRadius = constrain(defRadius, 2, defRadius);
    walkers.add(new Walker());
  }
}

// custom function for placing the walkers randomly around the edges of my canvas
PVector randomPoint() {
  float i = random(4); // 4 possibilities for: top, right, bottom amd left edge
  PVector rV = new PVector();
  if (i <= 1) { // top edge
    float x = random(width);
    rV = new PVector(x, 0);
  } else if (i <= 2) { // bottom edge
    float x = random(width);
    rV = new PVector(x, height);
  } else if (i <= 3) { // left edge
    float y = random(height);
    rV = new PVector(0, y);
  } else if (i <= 4) { // right edge
    float y = random(height);
    rV = new PVector(width, y);
  }
  return rV;
}