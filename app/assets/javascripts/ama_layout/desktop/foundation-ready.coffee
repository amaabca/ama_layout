$ ->
  # Foundation equalizer does not play well with Accordion animations!
  Foundation.Accordion.defaults.slideSpeed = 0;
  $(document).foundation()
