/*
  Override the default confirm dialog
  defined by jQuery UJS
*/
$.rails.allowAction = function(link){
  if (link.data('confirm') == undefined){
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
$.rails.confirmed = function(link){
  link.data('confirm', null);
  if (link.data('method')){
    // let rails handle non-GET requests
    // (i.e. data-method="delete")
    return link.trigger('click.rails');
  }
  window.location.href = link.attr('href');
}

/*
  Toggle the Foundation reveal modal when a data-confirm
  element is clicked.
*/
$.rails.showConfirmationDialog = function(link){
  var el = link.data('confirm');
  $('[data-' + el + ']').foundation('open');
}

/*
  General Usage:
  Link
  <a href="somewhere" data-confirm="my-data-element">Delete</a>

  Modal
  <div class="reveal" data-reveal data-my-data-element>
    ...
    <a href="#" data-reveal-confirm="my-data-element">OK</a>
    ...
  </div>
*/
$(document).on('click', '*[data-reveal-confirm]', function(e){
  e.preventDefault();
  var el = $(e.currentTarget).data('reveal-confirm');
  var link = $('[data-confirm="'+ el + '"]');
  var modal = $('[data-' + el + ']');
  $(modal).foundation('close');
  $.rails.confirmed(link);
});
