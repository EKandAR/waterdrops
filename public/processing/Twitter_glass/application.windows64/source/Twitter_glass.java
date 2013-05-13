import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Twitter_glass extends PApplet {



ControlP5 cp5;
String textValue = "";


//IMAGE VAR
PImage water ;
PImage bkg ;
PImage drop1;
PImage glass;

//TEXT VAR
PFont messageS;
PFont messageL;
boolean message_on;
int blinkSpeed = 30;
int lastTime = 0;

// DISPLAY VAR
boolean show; // False by default
int startTime; // The (last) time when the mouse have been clicked
final int showDuration = 1500; // in milliseconds = 1s

/// FADING VAR
float fade_glass = 0;
float fadeSpeed = 20;
boolean startFade = true;
boolean in = true;


//DROP VAR
float a =-25; // initial drop postion y
float b = 15; // initial speed drop 
int c = 5; // initial speed water raises
int d = 2; // stretch increase
int stretch =0;
int stretch_leak =0;
int i =0;
int j=0;
int k=0;



float drop1_x=0;
float drop1_y;
float speed_drop ;
float speed_water;
float gravity = 0.2f;
int water_y ; // coordinate of the image on the screen
int water_x; // coordinate of the image on the screen
float water_level_y =480; // location of the waterlevel on the image and the screen  

float fade = 255;
float xDLg; // x large drop
float xDSm; // x small drop
float wL=490; // water level
float xSLw =0; // splash level

// water image coordinate
int x1 = 500; // x coord to copy from image water
int y1 = 450; // y coord to copy from image water
int w1 =100; // width for copy from image water
int h1 =50; // height for copy from image water
int x2 = 500; // x new coord for image water
int y2 = 455; // y new coord for image water. will use to make water level raise (water_y)
int w2 =100; // new width for image water. will use it to stretch image
int h2 =50; // new hight for image water.

boolean drop_stop;


public void setup () {
  colorMode (HSB);
  size(800, 600);
  smooth ();
  drop1_y = a;
  speed_drop = b;
  speed_water = c;
  drop1 = loadImage ("1WD1.png");
  water= loadImage("1WL1.png" );
  bkg = loadImage("1BKG.png");
  glass = loadImage("1Glass.png");
  water_y = water_y+y2;
  messageS = loadFont("Monospaced-20.vlw");
  messageL = loadFont("Monospaced-26.vlw");
  water_x = x2;
  fade_glass = 0;
  
  //TEXTBOX SETUP
  cp5 = new ControlP5(this);
  cp5.addTextfield("input")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(messageS)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
                 
  cp5.addTextfield("textValue")
     .setPosition(20,170)
     .setSize(200,40)
     //.setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
       
  cp5.addBang("clear")
     .setPosition(240,170)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  
  cp5.addTextfield("default")
     .setPosition(20,350)
     .setAutoClear(false)
     ;
     
  textFont(messageS);
}


///////////////////////////////////////////////////////////////////////////////////////////////


public void draw () {

  //show bkg at every frame
  image(bkg, 0, 0);

  //Intro message
  if (millis () < showDuration) {
    textFont(messageS);
    textAlign(CENTER);
    fill (255, 255, 255);
    text("READY???", width/2, height/2-100);
  }
  else if (millis()<showDuration*2  && millis() > showDuration) {
    textFont(messageL);
    text("GO!", width/2, height/2-100);
  }

  else {
    ///START GAME AFTER SHOWDURATION*2


    if (drop_stop == true) {
      water_leak ();
    }

    /// FADE IN GLASS IMAGE AND THE BEGINNING OF THE GAME
    if (fade_glass < 255) { 
      tint(255, fade_glass);
      image(glass, 0, 0);
      fade_glass =fade_glass+ fadeSpeed;
    }
    else { 
      fade_glass = 255;
      tint(255, fade);
      image(glass, 0, 0 );
    }


    ///DROP FALLS
    if (water_y>(-153+y2)) {
      dropFall_waterRaise ();
      drop_stop = false;
    } 
    else {
      water_x = PApplet.parseInt(x2-stretch/2); // move image of the water to the left
      copy(water, x1, y1, w1, h1, water_x, water_y, w1+ stretch, h1);
      drop_stop = true;

      //WINNING MESSAGE
      if (millis() - startTime > showDuration && millis() - startTime < showDuration*8) 
      {
        blink_message2 (100);
      }
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////

public void dropFall_waterRaise () {
  if (drop1_y<water_level_y) {
    //show the image of the water
    copy(water, x1, y1, w1, h1, water_x, water_y, w1+ stretch, h1);
    // drop falls
    tint(255, 255);
    image(drop1, drop1_x, drop1_y); 
    drop1_y = drop1_y + speed_drop;
    speed_drop = speed_drop + gravity;
  }
  else {
    tint(255, 255);
    //stretch image of water
    if (i< 6) {   
      stretch = stretch +d;
      water_x = PApplet.parseInt(x2-stretch/2); // move image of the water to the left
      copy(water, x1, y1, w1, h1, water_x, water_y, w1+ stretch, h1);
    }

    else if (i >11 && i<16) {
      stretch = stretch +d;
      water_x = PApplet.parseInt(x2-stretch/2); // move image of the water to the left
      copy(water, x1, y1, w1, h1, water_x, water_y, w1+ stretch, h1);
    }
    else if (i>28 && i<31) {
      stretch = stretch +d;
      water_x = PApplet.parseInt(x2-stretch/2); // move image of the water to the left
      copy(water, x1, y1, w1, h1, water_x, water_y, w1+ stretch, h1);
    }

    else {
      copy(water, x1, y1, w1, h1, water_x, water_y-c, w1+ stretch, h1);
    }
    // drop disappears
    tint(255, 0);
    image (drop1, 0, water_level_y); 
    i=i+1;
    water_y = water_y -c; // increase level of the water in the glass
    water_level_y= water_level_y - c;
    drop1_y = a; // reinitialization of drop1_y
    speed_drop = b; // reinitialization of speed
    startTime = millis ();
  }
}



public void water_leak () {

  if (j < 70) {
    tint(255, 255);
    copy(water, x1, y1, w1, h1, PApplet.parseInt(500-stretch_leak/2), PApplet.parseInt(470-stretch_leak/4), 100+stretch_leak, 70+stretch_leak/2);
    stretch_leak = stretch_leak+1;
    j = j+1;
    dropFall();
  }
  else {      
    tint(255, 255);
    copy(water, x1, y1, w1, h1, PApplet.parseInt(500-stretch_leak/2), PApplet.parseInt(470-stretch_leak/4), 100+stretch_leak, 70+stretch_leak/2);
  }
}




public void blink_message2(int l) {
  int m =0;
  if (m<l) {if (frameCount % blinkSpeed == 0) { 
    message_on = !message_on;
  }
  if (message_on) {
    textFont(messageS);
    textAlign(CENTER);
    fill (255, 255, 255);
    text("CONGRATULATIONS", width/2, height/2-100);
    text("YOU WON!", width/2, height/2-70);
  }
  m = m+1;
  }
}




public void dropFall () {
  if (drop1_y<water_level_y) {
    // drop falls
    tint(255, 255);
    image(drop1, drop1_x, drop1_y); 
    drop1_y = drop1_y + speed_drop;
    speed_drop = speed_drop + gravity;
  }
  else { 
    tint(255, 0);
    image (drop1, 0, water_level_y);
    drop1_y = a; // reinitialization of drop1_y
    speed_drop = b-k; // reinitialization of speed
    k=k+2;
  }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Twitter_glass" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
