// Generated by CoffeeScript 1.6.1
(function() {

  $(document).ready(function() {
    var $Go, $ready, killGo, killReady, showGo, showReady;
    $ready = $('#ready-prompt');
    $Go = $('#go-prompt');
    killGo = function() {
      $Go.fadeOut(500);
      return $('#main-title').remove();
    };
    showGo = function() {
      return $Go.fadeIn(500, function() {
        window.go = true;
        return setTimeout(killGo, 2000);
      });
    };
    showReady = function() {
      return $ready.fadeIn(500);
    };
    killReady = function() {
      return $ready.fadeOut(500, function() {
        return setTimeout(showGo, 500);
      });
    };
    setTimeout(showReady, 3000);
    return setTimeout(killReady, 5000);
  });

}).call(this);
