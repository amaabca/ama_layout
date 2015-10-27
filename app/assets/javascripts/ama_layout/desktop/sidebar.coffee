$(window).bind "load", ->
  $('.dashboard-nav').click ->
    $(this).toggleClass 'nav-open'
    return
