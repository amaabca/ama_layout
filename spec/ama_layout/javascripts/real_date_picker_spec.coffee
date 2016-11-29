describe "AMALayout.RealDatePicker", ->
  beforeEach ->
    this.fixtures = fixture.load("real_date_picker.html", false)
    jasmine.Ajax.install()
    new AMALayout.RealDatePicker()

  afterEach ->
    jasmine.Ajax.uninstall()

  describe "Initial state", ->
    it "Displays 31 days", ->
      available_days = $('select.day option')
      expect(available_days.length).toBe 31 + 1

  describe "Selecting a month with less than 31 days", ->
    beforeEach ->
      $('select.month').val(9)
      $('select.month').trigger('change')

    it "Displays 30 days", ->
      available_days = $('select.day option').filter -> $(@).css("display") isnt "none"
      expect(available_days.length).toBe 30 + 1

  describe "Selecting February in a leap year", ->
    beforeEach ->
      $('select.year').val(2000)
      $('select.month').val(2)
      $('select.month').trigger('change')

    it "Displays 29 days", ->
      available_days = $('select.day option').filter -> $(@).css("display") isnt "none"
      expect(available_days.length).toBe 29 + 1

  describe "Changing month with an invalid day already selected", ->
    beforeEach ->
      $('select.day').val(31)

    it "Resets day", ->
      expect($('select.day option:selected').val()).toBe "31"
      $('select.month').val(2)
      $('select.month').trigger('change')
      expect($('select.day option:selected').val()).toBe ""
