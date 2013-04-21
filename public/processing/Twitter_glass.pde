/* @pjs preload="/img/Twitter_glass_bk.png"; */
/* @pjs preload="/processing/data/Twitter_glass_bk.png"; */
/*  @pjs preload= "/processing/data/Twitter glass drop large.png";*/
/*  @pjs preload= "/processing/data/Twitter glass drop small.png";*/
/*  @pjs preload= "/processing/data/Twitter glass water level high.png";*/
/*  @pjs preload= "/processing/data/Twitter glass water level L.png";*/
/*  @pjs preload= "/processing/data/Twitter glass water level low.png";*/
/*  @pjs preload= "/processing/data/Twitter glass water level splash.png";*/
/*  @pjs preload= "/processing/data/Twitter glass splash low.png";*/


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
  frameRate(60);
  size(800, 600);
  dropL = loadImage ("/processing/data/Twitter glass drop large.png");
  dropS = loadImage ("/processing/data/Twitter glass drop small.png");
  levelH = loadImage ("/processing/data/Twitter glass water level high.png");
  levelL = loadImage ("/processing/data/Twitter glass water level L.png");
  levelM = loadImage ("/processing/data/Twitter glass water level low.png");
  splashH = loadImage ("/processing/data/Twitter glass water level splash.png");
  splashL = loadImage ("/processing/data/Twitter glass splash low.png");


}



void draw () {
  PImage bkg = loadImage("/img/Twitter_glass_bk.png");
  image(bkg, 0, 0);
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

