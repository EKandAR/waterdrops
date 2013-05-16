$(function(){
  $water = $('.water:first');
  moveWater = function() {
    this.hide();
    $water
      .animate({ height: '+=100px', 'background-position-x': '-=30%'}, 25);
  }

  var dropletStroke = '#00ffff';
  var dropletColor = '#9cc6ff';

  var paper = Raphael(0,0,document.width,document.height);

  $('.glass:last').on('click', function() {
    var drop = paper.path("M300,-25s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z")
                    .attr({'fill': 'white', 'stroke-width': '5px', 'stroke': 'black'}).toBack();
    console.log('omglol');
    drop.animate({path:"M300,600s10,25,10,30a10,10,0,0,1,-20,0s10,-25,10,-30Z"}, 750, '<', drop.hide);
    });

 });

