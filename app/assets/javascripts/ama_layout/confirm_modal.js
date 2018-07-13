/*
  Override the default confirm dialog
  defined by jQuery UJS
*/
$.rails.allowAction = function(link) {
  if (link.data('confirm') == undefined) {
    return true;
  }
  $.rails.showConfirmationDialog(link);
  return false;
}

/*
  Remove the data-confirm from the link so
  Rails doesn't re-trigger the modal. Then
  trigger a click of the link.
*/
$.rails.confirmed = function(link) {
  link.data('confirm', null);
  if (link.data('method')){
    // let rails handle non-GET requests
    // (i.e. data-method="delete")
    return link.trigger('click.rails');
  }
  if (link.attr('href')) {
    window.location.href = link.attr('href');
  }
}

/*
  Toggle the Foundation reveal modal when a data-confirm
  element is clicked.
*/
$.rails.showConfirmationDialog = function(link) {
  var el = link.data('confirm');
  var modal = $('[data-' + el + ']');
  var key = link.data('reveal-confirm-key');
  if (key && key.length) {
    modal.data('reveal-confirm-key', key);
  }
  modal.foundation('open');
}

/*
  Single Link/Single Modal:

  Link
  <a href="somewhere" data-confirm="my-data-element">Delete</a>

  Modal
  <div class="reveal" data-reveal data-my-data-element>
    ...
    <a href="#" data-reveal-confirm="my-data-element">OK</a>
    ...
  </div>

  Multiple Links/Single Modal:

  Links
  <a href="somewhere" data-confirm="my-data-element" data-reveal-confirm-key="element-1">Delete</a>
  <a href="somewhere-else" data-confirm="my-data-element" data-reveal-confirm-key="element-2">Delete</a>

  Modal
  <div class="reveal" data-reveal data-my-data-element>
    ...
    <a href="#" data-reveal-confirm="my-data-element">OK</a>
    ...
  </div>
*/
$(document).on('click', '*[data-reveal-confirm]', function(e) {
  e.preventDefault();
  var target = e.currentTarget;
  var el = $(target).data('reveal-confirm');
  var modal = $('[data-' + el + ']');
  var key = $(modal).data('reveal-confirm-key');
  var link = $('[data-confirm="'+ el + '"]');
  if (key && key.length) {
    link = $('[data-reveal-confirm-key=' + key + ']');
  }
  $(modal).foundation('close');
  $(modal).data('reveal-confirm-key', null);
  $.rails.confirmed(link);
});
