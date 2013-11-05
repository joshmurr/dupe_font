class Target {
  int[] genes;
  int w, h;
  PImage img;
  int threshold = 90;
  Target(PImage image) {
    img = image;
    img.loadPixels();
    w = img.width;
    h = img.height;
    cols = w/cellsize;
    rows = h/cellsize;
    genes = new int[cols*rows];
  }
  void loadImg() {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        int x = i*cellsize + cellsize/2; // x position
        int y = j*cellsize + cellsize/2; // y position
        int imgloc = x + y*w;            // Pixel array location
        float r = red(img.pixels[imgloc]);
        float g = green(img.pixels[imgloc]);
        float b = blue(img.pixels[imgloc]);
        //0.21 R + 0.71 G + 0.07 B
        color c = (color)(r+g+b)/3;
        int fill = 0;
        if (brightness(c) > threshold) fill = 255;
        else fill = 0;
        int genesloc = i + j*cols;
        genes[genesloc] = fill;
      }
    }
  }

  void display() {
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        int loc = x+y*cols;
        fill(genes[loc]);
        noStroke();
        rect((x*cellsize)+(cols*cellsize), y*cellsize, cellsize, cellsize);
      }
    }
  }

  int[] getGenes() {
    return genes;
  }

  int getWidth() {
    return cols;
  }
}

