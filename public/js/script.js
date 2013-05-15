moveWater = function() {
  $water = $('.water')
  $water
    .animate({ height: '+=65px', 'background-position-x': '-=20%'}, 25);
}

