class AMALayout.Placeholder
  constructor: (args = {}) ->
    args = $.extend({}, @defaultVariables(), args)
    @placeholderTextColor = args.placeholderTextColor
    @inputTextColor = args.inputTextColor
    @defaultTextList = args.defaultTextList
    @setup()

  setup: ->
    for defaultText in @defaultTextList
      @changeDefaultPlaceholderColor(defaultText)
      @updatePlaceholderColor(defaultText)

  changeDefaultPlaceholderColor: (defaultText) ->
    $("option:selected:contains('#{defaultText}')").parent('select').css('color', @placeholderTextColor)

  updatePlaceholderColor: (defaultText) ->
    $("select:contains('#{defaultText}')").on 'change', (obj) =>
      if $(obj.currentTarget).prop('selectedIndex') == 0
        $(obj.currentTarget).css('color', @placeholderTextColor)
      else
        $(obj.currentTarget).css('color', @inputTextColor)

  defaultVariables: ->
    placeholderTextColor: "#cccccc",
    inputTextColor: "#323232",
    defaultTextList: ["Please Select", "Month", "Day", "Year", "Select a Class (estimated cost)"]

$ ->
  window.AMALayout.Placeholder = new AMALayout.Placeholder()
