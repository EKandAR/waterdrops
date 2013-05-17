$(function(){
  var paper = Raphael(0,0,document.width,document.height)
    , dropletStroke = '#00ffff'
    , dropletColor = '#9cc6ff'
    , $water = $('.water:first')
    , $water2 = $('.water:last')
    , playerTwoWtrLvl = 0
    , playerOneWtrLvl = 0;

  moveP1Water = function() {
    $water.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
    playerOneWtrLvl++;
  }
  moveP2Water = function() {
    $water2.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
    playerTwoWtrLvl++;
  }
  // drop Y needs to be a variable that decreases as water level rises
  // must keep track of water level for P1 & P2
  window.playerOneDrop = function() {
    var xcord = Math.floor(Math.random()*40+280).toString(),
      ycord = ( 620 - 40 * playerOneWtrLvl ).toString();
    var drop = paper.path("M" + xcord + ",-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M" + xcord + "," + ycord + "s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    console.log(ycord);
    setTimeout(moveP1Water, 750);
    };
  window.playerTwoDrop = function() {
    var xcord = Math.floor(Math.random()*40+680).toString(),
      ycord = ( 620 - 40 * playerTwoWtrLvl ).toString();
    var drop = paper.path("M" + xcord + ",-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M" + xcord + "," + ycord + "s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    console.log(ycord);
    setTimeout(moveP2Water, 750);
    };

 });

