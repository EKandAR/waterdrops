$(function(){
  $water = $('.water:first');
  moveWater = function() {
    $water.animate({ 'margin-top': '-=50px', width: '+=12px'}, 25);
  }

  var paper = Raphael(0,0,document.width,document.height)
    , dropletStroke = '#00ffff'
    , dropletColor = '#9cc6ff'
    , playerTwoWtrLvl = 0
    , playerOneWtrLvl = 0;

  // drop Y needs to be a variable that decreases as water level rises
  // must keep track of water level for P1 & P2
  $('.glass:last').on('click', function() {
    var drop = paper.path("M300,-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    drop.animate({path:"M300,600s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    setTimeout(moveWater, 750);
    });

 });

