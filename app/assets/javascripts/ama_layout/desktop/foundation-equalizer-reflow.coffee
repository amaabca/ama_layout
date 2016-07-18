# Add a data-equalizer-reflow attribute to any element to
# trigger a reInit of the equalizer plugin on the click event.
$(document).on 'click', '*[data-equalizer-reflow]', ->
  if Foundation? and Foundation._plugins.equalizer?
    Foundation.reInit('equalizer')
