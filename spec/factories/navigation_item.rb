FactoryGirl.define do
  factory :navigation_item, class: AmaLayout::NavigationItem do
    text "Gotham Overview"
    icon "fa-tachometer"
    link "http://waffleemporium.ca/gotica"
    alt "Back to my dashboard"
  end
end
