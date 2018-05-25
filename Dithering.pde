
PImage pic;
float factor = 1; // Change the number of colours.

void setup() {
  size(1440,720);
  //pic = loadImage("face.jpg");
  //pic = loadImage("faceLow.jpg");
  //pic = loadImage("dog.jpg");
  pic = loadImage("dogLow.jpg");
  //pic.filter(GRAY);
  image(pic,0,0,720,720);
  differ();
}

int index(int x, int y){
   return x + y * pic.width; 
}

color passError(color Old, float R , float G, float B, float error){
   float cR = red(Old) + R * error;
   float cG = green(Old) + G * error;
   float cB = blue(Old) + B * error;
   return color(cR,cG,cB);
}

void differ() {
  pic.loadPixels();
  for (int y = 0; y < pic.height-1; y++) {
    for (int x = 1; x < pic.width-1; x++){

        color pix = pic.pixels[index(x,y)];
        
        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);
        

        float newR = round(factor * oldR / 255) * (255/factor);
        float newG = round(factor * oldG / 255) * (255/factor);
        float newB = round(factor * oldB / 255) * (255/factor);
        
        pic.pixels[index(x,y)] = color(newR,newG,newB);
        
        float errorR = oldR - newR;
        float errorG = oldG - newG;
        float errorB = oldB - newB;
        
        pic.pixels[index(x+1,  y)] = passError(pic.pixels[index(x+1,  y)], errorR, errorG, errorB, 7/16.0);
        pic.pixels[index(x-1,y+1)] = passError(pic.pixels[index(x-1,y+1)], errorR, errorG, errorB, 3/16.0);
        pic.pixels[index(x  ,y+1)] = passError(pic.pixels[index(x  ,y+1)], errorR, errorG, errorB, 5/16.0);
        pic.pixels[index(x+1,y+1)] = passError(pic.pixels[index(x+1,y+1)], errorR, errorG, errorB, 1/16.0);
        
    }
  }
  pic.updatePixels();
  image(pic, 720, 0,720,720);
}
