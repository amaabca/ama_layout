class AMA.RealDatePicker
  constructor: () ->
    @setDefaultDays()
    @addEvents()

  setDefaultDays: () ->
    @limitDaysInMonth $(dateContainer) for dateContainer in $('select.month').parents()

  addEvents: () ->
    $('select.month').on 'change', (event) =>
      @limitDaysInMonth $(event.target).parent()

    $('select.year').on 'change', (event) =>
      @limitDaysInMonth $(event.target).parent()

  limitDaysInMonth: (container) ->
    year = container.find('.year').val()
    month = container.find('.month').val()
    daysInMonth = @daysInMonth(month, year)

    if container.find('.day').val() > daysInMonth then @resetDay(container)

    for day in [1..31]
      option = container.find(".day option[value=#{day}]")
      if day > daysInMonth then option.hide() else option.show()

  daysInMonth: (month, year) ->
    # JS months are 0-based, and day 0 is the last day of the previous month
    new Date(year, month, 0).getDate()

  resetDay: (container) ->
    container.find('.day :nth-child(1)').prop('selected', true)

$(document).ready ->
  new AMA.RealDatePicker()
