$(function(){
  var paper = Raphael(0,0,document.width,document.height)
    , dropletStroke = '#00ffff'
    , dropletColor = '#9cc6ff'
    , $water = $('.water:first')
    , $water2 = $('.water:last')
    , $end = $('#end-prompt')
    , drop1 = document.getElementById("drop1")
    , drop2 = document.getElementById("drop2")
    , drop3 = document.getElementById("drop3")
    , sounds = [drop1, drop2, drop3]
    , playerTwoWtrLvl = 0
    , playerOneWtrLvl = 0;

  redirect = function () {
    return window.location = 'http://tillthelast.drop:3000'
  }
  p1Overflow = function () {
    // animation function
    
    setTimeout(redirect, 8000);
  }  
  p2Overflow = function () {
    // animation function
    
    setTimeout(redirect, 8000);
  }
  endBlink = function () {
    $end.delay(100).fadeTo(100,0).delay(100).fadeTo(100,1, endBlink);
  }
  showEnd = function (winner) {
    $end.fadeIn(300, endBlink);
    if (winner == 0) {
      p1Overflow();
    }
    else {
      p2Overflow();
    }
  }
  moveP1Water = function() {
    if (playerOneWtrLvl == 8) {
      window.clearInterval(window.iid);
      window.go = false;
      showEnd(0);
      // code for overflow
    }
    else if (playerOneWtrLvl > 0){  
      $water.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
    }    
    else {
      $water.fadeIn(100); 
    }
    playerOneWtrLvl++;
  }
  moveP2Water = function() {   
     if (playerTwoWtrLvl == 8) {
      window.clearInterval(window.iid);
      window.go = false;
      showEnd(1);
      // code for overflow
    }
     else if (playerTwoWtrLvl > 0){  
      $water2.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
    }    
    else {
      $water2.fadeIn(100); 
    }
    playerTwoWtrLvl++;
  }
  // drop Y needs to be a variable that decreases as water level rises
  // must keep track of water level for P1 & P2
  window.playerOneDrop = function() {
    var xcord = Math.floor(Math.random()*50+280).toString(),
      ycord = ( 655 - 40 * playerOneWtrLvl ).toString();
    var drop = paper.path("M" + xcord + ",-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '10px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M" + xcord + "," + ycord + "s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    var rand = sounds[Math.floor(Math.random() * sounds.length)]
    rand.play();
    setTimeout(moveP1Water, 750);
    };
  window.playerTwoDrop = function() {
    var xcord = Math.floor(Math.random()*50+680).toString(),
      ycord = ( 655 - 40 * playerTwoWtrLvl ).toString();
    var drop = paper.path("M" + xcord + ",-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '10px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M" + xcord + "," + ycord + "s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    var rand = sounds[Math.floor(Math.random() * sounds.length)]
    rand.play();
    setTimeout(moveP2Water, 750);
    };

 });

