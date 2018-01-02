$ ->
  current_url = window.location.href.split('?')[0];
  $("a[href='#{current_url}']").addClass('side-nav__child-link--active-page')
