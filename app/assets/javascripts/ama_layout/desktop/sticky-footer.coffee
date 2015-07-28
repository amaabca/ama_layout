$(window).bind "load", ->
  footer = $("footer")
  position = footer.position()
  footer_top = if position is undefined then 0 else position.top
  height = $(window).height() - footer_top - footer.height()
  footer.css({ 'margin-top': height + 'px' }) if height > 0