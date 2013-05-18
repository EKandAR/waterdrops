$(document).ready ->
  $ready = $('#ready-prompt')
  $Go = $('#go-prompt')

  killGo = () ->
    $Go.fadeOut 500
    $('#main-title').remove()

  showGo = () ->
    $Go.fadeIn 500, ->
      window.go = true
      setTimeout killGo, 2000

  showReady = () ->
    $ready.fadeIn 500

  killReady = () ->
    $ready.fadeOut 500, ->
      setTimeout showGo, 500

  setTimeout showReady, 3000
  setTimeout killReady, 5000
