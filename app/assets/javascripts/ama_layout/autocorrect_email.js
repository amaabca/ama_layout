var $email = $('[type="email"]');
var $hint = $("*#email_hint");

$email.on('blur' , function() {
  $.each( $email, function( index, value ) {
    $.each( $hint, function( hint_index, hint_value) {
      $(value).mailcheck({
        suggested: function(element, suggestion) {
          var suggestion = "Did you mean <span class='suggestion'>" +
            "<span class='address'>" + suggestion.address + "</span>" +
            "@<a href='#' class='email_domain'>" + suggestion.domain +
            "</a></span>?";

          $($hint[hint_index]).html(suggestion).fadeIn(150);
        }
      });
    })

  });
});

$hint.on('click', '.email_domain', function() {
  $.each( $email, function( index, value ){
    $($email[index]).val($(".suggestion").first().text());
  });

  $hint.fadeOut(200, function() {
    $(this).empty();
  });
  return false;
});
