window.onload = function(){
  var domains = ['msn.com', 'bellsouth.net', 'telus.net', 'comcast.net', 'optusnet.com.au', 'earthlink.net', 'qq.com',
                'sky.com', 'icloud.com', 'mac.com', 'sympatico.ca', 'googlemail.com', 'att.net', 'xtra.co.nz', 'web.de',
                'cox.net', 'gmail.com', 'ymail.com', 'aim.com', 'rogers.com', 'verizon.net', 'rocketmail.com',
                'google.com', 'optonline.net', 'sbcglobal.net', 'aol.com', 'me.com', 'btinternet.com', 'charter.net',
                'shaw.ca', 'xplore.com', 'abnorth.com', 'pentnet.net', 'canadasurf.net', "ama.ab.ca"];

  var secondLevelDomains = ["yahoo", "hotmail", "mail", "live", "outlook"]

  var $email = $('[type="email"]');

  $email.on('blur', function() {
    $(this).mailcheck({
      domains: domains,
      secondLevelDomains: secondLevelDomains,
      suggested: function(element, suggestion) {
        var text = "Did you mean <span class='suggestion'>" +
          "<span class='address'>" + suggestion.address + "</span>" +
          "@<a href='#' class='email_domain'>" + suggestion.domain +
          "</a></span>?";

        if (!$('.email_hint').length) {
          $('<div class="email_hint">' + text + '</div>').insertAfter(element).fadeIn(150);

        } else {
          $(".email_hint").html(text);
        }
      },
      empty: function(element) {
        $(".email_hint").html("");
      }
    });
  });


  $(document).on('click', '.email_hint .suggestion a.email_domain', function() {
    email_hint = $(this).parents(".email_hint");
    email = $(email_hint).prevAll('input[type=email]:last');

    $(email).val($(".suggestion").first().text());
    $(".email_hint").remove();

    return false;
  });
};
