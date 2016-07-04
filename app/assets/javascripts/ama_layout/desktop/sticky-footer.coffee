$(window).bind
  load: ->
    adjustFooter()
    clickChecker()
  resize: ->
    adjustFooter()
    clickChecker()

adjustFooter = ->
  $("footer").css({ 'margin-top': 0 + 'px' })

clickChecker = ->
  checkClicks(".close-button", 250)
  checkClicks("a.asset-link.clearfix", 1)
  checkClicks("#use-new-card", 250)

checkClicks = (tag_to_check, delay) ->
  $(tag_to_check).click ->
    i = delay
    while i >= 0
      readjust(i)
      i--

readjust = (delay) ->
  setTimeout ->
    adjustFooter()
  , delay

calcHeight = ->
  footer = $("footer")
  position = footer.position()
  footer_top = if position is undefined then 0 else position.top
  height = $(window).height() - footer_top - footer.height()
  Math.max(height, 50)
