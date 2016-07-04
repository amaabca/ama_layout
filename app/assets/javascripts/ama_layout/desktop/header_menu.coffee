###
class AMA.ContentToggler
  toggleContentOverflow: () ->
    if $('.off-canvas-wrapper .is-off-canvas-open').length > 0
      $('.off-canvas-wrapper .is-off-canvas-open').parent('.off-canvas-wrapper').css("overflow", "hidden").css("height", "100%")
    else
      $('.off-canvas-wrapper').css("overflow", "auto").css("height", "auto")

$(document).ready ->
  toggler =  new AMA.ContentToggler
  toggler.toggleContentOverflow()
  $(".menu-icon").click ->
    if($(this).data('clicked', true))
      toggler.toggleContentOverflow().delay(800)
###
