class AMALayout.DropDown
  constructor: (@menuDropDown, @pointerUp, @dropdowncontainer, @dropdownClose, @html) ->
    @setupDropDown()

  hideMenu = (element) ->
    element.animate {opacity:0}, 0,
      -> element.removeClass("show").addClass("hide")

  showMenu = (element, heightoffset) ->
    element.toggleClass("show hide").css top: heightoffset
    element.animate {opacity:1}, 0

  setupDropDown: ->
    ishovered = false
    @menuDropDown.mouseenter =>
      if !ishovered
        heightoffset = @dropdowncontainer.outerHeight() + 10
        datavalue = @menuDropDown.attr("data-dropdown")
        @menuDropDown.toggleClass("open closed")
        showMenu $(datavalue), heightoffset
        ishovered = true

    @html.mouseleave =>
      datavalue = @menuDropDown.attr("data-dropdown")
      @menuDropDown.removeClass("open").addClass("closed")
      hideMenu $(datavalue)
      ishovered = false

    $(document).bind 'mouseup', (event) =>
      container = $(".menu-profile, .dropdown-link")
      if ishovered and container.has(event.target).length is 0
        datavalue = @menuDropDown.attr("data-dropdown")
        @menuDropDown.removeClass("open").addClass("closed")
        hideMenu $(datavalue)
        ishovered = false

    @dropdownClose.bind 'mouseup', (event) =>
      if ishovered
        datavalue = @menuDropDown.attr("data-dropdown")
        @menuDropDown.removeClass("open").addClass("closed")
        hideMenu $(datavalue)
        ishovered = false

    color = @pointerUp.parent().css("background-color")
    @pointerUp.css
      "border-bottom-color" : color