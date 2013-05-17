$(function(){
  $water = $('.water:first');
  $water2 = $('.water:last');
  moveP1Water = function() {
    $water.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
  }
  moveP2Water = function() {
      $water.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
    }
  var paper = Raphael(0,0,document.width,document.height)
    , dropletStroke = '#00ffff'
    , dropletColor = '#9cc6ff'
    , playerTwoWtrLvl = 0
    , playerOneWtrLvl = 0;

  // drop Y needs to be a variable that decreases as water level rises
  // must keep track of water level for P1 & P2
  window.playerOneDrop = function() {
    var drop = paper.path("M300,-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M300,600s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    setTimeout(moveP1Water, 750);
    };
  window.playerTwoDrop = function() {
    var drop = paper.path("M600,-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M600,600s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    setTimeout(moveP2Water, 750);
    };

 });

