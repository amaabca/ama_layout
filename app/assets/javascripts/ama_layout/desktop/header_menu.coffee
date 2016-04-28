$(window).load ->
  windowWidth = $(window).width()
  smallBreakpoint = 640
  if windowWidth < smallBreakpoint
    # sets the height so the nav items in the top bar are scrollable
    windowHeight = $(window).height()
    $('.top-bar').height windowHeight
