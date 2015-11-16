$(window).bind "load", ->
  $('.dashboard-nav a').click ->
    $(this).toggleClass 'nav-open'
    return
