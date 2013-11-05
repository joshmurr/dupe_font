class Population {
  float mutationRate;
  int perfectScore, notSoPerfectScore;
  int generations;
  int[] targetGenes;
  boolean finished;
  DNA[] population;
  ArrayList<DNA> matingPool;
  ArrayList<DNA> fitties;
  float minFitness, maxFitness;

  Population(int[] genes, float m, int num) {
    targetGenes = genes;
    mutationRate = m;
    population = new DNA[num];
    for (int i=0; i<population.length; i++) {
      population[i] = new DNA(targetGenes.length);
    }
    calcFitness();
    matingPool = new ArrayList<DNA>();
    fitties = new ArrayList<DNA>();
    finished = false;
    generations = 0;
    maxFitness = 0;
    minFitness = 0;
    perfectScore = int(pow(2, 30));
    notSoPerfectScore = int(pow(2,20));
  }

  void calcFitness() {
    for (int i=0; i<population.length; i++) {
      population[i].fitness(targetGenes);
    }
  }

  void naturalSelection() {
    matingPool.clear();
    //Set maxFitness to the best available fitness in entire population:
    maxFitness = 0;
    for (int i=0; i<population.length; i++) {
      if (population[i].fitness > maxFitness) {
        maxFitness = population[i].fitness;
      }
    }
    minFitness = maxFitness/1.2;
    //println(minFitness);
    for (int i=0; i<population.length; i++) {
      float fitness = map(population[i].fitness, 0, maxFitness, 0, 1);
      int n = int(fitness * 100);
      for (int j=0; j<n; j++) {
        matingPool.add(population[i]);
      }
    }
    //println("Mating Pool Size: " + matingPool.size());
  }
  
  DNA getRandom(){
    fitties.clear();
    for(int i =0; i<matingPool.size(); i++){
      DNA d = matingPool.get(i);
      if(d.fitness > minFitness) fitties.add(d);
    }
    //println("Fitties: " + fitties.size());
    DNA randomDNA = fitties.get((int)random(fitties.size()));
    return randomDNA;
  }

  void generate() {
    // Refill the population with children from the mating pool
    for (int i = 0; i < population.length; i++) {
      /*int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      */
      DNA partnerA = getRandom();
      DNA partnerB = getRandom();
      
      DNA child = partnerA.coinToss(partnerB);
      child.mutate(mutationRate);
      population[i] = child;
    }
    generations++;
  }

  int[] getBest() {
    float worldrecord = 0.0f; //Makes sure the number is a float
    int index = 0;
    for (int i=0; i<population.length; i++) {
      if (population[i].fitness > worldrecord) {
        index = i;
        worldrecord = population[i].fitness;
      }
    }
    if (worldrecord == perfectScore || (worldrecord > notSoPerfectScore && (millis()/1000.0 > 30))) finished = true;
    //println("WR: "  + worldrecord);
    return population[index].getGenes();
  }

  boolean finished() {
    return finished;
  }

  int getGenerations() {
    return generations;
  }

  float getAverageFitness() {
    float total = 0;
    for (int i=0; i<population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }
}

