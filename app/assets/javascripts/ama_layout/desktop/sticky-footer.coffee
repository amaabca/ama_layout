$(window).bind "load", ->
  adjustFooter = ->
    $("footer").css({ 'margin-top': calcHeight() + 'px' }) if calcHeight() > 0

  calcHeight = ->
    footer = $("footer")
    position = footer.position()
    footer_top = if position is undefined then 0 else position.top
    height = $(window).height() - footer_top - footer.height()
    Math.max(height, 50)

  adjustFooter()
  $("a.asset-link.clearfix").click ->
    setTimeout ->
      adjustFooter()
    , 1
