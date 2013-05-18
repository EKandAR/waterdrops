$(function(){
  var paper = Raphael(0,0,document.width,document.height)
    , dropletStroke = '#00ffff'
    , dropletColor = '#9cc6ff'
    , $water = $('.water:first')
    , $water2 = $('.water:last')
    , $end = $('#end-prompt')
    , playerTwoWtrLvl = 0
    , playerOneWtrLvl = 0;

  endBlink = function () {
    $end.delay(100).fadeTo(100,0).delay(100).fadeTo(100,1, endBlink);
  }
  showEnd = function () {
    $end.fadeIn(300, endBlink);
  }
  moveP1Water = function() {
    if (playerOneWtrLvl == 8) {
      window.clearInterval(window.iid);
      window.go = false;
      showEnd();
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
      showEnd();
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
    setTimeout(moveP1Water, 750);
    };
  window.playerTwoDrop = function() {
    var xcord = Math.floor(Math.random()*50+680).toString(),
      ycord = ( 655 - 40 * playerTwoWtrLvl ).toString();
    var drop = paper.path("M" + xcord + ",-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '10px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M" + xcord + "," + ycord + "s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    setTimeout(moveP2Water, 750);
    };

 });

