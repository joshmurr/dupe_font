PImage image;
int popmax;
int cellsize = 10;
int targetWidth;
int[] targetGenes;
int cols, rows;
float mutationRate;
Population population;
Target target;
PFont f;
String file = "app";

void setup() {
  image = loadImage("Helvetica/Glyphs/" + file + ".png");
  target = new Target(image);
  target.loadImg();
  targetGenes = target.getGenes();
  targetWidth = target.getWidth();
  size(cols*cellsize*2, rows*cellsize);
  target.display();
  popmax = 350;
  mutationRate = 0.01;
  population = new Population(targetGenes, mutationRate, popmax);
}

void draw() {
  population.naturalSelection();
  population.generate();
  population.calcFitness();
  int[] currentbest = population.getBest();

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      int loc = i+j*cols;
      fill(currentbest[loc]);
      noStroke();
      rect(i*cellsize, j*cellsize, cellsize, cellsize);
    }
  }
  //stroke(255,0,0);
  //line(width/2,0,width/2,height);
  //STOP:
  if (population.finished()) {
    println("Finished in " + millis()/1000.0 + "s");
    save("HelveticaNew/Glyphs/"+file+".png");
    noLoop();
  }
}

