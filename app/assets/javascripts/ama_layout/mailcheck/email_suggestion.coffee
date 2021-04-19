class AMALayout.EmailSuggestion
  constructor: () ->
    @domains = [
      'msn.com'
      'bellsouth.net'
      'telus.net'
      'telusplanet.net'
      'comcast.net'
      'optusnet.com.au'
      'earthlink.net'
      'qq.com'
      'sky.com'
      'icloud.com'
      'mac.com'
      'sympatico.ca'
      'googlemail.com'
      'att.net'
      'xtra.co.nz'
      'web.de'
      'cox.net'
      'gmail.com'
      'ymail.com'
      'aim.com'
      'rogers.com'
      'verizon.net'
      'rocketmail.com'
      'google.com'
      'optonline.net'
      'sbcglobal.net'
      'aol.com'
      'me.com'
      'btinternet.com'
      'charter.net'
      'shaw.ca'
      'xplore.com'
      'abnorth.com'
      'pentnet.net'
      'canadasurf.net'
      'ama.ab.ca'
    ]
    @secondLevelDomains = [
      'yahoo'
      'hotmail'
      'mail'
      'live'
      'outlook'
    ]
    @setupEvents()

  setupEvents: ->
    $('[type="email"]').on 'blur', (e) =>
      return if $(e.originalEvent.target).data('skip-email-suggestion')
      $(e.originalEvent.target).mailcheck
        domains: @domains
        secondLevelDomains: @secondLevelDomains
        suggested: (element, suggestion) =>
          event = @buildEvent()
          text = @suggestionMarkup suggestion.address, suggestion.domain
          if !$('.email_hint').length
            $("<div class='email_hint'>#{text}</div>").insertAfter(element).show()
          else
            $('.email_hint').html text
          window.dispatchEvent(event)
        empty: (element) =>
          event = @buildEvent()
          $('.email_hint').html ''
          window.dispatchEvent(event)

    $(document).on 'click', '.email_hint .suggestion a.email_domain', (e) =>
      @trackUsage()
      event = @buildEvent()
      email_hint = $(e.originalEvent.target).parents('.email_hint')
      email = $(email_hint).prevAll('input[type=email]:last')
      $(email).val $('.suggestion').first().text()
      $('.email_hint').remove()
      window.dispatchEvent(event)

  buildEvent: () ->
    if typeof(Event) is 'function'
      new Event('mailcheck')
    else
      document.createEvent('Event').initEvent('mailcheck', true, true)

  suggestionMarkup: (address, domain) ->
    "Did you mean " +
    "<span class='suggestion'>" +
      "<span class='address'>#{address}</span>" +
      "@<a href='#' class='email_domain'>#{domain}</a>" +
    "</span>?"

  trackUsage: () ->
    if window.dataLayer
      domain = $('.email_domain').text()
      dataLayer.push({ "email-pick" : domain })
