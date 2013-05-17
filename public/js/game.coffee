$(document).ready ->
  $ready = $('#ready-prompt')
  $Go = $('#go-prompt')

  killGo = () ->
    $Go.fadeOut 500

  showGo = () ->
    $Go.fadeIn 500, ->
      window.go = true
      setTimeout killGo, 3000

  showReady = () ->
    $ready.fadeIn 500

  killReady = () ->
    $ready.fadeOut 500, ->
      setTimeout showGo, 500

  setTimeout showReady, 1000
  setTimeout killReady, 3000
