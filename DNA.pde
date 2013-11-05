class DNA {
  int[] genes;
  float fitness;


  DNA(int num) {
    genes = new int[num]; //Changed from Char to Color
    for (int i=0; i<genes.length; i++) {
      float r = random(1);
      if (r < 0.5) genes[i] = 0;
      else genes[i] = 255;
    }
  }
  void fitness(int[] target) {
    int score=0;
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        int loc = x+y*cols;
        if (genes[loc] == target[loc]) {
          score++;
        }
      }
      //println("Score: " + score);
    }
    //fitness = (float)score / (float)target.pixels.length;
    //println("Score: " + score);
    //float newmap = target.length-score;
    float newscore = map(score, 0, target.length, 0, 30);
    //println("New Score: " + newscore);
    fitness = pow(2, newscore);
  }

  DNA crossover(DNA partner) { //DNA is the return type
    DNA child = new DNA(genes.length);
    int midpoint = int(random(genes.length));
    for (int i=0; i<genes.length; i++) {
      if (i>midpoint) child.genes[i] = genes[i];
      else child.genes[i] = partner.genes[i];
    }
    return child;
  }

  DNA coinToss(DNA partner) {
    DNA child = new DNA(genes.length);
    for (int i=0; i<genes.length; i++) {
      float r = random(1);
      if (r<0.5) child.genes[i] = genes[i];
      else child.genes[i] = partner.genes[i];
    }
    return child;
  }

  void mutate(float mutationRate) {
    for (int i=0; i<genes.length; i++) {
      if (random(1) < mutationRate) {
        float r = random(1);
        if (r < 0.5) genes[i] = color(0); //Random float
        else genes[i] = color(255);
      }
    }
  }
  
  int[] getGenes() {
    return genes;
  }
}

