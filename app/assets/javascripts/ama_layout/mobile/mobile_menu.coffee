class AMALayout.MobileMenu
  constructor: (@menuToggle) ->
    @mobileMenu()

  mobileMenu: ->
    @menuToggle.click =>
      @menuToggle.parent().toggleClass("hide show")
      if @menuToggle.parent().hasClass("show")
        @menuToggle.parent().find(".ss-icon").html("close")
      else
        @menuToggle.parent().find(".ss-icon").html("list")