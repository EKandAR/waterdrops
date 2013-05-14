//IMAGE VAR
PImage waterLevel;
PImage bkg ;
PImage drop;
PImage glass;
PImage leak;
PImage ready;
PImage go ;
PImage congrats;
PImage youwon;


//ARRAYS
ArrayList Drops = new ArrayList(); //a bucket to store the drops
Drop D;// the Drop in the second tap
boolean drawdrop = true;//set up the boolean of the drawdrop



//TEXT VAR
boolean message_on;
int blinkSpeed = 30;
int lastTime = 0;




// DISPLAY VAR
boolean show; // False by default
int startTime; // The (last) time when the mouse have been clicked
final int showDuration = 1800; // in milliseconds = 1s

/// FADING VAR
float fade_glass = 0;
float fadeSpeed = 20;
boolean startFade = true;



//DROP VAR
float a =-5; // initial drop postion y
float b = 60; // initial speed drop 
int c = 10; // initial speed water raises
int d = 2; // stretch increase
int stretch = 50;
int i =0;
int j=1;
int k=0;




float drop_x;
float drop_y;
float speed_drop ;
float speed_water;
float gravity = 0.2;
int water_y ; // coordinate of the image on the screen
int water_x; // coordinate of the image on the screen
float water_level_y;// location of the waterlevel on the image and the screen  

float fade = 255;







///////////////////////////////////////////////////////////////////////////////////////////////

void setup () {
  colorMode (HSB);
  size(800, 600);
  smooth ();

  leak= loadImage ("1 leack.png");
  drop = loadImage ("1 water drop.png");
  waterLevel= loadImage("1 water level.png" );
  bkg = loadImage("1BKG.png");
  glass = loadImage("1Glass.png");

  ready = loadImage ("1ready.png");
  go = loadImage ("1go.png");
  congrats = loadImage ("1Congrats.png");
  youwon = loadImage ("1youwon.png");




  water_y = 455;
  drop_x = width/2+165;
  drop_y = a;
  speed_drop = b;
  speed_water = c;
  water_x = 500;
  fade_glass = 0;
  water_level_y =500;
}


///////////////////////////////////////////////////////////////////////////////////////////////


void draw () {

  //show bkg at every frame////////////////////////////////
  imageMode(CORNER);
  image(bkg, 0, 0);

  //Intro message//////////////////////////////////////////////
  if (millis () < showDuration) {
    imageMode(CENTER);
    ready.resize(0, 25);
    image(ready, width/2, height/2-100);
  }
  else if (millis()<showDuration*2  && millis() >= showDuration) {
    imageMode(CENTER);
    go.resize(0, 30);
    image(go, width/2, height/2-100);
  }

  else {

    

   if (water_level_y<(330+4*c) ) {
water_leak () ;
    }

    imageMode(CORNER);
    image(glass, 0, 0);

    imageMode(CENTER);
    waterLevel.resize(0, 15);
    image(waterLevel, 565, water_level_y);




    for (int i=0;i<Drops.size();i++) { //iterate over our ArrayList
      Drop D = (Drop)Drops.get(i); //get one Drop out
      D.move(); //move the drop
      D.render(); //draw the drop
    }
  }

  if (water_level_y<330) { // draw until water leve reaches top of the glass
    drawdrop=false;
  } 
  else {
    drawdrop= true;//otherwise, keep drawing the drops
  }


  if (frameCount%b == 0 && drawdrop==true) {//set the drops keep moving
    Drop D = new Drop(new PVector(drop_x, drop_y), water_level_y);//set up the PVector of the new drop
    Drops.add(D);//add new drops
    water_level_y = water_level_y - c;
  }
}


void water_leak () {

  if (j < 800) {

    imageMode(CENTER);

    copy(leak, 0, 0, 332, 104, int(597-stretch/80), int(482), int(4+ stretch/80), int(4+ stretch/120));
    j = j+1;
    stretch = stretch +j/16;
    j = j+1;
    
    if (frameCount%b == 0) {//set the drops keep moving
    Drop D = new Drop(new PVector(drop_x, drop_y), water_level_y);//set up the PVector of the new drop
    Drops.add(D);//add new drops
    }
    
    
    
  }
  else {      
    imageMode(CENTER);
    //copy(leak, 0, 0, 332, 104, int(600-stretch/80), int(486), int(7+ stretch/80), int(7+ stretch/120));
        copy(leak, 0, 0, 332, 104, int(597-stretch/80), int(482), int(4+ stretch/80), int(4+ stretch/120));

}
}
///////////////////////////////////////////////////////////////////////////////////////////////



void blink_message(int l ) {
  int m =0;
  if (m<l) {
    if (frameCount % blinkSpeed == 0) { 
      message_on = !message_on;
    }
    if (message_on) {
      imageMode(CENTER);
      congrats.resize(0, 30);
      image(congrats, width/2, height/2-100);
      youwon.resize(0, 30);
      image(youwon, width/2, height/2-70);
    }
    m = m+1;
  }
}

class Drop {//create a object
  
  PVector pos;//positon of the drop
  PVector vel;//velocity of the drop
  float endY;
 
  
  Drop (PVector _pos, float _endY) {//function--"constructor"-makes the drop
     pos = _pos;//take the incoming information and store it
     endY = _endY;
     vel = new PVector (0,0);

     
   }
   
   void render(){ 
     if (pos.y< endY) {
imageMode(CENTER);
    drop.resize(0, 15);
    image(drop, pos.x,pos.y); 
     //draw a drop
   }
   }
   
   
   void move(){//make drops move
   if (pos.y< endY) {
      pos.add(vel);//add the velocity vector to our position
      PVector gravity = new PVector(0, 0.2);//create a new vector--gravity
      vel.add(gravity);//add gravity vector 
   }
      }
  
   
   }
  







