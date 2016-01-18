Mailcheck.defaultDomains.push('xplore.com', 'abnorth.com', "pentnet.net", "canadasurf.net")

var $email = $('[type="email"]');
var $hint = $("*#email_hint");

$email.on('blur', function() {
  $(this).mailcheck({
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
