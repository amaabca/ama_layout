# AmaLayout

The AmaLayout gem is used to add a standard layout and style to .ama.ab.ca sites.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ama_layout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ama_layout

## Usage

### Configuration

Ensure that the app responds to:

Rails.configuration.gatekeeper_site

Rails.configuration.youraccount_site

Rails.configuration.insurance_site

### Layout

The following layout example will give you a header, left nav and footer consistent with .ama.ab.ca sites.

    <body class="<%= controller_name %>" id="top">
      <div class="container-fluid">
        <%= render partial: "ama_layout/header", locals: { logged_in: current_user } %>
        <div class="waiting"></div>
        <%= render "ama_layout/menuleft" %>
        <div class="grid-9 appcontent collapse omega">
          <%= yield %>
        </div>
        <%= render partial: "ama_layout/footer" %>
      </div>
    </body>

### Stylesheets

Add the following to your application.scss

    @import "foundation/application";

### Javascript

Add the following to your application.js

    //= require ama_layout/desktop

### Mobile Layouts

AmaLayout supports mobile layouts using the mobylette gem.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ama_layout/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create rspec tests to cover your feature (100% coverage required)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
