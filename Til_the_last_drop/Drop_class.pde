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
  

