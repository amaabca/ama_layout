$(window).bind
  load: ->
    adjustFooter()
    accordionAdjust()
  resize: ->
    adjustFooter()
    accordionAdjust()

adjustFooter = ->
  $("footer").css({ 'margin-top': calcHeight() + 'px' })

accordionAdjust = ->
  $("a.asset-link.clearfix").click ->
    setTimeout ->
      adjustFooter()
    , 1

calcHeight = ->
  footer = $("footer")
  position = footer.position()
  footer_top = if position is undefined then 0 else position.top
  height = $(window).height() - footer_top - footer.height()
  Math.max(height, 50)
