PImage bkg;
PImage dropL;
PImage dropS;
PImage levelL;
PImage levelM;
PImage levelH;
PImage splashH;
PImage splashM;
PImage splashL;

float fade = 255;
float xDLg; // x large drop
float xDSm; // x small drop
float wL=490; // water level
float xSLw =0; // splash level



void setup () {
  frameRate (30);
  size (800, 600);
  bkg = loadImage ("Twitter glass bk.png");
  dropL = loadImage ("Twitter glass drop large.png");
  dropS = loadImage ("Twitter glass drop small.png");
  levelH = loadImage ("Twitter glass water level high.png");
  levelL = loadImage ("Twitter glass water level L.png");
  levelM = loadImage ("Twitter glass water level low.png");
  splashH = loadImage ("Twitter glass water level splash.png");
  splashL = loadImage ("Twitter glass splash low.png");


  image (bkg, 0, 0);
}



void draw () {
  image (bkg, 0, 0);
  image (levelL, 0, xSLw);
  
    dropLfall  (wL);

  
  
  
}



void dropLfall (float waterLevel) {
  // if drop hits the water level, drop disappears and splash effect
  if (xDLg> waterLevel) {
    image (splashL, 0, 5+xSLw);
    tint(255, 0);
    image (dropL, 0, -350+xDLg);
    xDLg=0;
    xSLw = xSLw-1;
  } 
  // drop falls until it hits water level
  else {
    tint(255, 255);
    image (dropL, 0, -350+xDLg);
    xDLg=xDLg+ 1 +xDLg/10;
  }
}

