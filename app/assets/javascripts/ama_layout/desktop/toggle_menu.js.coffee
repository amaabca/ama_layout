class AMALayout.ToggleMenu
  constructor: (@menuToggle, @menuProfile, @menuWWW) ->
    @showmenu()

  showmenu: ->
    @menuToggle.click =>
      $(@menuProfile).toggle()
      $(@menuWWW).toggle()
