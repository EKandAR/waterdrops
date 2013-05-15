
//water level vars
float time = 0;
float wave = 50;
float count = 0;
float start_x;
float end_x;


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



//DROP VAR
float a =-5; // initial drop postion y
int b =60;
int c = 10; // initial speed water raises
int d = 2; // stretch increase
int stretch = 50;
int i =0;
int j=1;
int k=0;




float drop_x;
float drop_y;
float speed_water;
float gravity = 0.2;
int water_y ; // coordinate of the image on the screen
int water_x; // coordinate of the image on the screen
float water_level_y;// location of the waterlevel on the image and the screen  




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


  float start_x = 400+124;
  float end_x = 400+205;

  water_y = 455;
  drop_x = width/2+165;
  drop_y = a;
  speed_water = c;
  water_x = 500;
  water_level_y =500;
}


///////////////////////////////////////////////////////////////////////////////////////////////


void draw () {

  imageMode(CORNER);
  image(bkg, 0, 0);  //show bkg at every frame/


  //INTRO MESSAGE //////////////////////////////////////////////
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

    //START GAME //////////////////////////////////////////////


    if (water_level_y<(330+4*c) ) {
      water_leak () ;
    } // when water reached top of the glass, leak starts


    imageMode(CORNER);
    image(glass, 0, 0);

    water_level ();
   



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
         count = count + 1;
  }
}


void water_leak () {
  if (j < 800) {
   // imageMode(CENTER);
   //copy(leak, 0, 0, 332, 104, int(597-stretch/80), int(482), int(4+ stretch/80), int(4+ stretch/120));
    fill (150, 20, 190);
    ellipseMode(CENTER);
    ellipse (550, 500, stretch/50, stretch/150);
    j = j+1;
    stretch = stretch +j/20;
    j = j+1;

    if (frameCount%b == 0) {//set the drops keep moving
      Drop D = new Drop(new PVector(drop_x, drop_y), water_level_y);//set up the PVector of the new drop
      Drops.add(D);//add new drops
    }
  }
  else {      
     fill (150, 20, 190);
    ellipseMode(CENTER);
  ellipse (550, 500, stretch/50, stretch/150);
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


void water_level () {
  if (count <8) {
    start_x = width/2+124;
    end_x = width/2+205;
  }
  
 
   else if (count >=8 || count <10) {
    start_x = width/2+121;
    end_x = width/2+210;
  }
  else if (count >=10) {
    start_x = width/2+116;
    end_x = width/2+220;
  }
    
  float _x = start_x;
  while (_x<  end_x) {
    wave = map (noise (_x/50, time), 0, 1, 10, 3);
    stroke (150, 20, 190);
    line (_x, water_level_y +wave, _x, water_level_y +wave-4);
    _x=_x+1;
  }
  time = time +0.02;

}

