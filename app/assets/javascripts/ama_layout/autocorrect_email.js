var domains = ['msn.com', 'bellsouth.net', 'telus.net', 'comcast.net', 'optusnet.com.au', 'earthlink.net', 'qq.com',
                'sky.com', 'icloud.com', 'mac.com', 'sympatico.ca', 'googlemail.com', 'att.net', 'xtra.co.nz', 'web.de',
                'cox.net', 'gmail.com', 'ymail.com', 'aim.com', 'rogers.com', 'verizon.net', 'rocketmail.com',
                'google.com', 'optonline.net', 'sbcglobal.net', 'aol.com', 'me.com', 'btinternet.com', 'charter.net',
                'shaw.ca', 'xplore.com', 'abnorth.com', 'pentnet.net', 'canadasurf.net'];

var secondLevelDomains = ["yahoo", "hotmail", "mail", "live", "outlook", "gmx", "xplore", "abnorth", "pentnet", "canadasurf"];

var $email = $('[type="email"]');
var $hint = $("*#email_hint");

$email.on('blur', function() {
  $(this).mailcheck({
    domains: domains,                       // optional
    secondLevelDomains: secondLevelDomains, // optional
    suggested: function(element, suggestion) {
      var text = "Did you mean <span class='suggestion'>" +
        "<span class='address'>" + suggestion.address + "</span>" +
        "@<a href='#' class='email_domain'>" + suggestion.domain +
        "</a></span>?";

      element.parent().siblings("#email_hint").html(text).fadeIn(150);
    },
    empty: function(element) {
      element.parent().siblings("#email_hint").html("");
    }
  });
});

$hint.on('click', '.email_domain', function() {
  email_hint = $(this).parents("#email_hint");
  email = $(email_hint).siblings(".input.email").find("[type='email']")

  $(email).val($(".suggestion").first().text());

  $(email_hint).fadeOut(200, function() {
    $(this).empty();
  });
  return false;
});
