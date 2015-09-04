root = exports ? this

root.adjustFooter = ->
  console.log("cheese")
  $("footer").css({ 'margin-top': calcHeight() + 'px' }) if calcHeight() > 0

root.calcHeight = ->
  footer = $("footer")
  position = footer.position()
  footer_top = if position is undefined then 0 else position.top
  height = $(window).height() - footer_top - footer.height()
  height = 50 if height < 50
  height

$(window).bind "load", ->
  adjustFooter()
  $("a.asset-link.clearfix").click ->
    setTimeout ->
      adjustFooter()
    , 1
