class AMALayout.Placeholder
  constructor: (args = {}) ->
    args = $.extend({}, @defaultVariables(), args)
    @placeholderTextColor = args.placeholderTextColor
    @inputTextColor = args.inputTextColor
    @defaultTextList = args.defaultTextList
    @setup()

  setup: ->
    for defaultText in @defaultTextList
      select = $("select:contains('#{defaultText}')")
      @setPlaceholderColor select
      @setupChangeEvent select

  setPlaceholderColor: (select) ->
    color = if $(select).prop('selectedIndex') is 0 then @placeholderTextColor else @inputTextColor
    $(select).css('color', color)

  setupChangeEvent: (select) ->
    select.on 'change', (obj) =>
      @setPlaceholderColor $(obj.currentTarget)

  defaultVariables: ->
    placeholderTextColor: "#cccccc",
    inputTextColor: "#323232",
    defaultTextList: ["Please Select", "Month", "Day", "Year", "Select a Class (estimated cost)"]

$ ->
  new AMALayout.Placeholder()
