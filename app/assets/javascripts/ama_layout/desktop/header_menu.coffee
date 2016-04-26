$(window).load ->
  ww = $(window).width()
  smallBreakpoint = 640
  if ww < smallBreakpoint
    # sets the height so the nav items in the top bar are scrollable
    wh = $(window).height()
    $('.top-bar').height wh
  return
